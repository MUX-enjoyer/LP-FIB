countIf :: (Int -> Bool) -> [Int] -> Int
countIf _ [] = 0
countIf cond (x:xs)
    | cond x = 1 + countIf cond xs
    | otherwise = countIf cond xs

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam _ [] = []
pam l (f:fs) = map f l : pam l fs

pam2 :: [Int] -> [Int -> Int] -> [[Int]]
pam2 [] _ = []
pam2 (x:xs) fs = map (\f -> f x) fs : pam2 xs fs

filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl cond f n l = foldl f n (filter cond l)


insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert _ [] x = [x]
insert cond (x:xs) n
    | cond n x = n : x:xs
    | otherwise = x : insert cond xs n

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort _ [] = []
insertionSort cond (x:xs) = foldl (insert cond) [x] xs