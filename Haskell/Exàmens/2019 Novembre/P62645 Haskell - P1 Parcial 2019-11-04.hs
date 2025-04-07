s2i :: String -> Int
s2i = read

i2s :: Int -> String
i2s = show

main = do
  cnt <- getContents
  let string_enters = words cnt
  let enters = map s2i string_enters
  let sum_enters = foldl (+) 0 enters -- sum enters
  putStrLn (i2s sum_enters)
  return ()