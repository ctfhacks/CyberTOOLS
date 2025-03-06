#!/bin/bash
# Script para verificar la seguridad de un sitio WordPress

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

url=""
output=""

# -----------------------------------------------------
# Menú de ayuda
ayuda(){
    echo -e "${Color_Off}"
    echo -e "            [¿] Menú de ayuda [?]"
    echo -e "==============================================="
    echo -e "$0 -u <URL>"
    echo -e "$0 -u https://wordpress.com"
    echo -e ""
    exit 1
}

# -----------------------------------------------------
# Vulnerable ataque DDOS
ddos(){
  echo -e "\n${BCyan}Comprobando vulnerabilidad a ataques DDOS ${Color_Off}\n"
  ddos_url="$url/xmlrpc.php"
  # Se obtiene el código HTTP de la respuesta
  loginXML=$(curl -s -X POST "$ddos_url" \
    -H "Content-Type: text/xml" \
    -d '<?xml version="1.0" encoding="utf-8"?><methodCall><methodName>system.listMethods</methodName><params></params></methodCall>')

  if echo "$loginXML" | grep -qi "system.multicall"; then
    echo -e "${Green} [+] Método system.multicall habilitado ${Color_Off}\n"
  else
    echo -e "${Red} [-] Método system.multicall deshabilitado ${Color_Off}\n"
  fi

  if echo "$loginXML" | grep -qi "pingback.ping"; then
    echo -e "${Green} [+] Método pingback.ping habilitado ${Color_Off}"
  else
    echo -e "${Red} [-] Método pingback.ping deshabilitado ${Color_Off}"
  fi
}

# -----------------------------------------------------
# Vulnerable ataque SSRF
ssrf(){
  echo -e "\n${BCyan}Comprobando vulnerabilidad SSRF ${Color_Off}\n"
  ssrf_url="$url/wp-json/oembed/1.0/proxy?url=https://google.com/"
  # Se obtiene el contenido de la URL
  response=$(curl -s "$ssrf_url")
  status=$(curl -s -o /dev/null -w "%{http_code}" "$ssrf_url")


  if echo "$response" | grep -qi "rest_forbidden" || [[ $(echo "$response" | wc -c) -lt 100 ]] || [[ $status -eq 401 ]] || [[ $status -eq 403 ]]; then
    echo -e "${Red} [-] Petición oEmbed protegida ${BRed}$ssrf_url${Color_Off} (STATUS: $status) \n"
  else
    echo -e "${Green} [+] Petición oEmbed permitida ${BGreen}$ssrf_url${Color_Off} (STATUS: $status) \n"
  fi
  echo -e "\n"
}

# -------------------------------------------------------------
# Verifica XML RPC
xmlrpc(){
  echo -e "\n${BCyan}Verificando el archivo /xmlrpc.php...${Color_Off}\n"
  xmlrpc_url="$url/xmlrpc.php"
  # Se obtiene el código HTTP de la respuesta
  response=$(curl -s -o /dev/null -w "%{http_code}" "$xmlrpc_url")
  loginXML=$(curl -s -X POST "$xmlrpc_url" \
    -H "Content-Type: text/xml" \
    -d '<?xml version="1.0"?><methodCall><methodName>wp.getUsersBlogs</methodName><params><param><value><string>admin</string></value></param><param><value><string>admin</string></value></param></params></methodCall>')

  if [[ $(echo "$loginXML" | wc -c) -gt 100 ]]; then
    echo -e "${Yellow} [!] ${BYellow}$xmlrpc_url${Color_Off}${Yellow} ${Color_Off} (STATUS: $response) \n"
    echo -e "${Yellow} [!] Probando login con XMLRPC (admin:admin) ${Color_Off}"
    echo -e "$loginXML" | grep '<value><string>' | sed 's/^[[:space:]]*//'
    ddos  # Llama a la función DDOS
  else
    echo -e "${Red} [-] ${BRed}$xmlrpc_url${Color_Off}${Red} XMLRPC protegido ${Color_Off} (STATUS: $response)"
  fi
  echo -e "\n\n"
}

# -----------------------------------------------------------
# Array con las rutas a verificar para directory listing
directoryList(){
  directories=( "/wp-content/" "/wp-content/plugins/" "/wp-content/mu-plugins/" "/wp-content/uploads/" "/wp-includes/" )

  echo -e "\n${BCyan}Verificando directory listing en rutas específicas...${Color_Off}"
  for dir in "${directories[@]}"; do
      full_url="$url$dir" 
      # Descarga el contenido de la URL
      content=$(curl -s "$full_url")
      status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")

      if echo "$content" | grep -qi "Parent Directory"; then
        echo -e "\n${Green} [+] ${BGreen}$full_url${Color_Off}${Green} tiene directory listing habilitado. ${Color_Off} (STATUS: $status)"
      else
        echo -e "\n${Red} [-] ${BRed}$full_url${Color_Off}${Red} no tiene directory listing. ${Color_Off} (STATUS: $status)"
      fi
  done
  echo -e "\n\n"
}

