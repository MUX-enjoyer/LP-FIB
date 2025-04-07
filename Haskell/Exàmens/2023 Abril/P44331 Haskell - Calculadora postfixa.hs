evaluatePostfix :: [String] -> Either String Int
evaluatePostfix expressions = evalStack expressions []
  where
    evalStack :: [String] -> [Int] -> Either String Int
    evalStack [] [result] = Right result
    evalStack (x:xs) (a:b:stack)
        | x == "+" = evalStack xs ((b + a) : stack)
        | x == "-" = if b >= a
                    then evalStack xs ((b - a) : stack)
                    else Left "neg"
        | x == "*" = evalStack xs ((b * a) : stack)
        | x == "/" = if a == 0
                    then Left "div0"
                    else if mod b a == 0
                    then evalStack xs ((b `div` a) : stack)
                    else Left "divE"
    evalStack (x:xs) stack = evalStack xs (read x : stack)

main = do
    expr <- getLine
    let result = evaluatePostfix (words expr)
    putStrLn (show result)
    main