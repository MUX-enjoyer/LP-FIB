import System.IO


calc_imc :: Float -> Float -> Float
calc_imc m h = m / (h*h)


diagnostic :: Float -> String
diagnostic imc
    | imc < 18 = "magror"
    | imc < 25 = "corpulencia normal"
    | imc < 30 = "sobrepes"
    | imc < 40 = "obesitat"
    | otherwise = "obesitat morbida"


main = do
    line <- getLine
    if (line /= "*") then
        do
            let name = head (words line)
            let w = read ((words line) !! 1) :: Float
            let h = read ((words line) !! 2) :: Float
            let imc = calc_imc w h
            putStrLn (name ++ ": " ++ diagnostic imc)
            main
    else
        return ()