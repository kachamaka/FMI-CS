
--      helper :: Int -> [Int] -> Int -> Bool
--      helper x [] len = True 
--      helper x (y:ys) len
--       | not (abs (y - x) > 0 && abs (y - x) < len) = False
--       | otherwise =