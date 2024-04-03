#!/bin/bash

echo "[1] Rockyou.txt"
echo "[2] names.txt"
echo "[3] subdomains-top1million-110000.txt"
echo "[4] directory-list-lowercase-2.3-medium.txt"
echo "[5] PHP.fuzz.txt"
echo "[6] SQL.txt"
echo "[7] directory-list-2.3-medium.txt 2.0"
echo "[8] IIS.fuzz.txt"
echo "[9] Apache.fuzz.txt"
echo "[10] A-Z.Surnames.txt"
echo "[11] A-ZSurnames.txt"
echo "[12] Surnames_Top_500.txt"
echo "[13] xato-net-10-million-usernames.txt"

echo ""
echo -n "[*] Número: "
read num

if [[ num -eq 1 ]]
then
    echo "/home/kali/diccionarios/pass/Passwords/rockyou.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/pass/Passwords/rockyou.txt"
fi

if [[ num -eq 2 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Usernames/Names/names.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Usernames/Names/names.txt"
fi

if [[ num -eq 3 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/DNS/subdomains-top1million-110000.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/DNS/subdomains-top1million-110000.txt"
fi

if [[ num -eq 4 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt"
fi

if [[ num -eq 5 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/PHP.fuzz.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/PHP.fuzz.txt"
fi

if [[ num -eq 6 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/otros/SQL.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/otros/SQL.txt"
fi

if [[ num -eq 7 ]]
then
    echo "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
fi

if [[ num -eq 8 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/IIS.fuzz.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/IIS.fuzz.txt"
fi

if [[ num -eq 9 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/Apache.fuzz.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Discovery/Web-Content/Apache.fuzz.txt"
fi

if [[ num -eq 10 ]]
then
    echo "/home/kali/diccionarios/users/kerberos_enum_userlists/A-Z.Surnames.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/users/kerberos_enum_userlists/A-Z.Surnames.txt"
fi

if [[ num -eq 11 ]]
then
    echo "/home/kali/diccionarios/users/kerberos_enum_userlists/A-ZSurnames.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/users/kerberos_enum_userlists/A-ZSurnames.txt"
fi

if [[ num -eq 12 ]]
then
    echo "/home/kali/diccionarios/users/kerberos_enum_userlists/Surnames_Top_500.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/users/kerberos_enum_userlists/Surnames_Top_500.txt"
fi

if [[ num -eq 13 ]]
then
    echo "/home/kali/diccionarios/otros/SecLists/Usernames/xato-net-10-million-usernames.txt"|tr --delete '\n'|xclip -selection clipboard
    echo "/home/kali/diccionarios/otros/SecLists/Usernames/xato-net-10-million-usernames.txt"
fi
