myLength :: [Int] -> Int
myLength l
    | null l = 0
    | otherwise = 1 + myLength(tail(l))

myMaximum :: [Int] -> Int
myMaximum l
    | null l = 0
    | (myLength(l) == 1) = head(l) 
    | otherwise = max (head l) (myMaximum(tail(l)))

average :: [Int] -> Float
average l
    | null l = 0
    | otherwise = fromIntegral(sum(l)) / fromIntegral(myLength(l)) 
--  fromIntegral converteix Int a Float

buildPalindrome :: [Int] -> [Int]
buildPalindrome l
    | null l = []
    | otherwise = reverse(l) ++ l


--Feu una funció remove :: [Int] -> [Int] -> [Int] que donada una llista d’enters x i una llista d’enters y, retorna la llista x havent eliminat totes les ocurrències dels elements en y.
remove :: [Int] -> [Int] -> [Int]
remove [] _ = []
remove (x:xs) y
    | (x `elem` y) = remove xs y
    | otherwise = x : remove xs y

flatten :: [[Int]] -> [Int]
flatten [] = []
flatten (x:xs) = x ++ flatten(xs)

oddsNevens :: [Int] -> ([Int], [Int])
oddsNevens [] = ([], [])  -- Cas base: llista buida retorna dues llistes buides
oddsNevens (x:xs)
    | odd x     = (x : odds, evens)  -- Si és senar, l'afegim a la primera llista
    | otherwise = (odds, x : evens)  -- Si és parell, l'afegim a la segona llista
  where
    (odds, evens) = oddsNevens xs  -- Descomponem la resta de la llista recursivament

primeDivisors :: Int -> [Int]
primeDivisors n = [x | x <- [2..n], n `mod` x == 0, isPrime(x)]

isPrime :: Int -> Bool
isPrime n
    | (n <= 1) = False
    | otherwise = null [ x | x <- [2..n-1], n `mod` x == 0 ]