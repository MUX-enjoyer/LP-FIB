-- Write a function df :: Int -> Int that returns the double factorial of a natural number.
-- The double factorial of n is denoted n!! and is n(n−2)(n−4)….
df :: Int -> Int
df 0 = 1
df 1 = 1
df n = n * df (n-2)

-- Write a function sumd :: Int -> Int that
-- returns the sum of the digits of a natural number.
sumd :: Int -> Int
sumd 0 = 0
sumd x = (mod x 10) + sumd (div x 10)

-- Write a function dup :: [Int] -> [Int] that
-- duplicates each element in a list.
dup :: [Int] -> [Int]
dup [] = []
dup [x] = [x,x]
dup (x:xs) = x : x : dup xs

--Write a function pal :: String -> Bool that tells
-- if a string is a palindrome, ie, if it is equal to its reverse.
pal :: String -> Bool
pal [] = True
pal [x] = True
pal s = ((head s) == (last s)) && (pal (init (tail s)))

-- Write a function apply2 :: (a -> a) -> a -> a that
-- applies a function twice to some parameter.
apply2 :: (a -> a) -> a -> a
apply2 f = f . f
