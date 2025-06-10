NB. Test d'operadors relacionals i booleans

NB. Comparacions d'igualtat i casos basics
igualtat =: (3 = 3), (3 = 2), (3 <> 2), (3 <> 3)
NB. igualtat: 1 0 1 0
igualtat_limits =: (0 = 0), (42 <> 42)
NB. igualtat_limits: 1 0

NB. Comparacions d'ordre
ordre =: (3 > 2), (2 > 3), (2 < 3), (3 < 2)
NB. ordre: 1 0 1 0

NB. Comparacions amb igualtat
amb_igualtat =: (3 >= 2), (3 >= 3), (2 >= 3), (2 <= 3), (3 <= 3), (4 <= 3)
NB. amb_igualtat: 1 1 0 1 1 0

NB. Comparacions amb vectors
vectors =: ((i. 3) > 0), ((i. 4) = 2)
NB. vectors: 0 1 1 0 0 1 0

NB. Casos limit amb zeros i negatius
limits =: (0 = 0), (_1 < 0), (0 > _1), (_5 = _5)
NB. limits: 1 1 1 1

NB. Combinacions logiques
combinacions =: ((3 > 2) * (5 < 6)), ((1 = 1) + (2 <> 2))
NB. combinacions: 1 1

main =: igualtat, igualtat_limits, ordre, amb_igualtat, vectors, limits, combinacions
NB. Esperat: 1 0 1 0 1 0 1 0 1 0 1 1 0 1 1 0 0 1 1 0 0 1 0 1 1 1 1 1 1