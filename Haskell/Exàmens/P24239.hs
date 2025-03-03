data LTree a = Leaf a | Node (LTree a) (LTree a)

instance (Show a) => Show (LTree a) where
  show (Leaf x) = "{" ++ show x ++ "}"
  show (Node t1 t2) = "<" ++ show t1 ++ "," ++ show t2 ++ ">"

build :: [a] -> LTree a
build [x] = Leaf x
build l = Node (build l1) (build l2)
  where
    len = div (length l) 2 + mod (length l) 2
    l1 = take len l
    l2 = drop len l