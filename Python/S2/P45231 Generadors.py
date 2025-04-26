# Escriviu un generador fibs() per als nombres de la sèrie de Fibonacci.
def fibs():
    a = 0
    yield a
    b = 1
    while True:
        yield b
        a, b = b, a + b

# Escriviu un generador roots(x) per als nombres del desenvolupament
# de Taylor per calcular l’arrel quadrada d’un real x≥0:
def roots(x):
    yield x
    xn = x
    while True:
        xn = 1/2*(xn+x/xn)
        yield xn

# Escriviu un generador primes() per als nombres primers.
def primes():
    n = 1
    while True:
        n = n + 1
        primer = True
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                primer = False
                break
        if primer:
            yield n

# Escriviu un generador hammings() per als nombres de Hamming.
# Els nombres de Hamming són aquells que només tenen 2, 3 i 5 com a divisors primers.
def hammings():
    def esHamming(n):
        if n == 1: return True
        if n % 2 == 0: return esHamming(n/2)
        if n % 3 == 0: return esHamming(n/3)
        if n % 5 == 0: return esHamming(n/5)
        return False
    n = 1
    yield n
    while True:
        n += 1
        if esHamming(n): yield n