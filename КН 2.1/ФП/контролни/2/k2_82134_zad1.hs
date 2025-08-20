import Data.Char

main :: IO()
main = do
    print $ squareDigits 9119 == 811181
    print $ squareDigits (-9119) == -811181

stringToInt :: String -> Int -> Int
stringToInt [] _ = 0 
stringToInt str cnt = stringToInt (init str) (cnt * 10) + (digitToInt $ last str)*cnt

squareDigits :: Int -> Int
squareDigits n 
 | n < 0 = negate $ stringToInt (helper (negate n)) 1
 | otherwise = stringToInt (helper n) 1
 where
     helper :: Int -> String
     helper 0 = []
     helper n = helper (div n 10) ++ let num = mod n 10 in (show (num*num))
