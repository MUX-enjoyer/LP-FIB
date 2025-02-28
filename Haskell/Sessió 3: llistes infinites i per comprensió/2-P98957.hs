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

hammings :: [Integer]
hammings = [x | x <- [1..], (all (`elem` [2, 3, 5]) (factors x)), not (null (factors x))]

--lookNsay :: [Integer]
--tartaglia :: [[Integer]]