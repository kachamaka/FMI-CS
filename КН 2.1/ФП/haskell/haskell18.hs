main :: IO()
main = do
    -- print $ qSort [5, 2, 9, 14, 42, 0, 15, -2, -10, 32]
    print $ test [5, 2, 9, 14, 42, 0, 15, -2, -10, 32]

-- qSort :: [Int] -> [Int]
-- qSort [] = []
-- qSort (x:xs) = qSort [ y | y <- xs, y<=x] ++ [x] ++ qSort [ y | y <- xs, y>x]

test :: [Int] -> [Int]
test = map (+10) . filter even