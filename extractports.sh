#!/bin/bash

#echo -n "Nombre archivo: "
#read nom_file
nom_file=$@
tcp=""
udp=""
all_ports=""
ip=""

while IFS= read -r line
do
  #echo "$line"

  if [[ "$line" == *"Host"* && ${ip[@]} -eq 0 ]] > /dev/null 2>&1
  then 

    IFS='()'
    read -a array_host <<< "$line"
    ip=${array_host[0]}

  fi


  if [[ "$line" == *"Ports"* && "$line" == *"/"* ]]; then
   # echo "OK"

    # Set comma as delimiter
    IFS=':'
    read -a array_1 <<< "$line" # DIVIDE EL STRING EN ARRAY

    IFS=','
    read -a array_2 <<< "${array_1[2]}"
    len=${#array_2[@]}


    for (( i=0; i<${len}; i++ )) # RECORRE EL ARRAY 
    do

      IFS='/'
      read -a array_3 <<< "${array_2[$i]}"

      # PUERTOS TCP

      if [[ "${array_3[1]}" == "open" && "${array_3[2]}" == "tcp" ]]; then
        
        if [[ ${tcp[@]} -eq 0 ]]; then
          tcp="${array_3[0]}"
          tcp=$(echo "$tcp" | tr -d '[[:space:]]')
        else 
          tcp="$tcp,${array_3[0]}"
          tcp=$(echo "$tcp" | tr -d '[[:space:]]')
        fi

      fi

      # PUERTOS UDP

      if [[ "${array_3[1]}" == "open" && "${array_3[2]}" == "udp" ]]; then
        
        if [[ ${udp[@]} -eq 0 ]]; then
          udp="${array_3[0]}"
          udp=$(echo "$udp" | tr -d '[[:space:]]')
        else 
          udp="$udp,${array_3[0]}"
          udp=$(echo "$udp" | tr -d '[[:space:]]')
        fi

      fi

      # CONTINUA AQUÍ
      
    done

    echo " [+] $ip" > "${nom_file}_ep"
    echo "  [-] TCP: $tcp" >> "${nom_file}_ep"
    echo $tcp
    echo "  [-] UDP: $udp" >> "${nom_file}_ep"
    echo $udp 
    if [[ ${tcp[@]} -eq 0 || ${udp[@]} -eq 0 ]]; then
      if [[ ${tcp[@]} -eq 0 ]]; then
        echo "$udp"|tr --delete '\n'|xclip -selection clipboard
      else
        echo "$tcp"|tr --delete '\n'|xclip -selection clipboard
      fi
  
    else
      echo " [*] ALL PORTS: $tcp,$udp" >> "${nom_file}_ep"
      echo "$tcp,$udp"|tr --delete '\n'|xclip -selection clipboard
      echo " [*] ALL PORTS: $tcp,$udp"
    fi

  fi
done < $nom_file
