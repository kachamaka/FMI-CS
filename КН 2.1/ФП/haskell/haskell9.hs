main :: IO()
main = do
    print $ pack [1, 2, 3, 7, 8 ,9] == [[1,2,3],[7,8,9]]
    print $ pack [1, 7, 8 ,9] == [[1],[7,8,9]]
    print $ pack [1, 9] == [[1],[9]]

pack :: [Int] -> [[Int]]
pack xs = helper xs []
 where
     helper :: [Int] -> [Int] -> [[Int]]
     helper [] current = [current]
     helper [x] current = [(current ++ [x])]
     helper (x:y:xs) current
      | x + 1 == y = helper xs (current ++ [x, y])
      | otherwise = (current ++ [x]) : helper (y:xs) []