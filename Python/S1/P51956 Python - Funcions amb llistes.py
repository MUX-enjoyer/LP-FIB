from math import sqrt

# Feu una funció myLength(L) que, donada una llista, retorni la seva llargada.
def myLength(L):
    lenght = 0
    for i in L:
        lenght += 1
    return lenght

# Feu una funció myMaximum(L) que, donada una llista no buida, retorni el seu màxim.
def myMaximum(L):
    max = L[0]
    for i in L[1:]:
        if i > max: max = i
    return max

# Feu una funció average(L) que, donada una llista de nombres no buida, retorni la seva mitjana.
def average(L):
    sum = 0
    for i in L:
        sum += i
    return sum/myLength(L)

# Feu una funció buildPalindrome(L) que, donada una llista,
# retorni el palíndrom que comença amb la llista invertida.
def buildPalindrome(L):
    return L[::-1] + L

# Feu una funció remove(L1, L2) que donada una llista L1 i una llista L2,
# retorna la llista L1 havent eliminat totes les ocurrències dels elements en L2.
def remove(L1, L2):
    L = []
    for i in L1:
        if not i in L2:
            L.append(i)
    return L

# Feu una funció flatten(L) que aplana recursivament una llista d’elements
# que també poden ser llistes amb diferents nivells.
# Pista: feu-la recursiva usant isinstance(x, list).
def flatten(L):
    result = []
    for i in L:
        if isinstance(i, list):
            result.extend(flatten(i))
        else:
            result.append(i)
    return result

# Feu una funció oddsNevens(L) que, donada una llista d’enters, retorni dues llistes,
# una que conté els senars i una que conté els parells, en el mateix ordre relatiu que a l’original.
def oddsNevens(L):
    odds = []
    evens = []
    for i in L:
        if i%2 == 1:
            odds.append(i)
        else:
            evens.append(i)
    return (odds, evens)

# Feu una funció primeDivisors(n) que retorni la llista de divisors primers d’un enter estrictament positiu.
def isPrime(x):
    if x <= 1: return False
    for i in range(2,int(sqrt(x)+1)): 
        if x%i==0: return False
    return True
def primeDivisors(n):
    if isPrime(n):
        return [n]

    div = []
    for i in range(2, int(sqrt(n) + 1)):
        if n % i == 0:
            if isPrime(i):
                div.append(i)
            comp = n // i
            if i != comp and isPrime(comp):
                div.append(comp)
    return sorted(div)