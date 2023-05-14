import sys
import re

#Encuentra las letras minusculas y mayusculas para ordenarlas y unirlas
def joinLetters(S):
    res = ''
    low = re.findall('[a-z]', S)
    up = re.findall('[A-Z]', S)
    res += ''.join(sorted(low))
    res += ''.join(sorted(up))
    return res

#Encuentra los números impares y pares para ordenarlos y unirlos
def joinNumbers(S):
    res = ''
    Scharnumbers =list(filter(lambda x: x.isnumeric(), list(S)))
    Snumbers = list(map(lambda x: int(x), Scharnumbers))
    Sodd = filter(lambda x: x % 2 == 1, list(Snumbers))
    Seven = filter(lambda x: x % 2 == 0, list(Snumbers))
    SoddOrdered =  map(lambda x: str(x), sorted(list(Sodd)))
    SevenOrdered = map(lambda x: str(x), sorted(list(Seven)))
    res += ''.join(list(SoddOrdered))
    res += ''.join(list(SevenOrdered))
    return res
    
def main():
    #Obtiene la cadena pasada por parametro de ejecución
    if len(sys.argv) >=2:
        S = sys.argv[1]
        answer = ''
        #Verifica que cumpla con la restricción
        if len(S) < 1000 and len(S) > 0:
            answer = joinLetters(S)
            answer += joinNumbers(S)
            print(answer)
        else:
            raise Exception('Cadena no valida')
    else:
        raise Exception("Faltan establecer argumentos de entrada")


main()
