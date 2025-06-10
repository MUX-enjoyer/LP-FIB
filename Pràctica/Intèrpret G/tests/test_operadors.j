NB. Test d'operadors

NB. Funcio identitat i casos basics
identitat =: (] 42), (] _42)
NB. identitat: 42 -42

NB. Concatenacio de vectors i casos limit
concatenacio =: (1 , 2 3), (1 2 , 3 4 5), (i. 0) , (1 2)
NB. concatenacio: 1 2 3 1 2 3 4 5 1 2

NB. Mida de vectors i casos limit
mides =: (# 1 2), (# i. 0), (# 42)
NB. mides: 2 0 1

NB. Filtre amb mascares
filtres =: (1 0 1 0 # 1 2 3 4), ((i. 4) > 1) # (i. 4)
NB. filtres: 1 3 2 3

NB. Acces per index amb casos basics i limits
indexos =: (0 2 { 2 3 4), ((i. 2) { 5 6 7 8)
NB. indexos: 2 4 5 6

NB. Generacio de rangs
rangs =: (i. 4), (5 + i. 3)
NB. rangs: 0 1 2 3 5 6 7

NB. Operador unari amb duplicacio
duplicacio =: (+: 1 2 3), (*: 2 3)
NB. duplicacio: 2 4 6 4 9

NB. Fold amb operacions i casos limit
folds =: (+/ 1 2 3), (*/ 1 2 3 4), (>/ 5 3 8 2)
NB. folds: 6 24 1
fold_limits =: (+/ i. 0), (+/ 42)
NB. fold_limits: 0 42

NB. Flip d'operadors
flips =: (7 | ~2), (10 - ~3)
NB. flips: 1 -7

main =: identitat, concatenacio, mides, filtres, indexos, rangs, duplicacio, folds, fold_limits, flips
NB. Esperat: 42 -42 1 2 3 1 2 3 4 5 1 2 2 0 1 1 3 2 3 2 4 5 6 0 1 2 3 5 6 7 2 4 6 4 9 6 24 1 0 42 1 -7