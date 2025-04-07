--While foldr reduces a list to a summary value, unfoldr builds a list from a seed value. The function takes the element and returns Nothing if it is done producing the list or returns Just (m, n), in which case,
-- m is prepended to the list and n is used as the next element in a recursive call.
myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
myUnfoldr f x = case f x of
    Nothing      -> []
    Just (m, n)  -> m : myUnfoldr f n

-- Definiu, utilitzant myUnfoldr, una funció myReplicate :: a -> Int -> [a]
-- de manera que myReplicate x n retorni una llista amb n cops el valor x.
myReplicate :: a -> Int -> [a]
myReplicate rep x = myUnfoldr (\n -> if n == 0 then Nothing else Just (rep, n - 1)) x

-- Definiu, utilitzant myUnfoldr, una funció myIterate :: (a -> a) -> a -> [a]
-- que funcioni com iterate.
myIterate :: (a -> a) -> a -> [a]
myIterate f a = myUnfoldr (\n -> Just (n, f n)) a

-- Definiu, utilitzant myUnfoldr, una funció myMap :: (a -> b) -> [a] -> [b]
-- que funcioni com map
myMap :: (a -> b) -> [a] -> [b]
myMap f l = myUnfoldr (myMap2 f) l

myMap2 :: (a -> b) -> [a] -> Maybe (b, [a])
myMap2 f (x:xs) = Just (f x, xs)
myMap2 _ [] = Nothing

-- Considereu la definició següent del tipus Bst per arbres binaris de cerca,
-- juntament amb una funció add que hi afegeix valors:
data Bst a = Empty | Node a (Bst a) (Bst a)

instance Show a => Show (Bst a) where
    show Empty = "."
    show (Node x l r) = "(" ++ show x ++ " " ++ show l ++ " " ++ show r ++ ")"

add :: Ord a => a -> (Bst a) -> (Bst a)
add x Empty = Node x Empty Empty
add x (Node y l r)
    | x < y = Node y (add x l) r
    | x > y = Node y l (add x r)
    | otherwise = Node y l r

-- Definiu una funció adder :: Ord a => (Bst a, [a]) -> Maybe (Bst a, (Bst a, [a]))
-- de manera que myUnfoldr adder (t, xs) retorni una llista que mostri, pas a pas,
-- la construcció d’un arbre binari de cerca inserint seqüencialment els valors de xs en t.
adder :: Ord a => (Bst a, [a]) -> Maybe (Bst a, (Bst a, [a]))
adder (arbre, (x:xs)) = Just (add x arbre, (add x arbre, xs))
adder (arbre, []) = Nothing