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


isHamming :: Integer -> Bool
isHamming x = all (`elem` [2, 3, 5]) (primeFactors x)

hammings :: [Integer]
hammings = [x | x <- [1..], isHamming x]

primeFactors :: Integer -> [Integer]
primeFactors n = factorize n 2
    where
        factorize n p
            | p * p > n        = if n > 1 then [n] else []
            | n `mod` p == 0   = p : factorize (n `div` p) p
            | otherwise        = factorize n (p + 1)


--lookNsay :: [Integer]
--
--tartaglia :: [[Integer]]