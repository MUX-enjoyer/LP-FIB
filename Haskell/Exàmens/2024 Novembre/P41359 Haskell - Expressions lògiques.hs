-- Definició del tipus d'expressions lògiques
data LogicExpression
    = Or  LogicExpression LogicExpression
    | And LogicExpression LogicExpression
    | Not LogicExpression
    | Var String
    | Val Bool

-- Instància de Show per a LogicExpression
instance Show LogicExpression where
    show (Val True)     = "1"
    show (Val False)    = "0"
    show (Var s)        = s
    show (Not e)        = "(not " ++ show e ++ ")"
    show (And e1 e2)    = "(" ++ show e1 ++ " and " ++ show e2 ++ ")"
    show (Or e1 e2)     = "(" ++ show e1 ++ " or "  ++ show e2 ++ ")"

-- Funció pushNegations: porta les negacions fins a les fulles i elimina dobles negacions
pushNegations :: LogicExpression -> LogicExpression
pushNegations (Val b)    = Val b
pushNegations (Var s)    = Var s
pushNegations (And a b)  = And (pushNegations a) (pushNegations b)
pushNegations (Or a b)   = Or  (pushNegations a) (pushNegations b)
pushNegations (Not e)    =
    case pushNegations e of
        Not e'    -> pushNegations e'  -- elimina doble negació
        And a b   -> Or  (pushNegations (Not a)) (pushNegations (Not b))
        Or a b    -> And (pushNegations (Not a)) (pushNegations (Not b))
        Val b     -> Val (not b)
        e'        -> Not e'

-- Llista infinita de llistes d'n bits per a tot n ≥ 0.
-- Es defineix sense recursivitat explícita utilitzant l'operador (<*>)
bits :: [[[Int]]]
bits = iterate ((:) <$> [0,1] <*>) [[]]
