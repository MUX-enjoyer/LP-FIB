# Escriviu una funció count_unique(L) que indiqui
# quants elements únics té una llista L.
def count_unique(L):
    return len(set(L))

# Escriviu una funció remove_duplicates(L) que retorni
# els elements d’una llista sense repeticions. L’ordre no importa.
def remove_duplicates(L):
    return list(set(L))

# Escriviu una funció flatten(L) que aplani una
# llista de llistes d’elements produint una llista d’elements.
def flatten(L):
    return sum(L, [])

# Milloreu l’apartat anterior fent una funció flatten_rec(L)
# que pugui tractar llistes amb diferents nivells.
# Pista: feu-la recursiva usant la funció estàndard isinstance.
def flatten_rec(L):
    if not L: return []
    if isinstance(L[0], list):
        return flatten_rec(L[0]) + flatten_rec(L[1:])
    return [L[0]] + flatten_rec(L[1:])