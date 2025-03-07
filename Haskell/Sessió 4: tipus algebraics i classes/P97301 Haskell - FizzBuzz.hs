fizzBuzz :: [Either Int String]
fizzBuzz = map detect_fizz_buzz [0 ..]
  where
    detect_fizz_buzz n
      | mod n 3 == 0 && mod n 5 == 0 = Right "FizzBuzz"
      | mod n 5 == 0 = Right "Buzz"
      | mod n 3 == 0 = Right "Fizz"
      | otherwise = Left n