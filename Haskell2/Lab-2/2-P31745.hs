flatten :: [[Int]] -> [Int]
flatten m = foldl (++) [] m

myLength :: String -> Int
myLength s = foldl (+) 0 (map (const 1) s)
--foldl (\acc _ -> acc + 1) 0 s

myReverse :: [Int] -> [Int]
myReverse l = foldl (\acc x -> x : acc) [] l
myReverse2 :: [Int] -> [Int]
myReverse2 l = foldr (\x acc -> acc ++ [x]) [] l

count :: Int -> [Int] -> Int
count x l = length(filter (== x) l)
countIn :: [[Int]] -> Int -> [Int]
countIn m x = map (count x) m

firstWord :: String -> String
firstWord s = takeWhile (/= ' ') (dropWhile (== ' ') s) 