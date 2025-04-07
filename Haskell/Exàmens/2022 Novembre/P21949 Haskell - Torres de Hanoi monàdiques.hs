hanoi :: Int -> String -> String -> String -> IO ()
hanoi 0 _ _ _ = return ()
hanoi n origen desti auxiliar = do
    hanoi (n - 1) origen auxiliar desti
    putStrLn $ origen ++ " -> " ++ desti
    hanoi (n - 1) auxiliar desti origen

main :: IO ()
main = do
    input <- getLine
    let [nStr, origen, desti, auxiliar] = words input
        n = read nStr
    hanoi n origen desti auxiliar