#!/usr/bin/python3
file = input(" Nombre archivo: ")
# NOMBRE: David Grande
f = open(file, "r")
nombres = []
for nom in f:
    nom = nom.rstrip()
    print((nom))
    nom1 = nom.split(' ')
    print((nom1))
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



print(nombres)
with open('users_gen.txt', 'w') as f:
    f.write('\n'.join(nombres))
