eql :: [Int] -> [Int] -> Bool
eql x y
    | (length x /= length y) = False 
    | otherwise = and (zipWith (==) x y)

prod :: [Int] -> Int
prod l = foldl (*) 1 l

prodOfEvens :: [Int] -> Int
prodOfEvens l = foldl (*) 1 (filter even l)

powersOf2 :: [Int]
powersOf2 = iterate (*2) 1

scalarProduct :: [Float] -> [Float] -> Float
scalarProduct x y = foldl (+) 0 (zipWith (*) x y)