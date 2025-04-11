from math import sqrt, ceil

# Feu una funció absValue(x) que, donat un nombre, retorni el seu valor absolut.
def absValue(x):
    if x >= 0:
        return x
    else:
        return -x

# Feu una funció power(x, p) que, donats un nombre x i un natural p, retorni x elevat a p, és a dir, xp.
def power(x, p):
    #return x**p
    if p == 0: return 1
    return x * power(x, p-1)

# Feu una funció isPrime(x) que, donat un natural, retorni un booleà indicant si aquest és primer o no.
def isPrime(x):
    if x <= 1: return False
    for i in range(2, int(sqrt(x)) + 1): 
        if x % i == 0: return False
    return True

# Feu una funció slowFib(n) que retorni l’n-èsim element de la sèrie de Fibonacci tot utilitzant l’algorisme recursiu que la defineix (f(0)=0, f(1)=1, f(n)=f(n−1)+f(n−2) per n≥ 2).
def slowFib(n):
    if n == 0: return 0
    if n == 1: return 1
    return slowFib(n-1) + slowFib(n-2)

# Feu una funció quickFib(n) que retorni l’n-èsim element de la sèrie de Fibonacci tot utilitzant un algorisme més eficient.
def quickFib(n):
    if n == 0: return 0
    count = 1
    fib1 = 0
    fib2 = 1
    while (count<n):
        fib1, fib2 = fib2, fib1+fib2
        count += 1
    return fib2