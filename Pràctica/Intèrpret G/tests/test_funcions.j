NB. Test de definicio i composicio de funcions

NB. Funcio quadrat amb aplicacio
quadrat =: *:
aplicacio_quadrat =: quadrat (1 + i. 3)
NB. aplicacio_quadrat: 1 4 9

NB. Predicat de parell amb composicio
mod2 =: 2 | ]
eq0 =: 0 = ]
es_parell1 =: eq0 @: mod2
test_parell1 =: es_parell1 i. 6
NB. test_parell1: 1 0 1 0 1 0

es_parell2 =: 0 = ] @: 2 | ]
test_parell2 =: es_parell2 i. 6
NB. test_parell2: 1 0 1 0 1 0

NB. Funcio amb fold i composicio
suma_increment =: +/ @: (1 + ])
test_suma =: suma_increment i. 4
NB. test_suma: 10

NB. Factorial simple
factorial =: */ @: (1 + i.)
test_factorial =: factorial 4
NB. test_factorial: 24

NB. Composicions complexes
complex =: *: @: (2 + ]) @: (i.)
test_complex =: complex 3
NB. test_complex: 4 9 16

NB. Funcions amb vectors buits i petits
test_buit =: +/ i. 0
test_petit =: *: 5
NB. test_buit: 0, test_petit: 25

main =: aplicacio_quadrat, test_parell1, test_parell2, test_suma, test_factorial, test_complex, test_buit, test_petit
NB. Esperat: 1 4 9 1 0 1 0 1 0 1 0 1 0 1 0 10 24 4 9 16 0 25