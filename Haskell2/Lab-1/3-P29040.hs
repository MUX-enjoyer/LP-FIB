insert :: [Int] -> Int -> [Int]
insert [] x = [x]
insert (y:ys) x
    | x <= y = x : y:ys
    | otherwise = y : insert ys x

isort :: [Int] -> [Int]
isort [] = []
isort (x:xs) = insert (isort xs) x

remove :: [Int] -> Int -> [Int]
remove [] _ = []
remove (x:xs) y
    | x == y = xs
    | otherwise = x : remove xs y

ssort :: [Int] -> [Int]
ssort [] = []
ssort l = min : ssort (remove l min)
    where min = minimum l

merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge [] y = y
merge x [] = x
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort l = merge (msort left) (msort right)
    where
        (left, right) = splitAt (length l `div` 2) l

qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort bigger
    where
        smaller = [a | a <- xs, a <= x]
        bigger = [a | a <- xs, a > x]

genQsort :: Ord a => [a] -> [a]
genQsort [] = []
genQsort (x:xs) = genQsort smaller ++ [x] ++ genQsort bigger
    where
        smaller = [a | a <- xs, a <= x]
        bigger = [a | a <- xs, a > x]
