import Control.Applicative (Alternative (empty))
import Data.Text.Lazy.Read (double)

data Tree a = Empty | Node a (Tree a) (Tree a)

instance (Show a) => Show (Tree a) where
  show Empty = "()"
  show (Node n l r) = "(" ++ show l ++ "," ++ show n ++ "," ++ show r ++ ")"

instance Functor Tree where
  fmap f Empty = Empty
  fmap f (Node a l r) = Node (f a) (fmap f l) (fmap f r)

doubleT :: (Num a) => Tree a -> Tree a
doubleT t = fmap (* 2) t

data Forest a = Forest [Tree a]

instance Functor Forest where
  fmap f (Forest l) = Forest (fmap (fmap f) l)

doubleF :: (Num a) => Forest a -> Forest a
doubleF f = fmap (* 2) f