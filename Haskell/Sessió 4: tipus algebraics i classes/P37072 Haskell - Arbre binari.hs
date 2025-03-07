import Distribution.Compat.Lens (over)

data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node _ l r) = 1 + size l + size r

height :: Tree a -> Int
height Empty = 0
height (Node _ l r) = 1 + max (height l) (height r)

equal :: (Eq a) => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal _ Empty = False
equal Empty _ = False
equal (Node v1 l1 r1) (Node v2 l2 r2) = equal l1 l2 && equal r1 r2 && v1 == v2

isomorphic :: (Eq a) => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic _ Empty = False
isomorphic Empty _ = False
isomorphic (Node v1 l1 r1) (Node v2 l2 r2) =
  v1 == v2 && ((equal l1 l2 && equal r1 r2) || (equal l1 r2 && equal l2 r1))

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node v l r) = v : preOrder l ++ preOrder r

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node v l r) = postOrder l ++ postOrder r ++ [v]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node v l r) = inOrder l ++ [v] ++ inOrder r

breadthFirst :: Tree a -> [a]
breadthFirst t = bfs [t]
  where
    bfs [] = []
    bfs (Empty : xs) = bfs xs
    bfs (Node v l r : xs) = v : bfs (xs ++ [l, r])

--               Preordre - Inordre
build :: (Eq a) => [a] -> [a] -> Tree a
build [] [] = Empty
build [] inOrd = Empty
build (x : preOrd) inOrd = Node x (build l_preOrd l_inOrd) (build r_preOrd r_inOrd)
  where
    l_inOrd = takeWhile (/= x) inOrd
    l_preOrd = take (length l_inOrd) preOrd
    r_preOrd = drop (length l_inOrd) preOrd
    r_inOrd = tail (dropWhile (/= x) inOrd)

overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
overlap f Empty t2 = t2
overlap f t1 Empty = t1
overlap f (Node v1 l1 r1) (Node v2 l2 r2) = Node (f v1 v2) (overlap f l1 l2) (overlap f r1 r2)