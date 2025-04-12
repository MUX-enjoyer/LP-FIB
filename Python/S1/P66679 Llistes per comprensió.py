# Escriviu una funció my_map(f, L) que correspongui a una nova definició
# de la funció estàndard map tot usant llistes per comprensió.
def my_map(f, L):
    return [f(i) for i in L]

# Escriviu una funció my_filter(f, L) que correspongui a una nova definició
# de la funció estàndard filter tot usant llistes per comprensió.
def my_filter(f, L):
    return [i for i in L if f(i)]

# Escriviu una funció factors(n) que, donat un enter estrictament positiu,
# retorni la llista amb els seus factors (no necessàriament primers).
def factors(n):
    return [i for i in range(1, n+1) if n % i == 0]

# Escriviu una funció triplets(n) que, donat un enter estrictament positiu n,
# retorni una llista de totes les tripletes pitagòriques de n, és a dir,
# tripletes (a, b, c) on a2 + b2 = c2 amb 1≤ a, b, c ≤ n.
def triplets(n):
    return [(a,b,c)
            for a in range(1, n+1)
            for b in range(1, n+1)
            for c in range(1, n+1)
            if a*a+b*b==c*c]