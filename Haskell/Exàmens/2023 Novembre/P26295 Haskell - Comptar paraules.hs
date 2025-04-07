import Data.List (sort)

data Parella = Parella String Int 

instance Show Parella where
    show (Parella s n) = s ++ " " ++ show (n)

main = do
    contents <- getContents
    let wordList = words contents
        sortedWords = sort wordList
        countedWords = foldl (\acc word -> 
            case acc of
                [] -> [Parella word 1]
                (Parella w n):xs -> 
                    if w == word 
                    then Parella w (n + 1) : xs
                    else Parella word 1 : acc
            ) [] sortedWords
    mapM_ (putStrLn . show) (reverse countedWords)