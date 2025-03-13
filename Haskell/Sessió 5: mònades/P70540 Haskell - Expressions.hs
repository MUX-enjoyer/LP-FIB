data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr


eval1 :: Expr -> Int
eval1 (Val x) = x
eval1 (Add x y) = eval1 x + eval1 y
eval1 (Sub x y) = eval1 x - eval1 y
eval1 (Mul x y) = eval1 x * eval1 y
eval1 (Div x y) = eval1 x `div` eval1 y

eval2 :: Expr -> Maybe Int
eval2 (Val x) = Just x
eval2 (Add x1 y1) = do
    x2 <- eval2 x1
    y2 <- eval2 y1
    return (x2 + y2)
eval2 (Sub x1 y1) = do
    x2 <- eval2 x1
    y2 <- eval2 y1
    return (x2 - y2)
eval2 (Mul x1 y1) = do
    x2 <- eval2 x1
    y2 <- eval2 y1
    return (x2 * y2)
eval2 (Div x1 y1) = do
    x2 <- eval2 x1
    y2 <- eval2 y1
    if y2 == 0 then Nothing
    else return (x2 `div` y2)

eval3 :: Expr -> Either String Int
eval3 (Val x) = Right x
eval3 (Add x1 y1) = do
    x2 <- eval3 x1
    y2 <- eval3 y1
    return (x2 + y2)
eval3 (Sub x1 y1) = do
    x2 <- eval3 x1
    y2 <- eval3 y1
    return (x2 - y2)
eval3 (Mul x1 y1) = do
    x2 <- eval3 x1
    y2 <- eval3 y1
    return (x2 * y2)
eval3 (Div x1 y1) = do
    x2 <- eval3 x1
    y2 <- eval3 y1
    if y2 == 0 then Left "div0"
    else return (x2 `div` y2)