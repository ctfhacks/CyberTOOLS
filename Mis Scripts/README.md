
# Mis Scripts

Estos son mis pequeños scripts que he creado, son muy útiles para ahorrarte tiempo en ciertas tareas repetitivas como convertirte en root.


## usersGen.py
Este programa genera a partir de una lista de usuarios combinaciones con su nombre y apellido, por ejemplo:<br>
**David Grande**:


|  Combinación 1             | Combinación 2                     | Combinación 3                                           |
| ----------------- | --------------------|---------------------------------------------- |
| David.G | David_Grande | DavidGrande
| D.Grande| D_Grande | DGrande
| David.Grande | David_G | DavidG


Esto es útil para enumerar usuarios principalmente en **Diretorio Activo**, aunque puede usarse para cualquier otro contexto.


## diccionarios.sh
Con este script puedes obtener las rutas de tus diccionarios más rapidamente.

```
┌──(root㉿kali)-[/home/kali]
└─# diccionarios.sh                  
[1] Rockyou.txt
[2] names.txt
[3] subdomains-top1million-110000.txt
[4] directory-list-lowercase-2.3-medium.txt
[5] PHP.fuzz.txt
[6] SQL.txt
[7] directory-list-2.3-medium.txt 2.0
[8] IIS.fuzz.txt
[9] Apache.fuzz.txt
[10] A-Z.Surnames.txt
[11] A-ZSurnames.txt
[12] Surnames_Top_500.txt
[13] xato-net-10-million-usernames.txt

[*] Número: 7
/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

```

## R
Te conviertes en **ROOT** con solamente ejecutar 'R', esto es muy útil para convertirse rapidamente en este usuario aunque es **MUY INSEGURO**, solo utilizar en máquinas virtuales en las que no haya datos importantes.

```
┌──(kali㉿kali)-[~]
└─$ R
┌──(root㉿kali)-[/home/kali]
└─# whoami                                                                             
root
```
