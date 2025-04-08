data Arbin = Buit | Node Int Arbin Arbin
    deriving Show


escorar :: Arbin -> (Arbin, Int, Int)
escorar Buit = (Buit, 0, 0)
escorar (Node x fe fd) = (escorat, pes, mida)
    where
        (esqEscorat, esqPes, esqMida) = escorar fe
        (dreEscorat, drePes, dreMida) = escorar fd
        pes  = x + esqPes  + drePes
        mida = 1 + esqMida + dreMida
        calGirar = esqPes > drePes || esqPes == drePes && esqMida > dreMida
        escorat = if calGirar then Node x dreEscorat esqEscorat
                              else Node x esqEscorat dreEscorat


llegirArbin :: [Int] -> (Arbin, [Int])
llegirArbin (x:xs)
    | x == -1   = (Buit, xs)
    | otherwise = (Node x fe fd, part2)
        where
            (fe, part1) = llegirArbin xs
            (fd, part2) = llegirArbin part1


convertirEnArbin :: [Int] -> Arbin
convertirEnArbin = fst . llegirArbin


main :: IO ()
main = do
    content <- getContents
    mapM_ processarLinia (lines content)
        where
            processarLinia = print . arbre . escorar . convertirEnArbin . (map read) . words
            arbre (a, _, _) = a