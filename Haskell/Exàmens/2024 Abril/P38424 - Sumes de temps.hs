data Temps = Temps Int Int

instance Show Temps where
    show (Temps h m) = 
        let format n = if n < 10 then '0' : show n else show n
        in format h ++ ":" ++ format m

suma :: Temps -> Temps -> Temps
suma (Temps h1 m1) (Temps h2 m2) = Temps h m
    where
        h = h1+h2+(div (m1+m2) 60)
        m = mod (m1+m2) 60

sumes :: [Temps] -> Temps
sumes = foldl suma (Temps 0 0)


data Arbre a = Arbre a [Arbre a]
sumesArbre :: Arbre Temps -> Temps
sumesArbre (Arbre node l) = sumes (node:(map sumesArbre l))

main = do
    line <- getLine
    putStrLn (show (sumes (map parseTemps (words line))))

parseTemps :: String -> Temps
parseTemps s = Temps (read h) (read (tail m))
    where (h, m) = span (/= ':') s