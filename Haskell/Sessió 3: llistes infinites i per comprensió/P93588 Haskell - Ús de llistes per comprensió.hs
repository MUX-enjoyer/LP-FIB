myMap :: (a -> b) -> [a] -> [b]
myMap f l = [f x | x <- l]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter cond l = [x | x <- l, cond x]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f xs ys = [f x y | (x, y) <- zip xs ys]

thingify :: [Int] -> [Int] -> [(Int, Int)]
thingify xs ys = [(x, y) | x <- xs, y <- ys, mod x y == 0]

factors :: Int -> [Int]
factors n = [x | x <- [1..n], mod n x == 0]