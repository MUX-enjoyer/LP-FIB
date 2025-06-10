NB. Test d'aritmetica basica

NB. Operacions amb zeros i unitats
zeros =: (0 + 5), (5 * 0), (0 % 1)
NB. zeros: 5 0 0
units =: (5 * 1), (5 % 1), (1 ^ 10)
NB. units: 5 5 1

NB. Potencies especials i casos limit
potencies =: (0 ^ 5), (1 ^ 0), (5 ^ 0), (2 ^ 10)
NB. potencies: 0 1 1 1024

NB. Negatius i operacions complexes
negatives =: (_5 + _3), (_5 - _3), (_5 * _3), (_12 % _3)
NB. negatives: -8 -2 15 4

NB. Modul amb casos representatius
moduls =: (3 | 10), (7 | 15), (5 | 17), (4 | 20)
NB. moduls: 1 1 2 0

NB. Precedencia d'operadors
precedencia =: (2 + 3 * 4), ((2 + 3) * 4), (2 * 3 + 4 * 5), (2 ^ 3 + 1)
NB. precedencia: 14 20 26 9

NB. Cadenes d'operacions amb fold
cadenes =: (+/ 1 2 3 4 5), (*/ 2 3 4), (%/ 16 4 2)
NB. cadenes: 15 24 2

NB. Casos limit aritmetics
limits =: (1 + 0), (0 * 999), (_1 ^ 2), (1 % 1)
NB. limits: 1 0 1 1

main =: zeros, units, potencies, negatives, moduls, precedencia, cadenes, limits
NB. Esperat: 5 0 0 5 5 1 0 1 1 1024 -8 -2 15 4 1 1 2 0 14 20 26 9 15 24 2 1 0 1 1