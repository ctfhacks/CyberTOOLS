#!/usr/bin/python3
import sys

def help():
    print('\n [*] Command:')
    print(' \033[1m     python3 usersGen.py users.txt\033[0m \n')
    print(' [*] Example users.txt: ')
    print('      \033[1mDavid Grande\033[0m')
    print('      \033[1mDave Simpson\033[0m')
    print('      \033[1mSierra Frye\033[0m')
    


try:
    file = sys.argv[1]
    fileF = file + "_gen"
except:
    help()
    exit()

# NOMBRE: David Grande
try:
    f = open(file, "r")
except:
    print("\n[-] El archivo "+file+" no existe.")
    help()
    exit()
nombres = []
for nom in f:
    
    try:
        nom = nom.rstrip()
        nom1 = nom.split(' ')
        nombres.append(nom1[0]) # David
        nombres.append(nom1[1]) # Grande
        nombres.append(nom1[0] + nom1[1]) # DavidGrande
        nombres.append(nom1[0][0] + nom1[1]) # DGrande
        nombres.append(nom1[0] + nom1[1][0]) # DavidG

        nombres.append(nom1[0] + '.' + nom1[1]) # David.Grande
        nombres.append(nom1[0][0] + '.' + nom1[1]) # D.Grande
        nombres.append(nom1[0] + '.' +nom1[1][0]) # David.G

        nombres.append(nom1[0] + '_' + nom1[1]) # David_Grande
        nombres.append(nom1[0][0] + '_' + nom1[1]) # D_Grande
        nombres.append(nom1[0] + '_' +nom1[1][0]) # David_G
    except:
        print("\n[-] Error al generar usuarios, revisa el archivo: "+file)
        help()
        exit()
    

with open(fileF, 'w') as f:
    f.write('\n'.join(nombres))

print("[+] Usuarios generados correctamente")
print("[+] Archivo: "+fileF)
