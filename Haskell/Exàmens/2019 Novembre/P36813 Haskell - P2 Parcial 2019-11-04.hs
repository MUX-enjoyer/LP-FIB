import Data.List

numAppears :: Eq a => (a, a) -> a -> Int
numAppears (a, b) n
    | (n == a) || (n == b) = 1
    | otherwise = 0

-- Implementeu recursivament una funció degree :: Eq a => [(a, a)] -> a -> Int
-- que calculi el grau d’un vèrtex donat.
degree :: Eq a => [(a, a)] -> a -> Int
degree [] _ = 0
degree (x:xs) n = numAppears x n + degree xs n

-- Implementeu sense recursivatat una funció degree’ :: Eq a => [(a, a)] -> a -> Int
-- que calculi el grau d’un vèrtex donat.
degree' :: Eq a => [(a, a)] -> a -> Int
degree' l n = foldl (\acc x -> acc + numAppears x n) 0 l

returnNeighbor :: Eq a => (a, a) -> a -> [a]
returnNeighbor (a, b) n
    | (n == a) = [b]
    | (n == b) = [a]
    | otherwise = []

-- Implementeu sense recursivitat una funció neighbors :: Ord a => [(a, a)] -> a -> [a]
-- que retorni els veïns d’un vèrtex donat en ordre creixent.
neighbors :: Ord a => [(a, a)] -> a -> [a]
neighbors l n = sort (foldr (\x acc -> returnNeighbor x n ++ acc) [] l)

