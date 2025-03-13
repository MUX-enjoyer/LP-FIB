data Queue a = Queue [a] [a]
  deriving (Show)

create :: Queue a
create = Queue [] []

push :: a -> Queue a -> Queue a
push n (Queue x y) = Queue x (n : y)

pop :: Queue a -> Queue a
pop (Queue [] y) = Queue (tail (reverse y)) []
pop (Queue (x : xs) y) = Queue xs y

top :: Queue a -> a
top (Queue [] y) = last y
top (Queue (x : xs) y) = x

empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue x y) = False

instance (Eq a) => Eq (Queue a) where
  (Queue x1 y1) == (Queue x2 y2) = (x1 ++ reverse y1) == (x2 ++ reverse y2)

instance Functor Queue
    where
        fmap fn (Queue l1 l2) = (Queue (fmap (fn) l1) (fmap (fn) l2))

translation :: Num b => b -> Queue b -> Queue b
translation n q = fmap (+n) q


instance Applicative Queue where
    pure x = Queue [x] []
    (Queue x1 y1) <*> (Queue x2 y2) = Queue (x1 <*> x2) (y1 <*> y2)

instance Monad Queue
    where
        return x = (Queue [x] [])
        (Queue x y) >>= f = foldl merge create (map f (x ++ (reverse y)))  

kfilter :: (p -> Bool) -> Queue p -> Queue p
kfilter f q = do
    x <- q
    if (f x) then return x else (Queue [] [])