# --------------------------------------------------------
# Acceso al panel de Admin
accesoPanel(){
  echo -e "\n${BCyan}Panel de Admin ${Color_Off}"
  full_url="$url/wp-admin/"
  status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
  if [[ $status -eq 403 ]]; then
    echo -e "\n${Red} [-] Acceso denegado a ${BRed}$full_url${Color_Off} (STATUS: $status)"
  else
    echo -e "\n${Yellow} [?] Posible acceso permitido a ${BYellow}$full_url${Color_Off} (STATUS: $status)"
  fi
  echo -e "\n"
}

# --------------------------------------------------------
# Acceso al panel de Login, Robots...
accesoArchivos(){
  echo -e "\n${BCyan}Panel de login, robots.txt ${Color_Off}"
  archivos=("/wp-login.php" "/robots.txt" )
  for archivo in "${archivos[@]}"; do
    full_url="$url$archivo"
    status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
    response=$(curl -L -s "$full_url")

    if [[ $status -eq 200 ]] || echo $response | grep -qi "sitemap_index.xml"; then
      echo -e "\n${Green} [+] Archivo existente. ${BGreen}$full_url${Color_Off} (STATUS: $status)"
    else
      echo -e "\n${Red} [-] No se ha encontrado ${BRed}$full_url${Color_Off} (STATUS: $status)"
    fi
  done
  echo -e "\n"
}

# -------------------------------------------------------
# Enumerar usuarios con /wp-json/
usuarios(){
  echo -e "\n${BCyan}Enumeración de usuarios /wp-json/wp/v2/users ${Color_Off}"
  full_url="$url/wp-json/wp/v2/users"
  wp_json=$(curl -s "$full_url")
  status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")

  if echo "$wp_json" | grep -qi "author" && echo "$wp_json" | grep -qi "yoast_head"; then
    echo -e "\n${Green} [+] Archivo existente ${BGreen}$full_url${Color_Off}${Green} "
    usuarios=$(curl -s "$full_url" | jq -r '.[].name')
    echo -e "\n${Green} [+] Usuarios encontrados:${Color_Off}\n"
    echo "$usuarios"
  else
    echo -e "\n${Red} [-] No existe o no tienes permiso ${BRed}$full_url${Color_Off} (STATUS: $status) "
  fi
  echo -e "\n\n"
}

# -------------------------------------------------------
# Ejecutar WPSCAN
wpscan_exec(){
  echo -e "\n${BCyan}Ejecutando WPSCAN ${Color_Off}\n"
  echo -e "${BGreen}[*] wpscan --url ${BGreen}$url${Color_Off}${BGreen} --force --disable-tls-checks --stealthy ${Color_Off}\n"
  wpscan --url "$url" --force --disable-tls-checks --stealthy
}

inicio(){
echo -e '
 _    _ ______  _____  _____  _____  _   _ ______  _____  _____ __   __
| |  | || ___ \/  ___||  ___|/  __ \| | | || ___ \|_   _||_   _|\ \ / /
| |  | || |_/ /\ `--. | |__  | /  \/| | | || |_/ /  | |    | |   \ V / 
| |/\| ||  __/  `--. \|  __| | |    | | | ||    /   | |    | |    \ /  
\  /\  /| |    /\__/ /| |___ | \__/\| |_| || |\ \  _| |_   | |    | |  
 \/  \/ \_|    \____/ \____/  \____/ \___/ \_| \_| \___/   \_/    \_/  
                                                                       
'
                                                                                      
echo -e "${BWhite} Version: 0.0 ${Color_Off} \n"

}

inicio

# Comienzo del programa

# Procesa los argumentos con getopts
while getopts "u:o:" opt; do
  case $opt in
    u)
      url="$OPTARG"
      ;;
    o)
      output="$OPTARG"
      ;;
    \?)
      ayuda;;
    :)
      echo "La opción -$OPTARG requiere un argumento." >&2
      ayuda;;
  esac
done

# Verifica que se haya proporcionado la URL
if [ -z "$url" ]; then
  ayuda
fi

echo -e "\n${Cyan} [#] La URL es: ${BCyan}$url ${Color_Off}\n"
# Elimina la barra final si existe para evitar errores
url=${url%/}

## FUNCIONES:
xmlrpc
directoryList
accesoPanel
accesoArchivos
ssrf
usuarios
wpscan_exec
