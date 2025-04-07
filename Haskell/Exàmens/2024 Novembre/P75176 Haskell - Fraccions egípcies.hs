import Data.Ratio
-- Implementeu (usant funcionds d’ordre superior i sense usar recursivitat ni la funció estàndard until) una funció myUntil :: (a -> Bool) -> (a -> a) -> a -> a que, donat un predicat p, una funció f i un valor x, retorni la llista [x, f x, f (f x), ...] fins es que sa­tis­fà el predicat p.
-- Per exemple, myUntil (>100) (*2) 1 val 128.
myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil p f x = head (dropWhile (not . p) (iterate f x))

egypt :: Rational -> [Rational]
egypt r
    | numerator r == 0 = []
    | otherwise = e : egypt(r_e)
    where
        x = numerator r
        y = denominator r
        e = 1 % ceiling (y % x)
        r_e = (mod (-y) x) % (y*(ceiling (y % x)))

main = do
    line <- getLine
    let [numStr, simbol, denomStr] = words line
    putStrLn (show (egypt (read numStr % read denomStr)))
    main