import Data.Char
import Data.List

main :: IO()
main = do
    -- print $ matching "1234" -- == []
    print $ matching ",[.[-],]" -- == [(3,5),(1,7)]
    -- print $ mapToVector "Testing [ ]" 0
    -- print $ matching ",+[-.,+]" -- == [(2,7)]
    -- print $ matching "[][]" -- == [(0,1),(2,3)]

findClosing :: [(Char, Int)] -> Int -> Int -> Int
findClosing xs start count = helper (drop start xs) count
 where
     helper :: [(Char, Int)] -> Int -> Int
     helper [] _ = -1
     helper ((c, i):xs) count
      | c == ']' && count == 0 = i
      | c == ']' && count /= 0 = helper xs (count - 1)
      | c == '[' = helper xs (count + 1)
      | otherwise = helper xs count

sortBraces :: [(Char, Int)] -> [(Int, Int)]
sortBraces [] = []
sortBraces ((c, i):xs)
 | c == '[' && closing /= -1 = [(i, closing)] ++ sortBraces (filter (\ (_, fi) -> fi /= i && fi /= closing ) xs)
 | otherwise = sortBraces xs

 where
     closing = (findClosing xs i 0)

mapToVector :: String -> Int -> [(Char, Int)]
mapToVector [] _ = []
mapToVector (x:xs) index = [(x, index)] ++ mapToVector xs (index + 1)

-- matching :: String -> [(Int, Int)]
matching xs = let res = filter (\ (c, i) -> c == '[' || c == ']') (mapToVector xs 0) in sortBraces res