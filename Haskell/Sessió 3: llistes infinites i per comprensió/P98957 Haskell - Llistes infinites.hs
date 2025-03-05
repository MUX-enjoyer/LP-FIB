ones :: [Integer]
ones = repeat 1

nats :: [Integer]
nats = 0 : map (+1) nats

ints :: [Integer]
ints = 0 : [x*y | x <- [1..], y <- [1, -1]]

triangulars :: [Integer]
triangulars = scanl (+) 0 [1..]
--triangulars = [foldl (+) 0 (take x [1..]) | x <- [0..]]
 
factorials :: [Integer]
factorials = scanl (*) 1 [1..]
--factorials = [foldl (*) 1 (take x [1..]) | x <- [0..]]

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
--fibs = [a+b | (a,b) <- zip (1:fibs) (0:1:fibs)]

factors :: Integer -> [Integer]
factors n = [x | x <- [2..floor $ sqrt $ fromIntegral n], mod n x == 0]

primes :: [Integer]
primes = [x | x <- [2..], null (factors x)]
--També amb el garbell d'eratòstenes
primes_garbell :: [Integer]
primes_garbell = garbell [2..]
    where
        garbell (p : xs) = p : garbell [x | x <- xs, mod x p /= 0]


mult2 :: [Integer] -> [Integer]
mult2 = map (*2)

mult3 :: [Integer] -> [Integer]
mult3 = map (*3)

mult5 :: [Integer] -> [Integer]
mult5 = map (*5)

merge :: [Integer] -> [Integer] -> [Integer]
merge [] l = l
merge l [] = l
merge (x1:l1) (x2:l2)
    | x1 == x2  = x1 : (merge l1 l2)
    | x1 < x2   = x1 : (merge l1 (x2:l2))
    | otherwise = x2 : (merge (x1:l1) l2)

hammings :: [Integer]
hammings = 1 : merge (merge (mult2 hammings) (mult3 hammings)) (mult5 hammings)

--Hammings descartat per poc eficient:
--isHamming :: Integer -> Bool
--isHamming x = all (`elem` [2, 3, 5]) (primeFactors x)
--hammings :: [Integer]
--hammings = [x | x <- [1..], isHamming x]

primeFactors :: Integer -> [Integer]
primeFactors n = factorize n 2
    where
        factorize n p
            | p * p > n        = if n > 1 then [n] else []
            | n `mod` p == 0   = p : factorize (n `div` p) p
            | otherwise        = factorize n (p + 1)


look :: [Char] -> Integer
look [] = 0
look [_] = 1
look (c1:c2:s)
    | c1 == c2 = 1 + (look (c2:s))
    | otherwise = 1

say :: [Char] -> [Char]
say [] = []
say s = (show count) ++ (head s) : (say (drop (fromIntegral count) s)) where count = look s

lookNsay :: [Integer]
lookNsay = iterate (read . say . show) 1


pascalTriangle :: [Integer] -> [Integer]
pascalTriangle [] = []
pascalTriangle [_] = []
pascalTriangle (x:y:l) = (x + y):(pascalTriangle (y:l))

tartaglia :: [[Integer]]
tartaglia = iterate (\l -> 1 : (pascalTriangle l) ++ [1]) [1]