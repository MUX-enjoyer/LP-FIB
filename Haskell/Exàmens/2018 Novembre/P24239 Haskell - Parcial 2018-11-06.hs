roman_value :: Char -> Int
roman_value 'I' = 1
roman_value 'V' = 5
roman_value 'X' = 10
roman_value 'L' = 50
roman_value 'C' = 100
roman_value 'D' = 500
roman_value 'M' = 1000
roman_value _ = 0

roman2int :: String -> Int
roman2int [] = 0
roman2int [x] = roman_value x
roman2int (x:y:xs)
    | value_x < value_y = value_y - value_x + roman2int xs
    | otherwise = value_x + roman2int (y:xs)
    where
        value_x = roman_value x
        value_y = roman_value y


roman2int' :: String -> Int
roman2int' s = sum (zipWith (\actual seguent -> if actual < seguent then -actual else actual) (valors) (tail valors ++ [0]))
    where
        valors = map roman_value s

arrel_x :: Float -> Float -> Float
arrel_x ant x = 0.5 * (ant + x/ant)

arrels :: Float -> [Float]
arrels x = scanl (arrel_x) x (repeat x)

arrel :: Float -> Float -> Float
arrel x e = snd (head (dropWhile (\(a, b) -> abs (a - b) >= e) (zip (arrels x) (tail (arrels x)))))

data LTree a = Leaf a | Node (LTree a) (LTree a)
instance Show a => Show (LTree a) where 
    show (Leaf x) = "{" ++ show x ++ "}"
    show (Node l r) = "<" ++ show l ++ "," ++ show r ++ ">"

build :: [a] -> LTree a
build [x] = Leaf x
build xs = Node (build left) (build right)
    where (left, right) = splitAt ((length xs + 1) `div` 2) xs

zipLTrees :: LTree a -> LTree b -> Maybe (LTree (a, b))
zipLTrees (Leaf x1) (Leaf x2) = Just (Leaf (x1, x2))
zipLTrees (Node l1 r1) (Node l2 r2) = do
    left <- zipLTrees l1 l2
    right <- zipLTrees r1 r2
    return (Node left right)
zipLTrees _ _ = Nothing