#!/usr/bin/python3
import sys

file = sys.argv[1]
fileF = file + "_gen"

# NOMBRE: David Grande
f = open(file, "r")
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
        print("[-] Error al generar usuarios, revisa el archivo: "+file)
        exit()


with open(fileF, 'w') as f:
    f.write('\n'.join(nombres))

print("[+] Usuarios generados correctamente")
print("[+] Archivo: "+fileF)
