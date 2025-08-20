import Data.Char

main :: IO()
main = do
    print $ revOneLine 123 == 321
    print $ revOneLineMagic 123 == 321

    print $ sumDivsOneLineLC 6 == 12
    print $ sumDivsOneLineHOF 6 == 12

    print $ primeOneLineLC 6 == False
    print $ primeOneLineLC 17 == True

    print $ primeOneLineHOF 6 == False
    -- print $ primeOneLineHOF 17 == True

revOneLine :: Int -> Int
revOneLine n = read $ reverse $ show n

revOneLineMagic :: Int -> Int
revOneLineMagic = read . reverse . show

sumDivsOneLineLC :: Int -> Int
sumDivsOneLineLC n = sum [d | d <- [1 .. n], mod n d == 0]

sumDivsOneLineHOF :: Int -> Int
sumDivsOneLineHOF n = sum $ filter (\ d -> mod n d == 0) [1 .. n]

primeOneLineLC :: Int -> Bool
primeOneLineLC n = n > 1 && null [d | d <- [2 .. n - 1], mod n d == 0] 

primeOneLineHOF :: Int -> Bool
primeOneLineHOF n = n > 1 && (null $ filter (\ x -> mod n x == 0) [2 .. n - 1])
