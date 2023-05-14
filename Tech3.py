import re
import sys

#Quita los subdominios www o ww2
def newDomain(domain):
    splits = domain.split('.')
    if splits[0] == 'www' or splits[0] == 'ww2' :
        splits.pop(0)
        return '.'.join(splits)
    return domain 

def main():
    #Verifica que hayan argumentos de entrada
    if len(sys.argv) >=3:
        #Obtiene la cantidad de lineas del HTML
        N = sys.argv[1]
        #Leer el archivo pasado por argumento de ejecución
        with open(sys.argv[2], 'r') as f:
            #Encontrar con regex las urls en el HTML
            urls = re.findall('https?://[\w\.]+\/',f.read())
            if len(urls) > 0:
                #Quitar duplicados
                urls = list(dict.fromkeys(urls))
                domains = map(lambda x: x.split('//')[1][:-1], urls)
                newdomains = map(newDomain, domains)
                sortdomains = sorted(list(newdomains))
                #Unir cada dominio con ; en una linea
                res = ';'.join(sortdomains)
                print(res)
            else:
                print("No se detectaron URLs en el archivo")
    else:
        raise Exception("Faltan establecer argumentos de entrada")

main()
