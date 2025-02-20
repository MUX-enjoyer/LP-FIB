-- Per obrir Haskell ghci a terminal
-- Carreguem fitxer amb :load <path_fitxer>

absValue :: Int -> Int
absValue n
    | n < 0 = -n
    | otherwise = n


power :: Int -> Int -> Int
power x y
    | (y == 0) = 1
    | otherwise = x * power x (y - 1)


isPrime :: Int -> Bool
isPrime n
    | (n <= 1) = False
    | otherwise = null [ x | x <- [2..n-1], n `mod` x == 0 ]

slowFib :: Int -> Int
slowFib n
    | (n == 0) = 0
    | (n == 1) = 1
    | otherwise = slowFib(n - 1) + slowFib(n - 2)

quickFib :: Int -> Int
quickFib n = fibs !! n
  where
    fibs = 0 : 1 : zipWith (+) fibs (tail fibs)