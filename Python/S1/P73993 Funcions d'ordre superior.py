from functools import reduce


# Feu una funció evens_product(L) que multiplica
# tots el nombres parells d’una llista d’enters.
def evens_product(L):
    return reduce(lambda acc, x: acc*x if x % 2 == 0 else acc, L, 1)

# Feu una funció reverse(L) que inverteix els elements
# d’una llista usant la funció reduce.
def reverse(L):
    return reduce(lambda acc, x: [x]+acc, L, [])

# Definiu una funció d’ordre superior zip_with(f, L1, L2)
# equivalent al ZipWith de Haskell.
def zip_with(f, L1, L2):
    return list(map(lambda xy: f(xy[0], xy[1]), zip(L1, L2)))

# Feu una funció count_if (f, L) que, donada una propietat
# (funció que donat un element retorna un booleà) i una llista,
# ens retorna el nombre d’elements de la llista que satisfan la propietat.
# Noteu que aquesta funció d’ordre superior existeix en llenguatges
# de tractament de fulls de càlcul com ara EXCEL.
def count_if(f, L):
    return len(list(filter(f, L)))