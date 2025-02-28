myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl _ x [] = x
myFoldl f x (y:ys) = myFoldl f (f x y) ys

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ x [] = x
myFoldr f x (y:ys) = f y (myFoldr f x ys)

myIterate :: (a -> a) -> a -> [a]
myIterate f x = x : myIterate f (f x)

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil cond f x
    | cond(x) = x
    | otherwise = myUntil cond f (f x)

myMap :: (a -> b) -> [a] -> [b]
myMap f xs = foldl (\acc x -> acc ++ [f x]) [] xs

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter cond xs = foldl (\acc x -> if cond x then acc ++ [x] else acc) [] xs

myAll :: (a -> Bool) -> [a] -> Bool
myAll cond xs = and (map cond xs)

myAny :: (a -> Bool) -> [a] -> Bool
myAny cond xs = or (map cond xs)

myZip :: [a] -> [b] -> [(a, b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f x y = map (\(a, b) -> f a b) (myZip x y)