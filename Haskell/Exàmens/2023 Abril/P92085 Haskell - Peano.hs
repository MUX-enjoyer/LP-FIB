data Nat = Z | S Nat
    deriving Show

rec :: a -> (Nat -> a -> a) -> Nat -> a
rec base step Z = base 
rec base step (S n) = step n (rec base step n)

-- indica si un natural és parell o no
isEven :: Nat -> Bool
isEven = rec base step
    where
        base = True
        step _ acc = not acc

-- retorna la suma de dos naturals
add :: Nat -> Nat -> Nat
add n = rec base step
    where
        base = n
        step _ acc = S acc

-- retorna el producte de dos naturals
mul :: Nat -> Nat -> Nat
mul n = rec base step
    where
        base = Z
        step _ acc = add n acc

-- retorna el factorial d’un natural
fact :: Nat -> Nat
fact = rec base step
    where
        base = S Z
        step n acc = mul (S n) acc
