NB. Test de vectors i operacions matricials

NB. Creacio de vectors basics
vec_basic =: (1 2 3), (4 5 6)
NB. vec_basic: 1 2 3 4 5 6
vec_rangs =: (i. 5), (3 + i. 4)
NB. vec_rangs: 0 1 2 3 4 3 4 5 6

NB. Operacions element a element
operacions_elem =: ((1 2 3) + (4 5 6)), ((4 5 6) - (1 2 3)), ((1 2 3) * (2 3 4))
NB. operacions_elem: 5 7 9 3 3 3 2 6 12

NB. Broadcasting amb escalars
broadcasting =: (10 + (1 2 3)), ((1 2 3) * 5), ((6 8 10) % 2)
NB. broadcasting: 11 12 13 5 10 15 3 4 5

NB. Concatenacio i construccio
concatenacions =: ((1 2) , (3 4)), (0 , (i. 3))
NB. concatenacions: 1 2 3 4 0 0 1 2

NB. Mides i casos especials
mides =: (# (1 2 3)), (# (i. 0)), (# 42)
NB. mides: 3 0 1

NB. Indexacio i acces
indexacio =: (0 { (5 6 7)), (1 2 { (10 11 12 13)), ((i. 3) { (20 21 22))
NB. indexacio: 5 11 12 20 21 22

NB. Filtrat amb predicats
filtratge =: ((1 0 1) # (7 8 9)), (((i. 5) > 2) # (i. 5))
NB. filtratge: 7 9 3 4

NB. Operacions funcionals sobre vectors
funcionals =: (*: (1 2 3)), (+/ (1 2 3 4)), (>/ (3 1 4 2))
NB. funcionals: 1 4 9 10 1

NB. Casos limit vectors
limits =: (i. 0), (42), (1 , i. 0)
NB. limits: (buit) 42 1

main =: vec_basic, vec_rangs, operacions_elem, broadcasting, concatenacions, mides, indexacio, filtratge, funcionals, 42, 1
NB. Esperat: 1 2 3 4 5 6 0 1 2 3 4 3 4 5 6 5 7 9 3 3 3 2 6 12 11 12 13 5 10 15 3 4 5 1 2 3 4 0 0 1 2 3 0 1 5 11 12 20 21 22 7 9 3 4 1 4 9 10 1 42 1