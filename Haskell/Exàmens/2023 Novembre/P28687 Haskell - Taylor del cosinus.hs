import Data.Ratio

fact :: Integer -> Rational
fact 0 = 1
fact n = fromIntegral n * fact (n - 1)

-- Infinite list of Taylor series terms for cosine
termes_cosinus :: Rational -> [Rational]
termes_cosinus alpha = [((-1) ^ n) * (alpha^(2*n) / fact (2*n)) | n <- [0..]]

cosinus :: Rational -> Rational -> Rational
cosinus a e = suma_terms (termes_cosinus a)
    where
        suma_terms (t:ts)
            | abs t >= e = t + suma_terms ts
            | otherwise = 0