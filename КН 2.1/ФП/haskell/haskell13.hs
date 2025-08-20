main :: IO()
main = do
    print $ getAreas [Circle 5, Rectangle 2.5 4.5, Rectangle 5.5 20.6, Triangle 5.3 3.9 4.89, Cylinder 20 30] == [78.54, 11.25, 113.3, 9.13, 6283.19]
    print $ maxArea [Circle 5, Rectangle 2.5 4.5, Rectangle 5.5 20.6, Triangle 5.3 3.9 4.89, Cylinder 20 30] == Cylinder 20.0 30.0

data Shape a = Circle a | Rectangle a a | Triangle a a a | Cylinder a a
 deriving (Show, Eq)

area :: (Num a, Floating a) => Shape a -> a
area (Circle r) = pi * r * r
area (Rectangle w h) = w * h
area (Triangle x y z) = let p = (x + y + z) / 2 in sqrt $ p * (p - x) * (p - y) * (p - z)
area (Cylinder r h) = 2 * pi * r * h + 2 * pi * r * r

roundTwoDig :: (RealFrac a) =>  a -> a
roundTwoDig = (/100) . fromIntegral . round . (*100)

getAreas :: (Num a, Floating a, RealFrac a) => [Shape a] -> [a]
getAreas = map (roundTwoDig . area)

maxArea :: (Ord a, Floating a) => [Shape a] -> Shape a
maxArea = foldr1 (\ s1 s2 -> if area s1 < area s2 then s2 else s1)