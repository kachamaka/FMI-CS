main :: IO()
main = do
    print $ fact 11
    print $ factIter 11
    -- print $ fact (-11)
    print $ fibRec 11
    print $ fibIter 110

fact :: Int -> Int
fact 0 = 1
fact x 
 | x < 0 = error "negative x"
 | otherwise = x * fact (x - 1)

factIter :: Int -> Int
factIter x 
 | x < 0 = error "negative x"
 | otherwise = helper x 1
 where
     helper :: Int -> Int -> Int
     helper 0 result = result
     helper leftOver result = helper (leftOver - 1) (result * leftOver)

fibRec :: Integer -> Integer
fibRec 0 = 0
fibRec 1 = 1
fibRec x = fibRec (x - 1) + fibRec (x - 2)

fibIter :: Integer -> Integer
fibIter x = helper 0 1 x
 where
     helper :: Integer -> Integer -> Integer -> Integer
     helper twoAgo _ 0 = twoAgo
     helper _ oneAgo 1 = oneAgo
     helper twoAgo oneAgo leftOver = helper oneAgo (twoAgo + oneAgo) (leftOver - 1)