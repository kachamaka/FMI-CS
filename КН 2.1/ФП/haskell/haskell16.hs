main :: IO()
main = do
    print $ closestTo (ThreeD 2 5 10) [(ThreeD 4 5 6), (ThreeD 5 2 (-10)), (ThreeD (-2) 1 45), (ThreeD 12 0 2), (ThreeD 6 5 4)] == [ThreeD 4.0 5.0 6.0]

data Point a = TwoD a a | ThreeD a a a
 deriving (Show, Eq)

roundTwoDig :: (RealFrac a) =>  a -> a
roundTwoDig = (/100) . fromIntegral . round . (*100)

distance :: (Num a, Floating a, RealFrac a) => Point a -> Point a -> a
distance (TwoD x1 y1) (TwoD x2 y2) = roundTwoDig $ sqrt $ ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
distance (ThreeD x1 y1 z1) (ThreeD x2 y2 z2) = roundTwoDig $ sqrt $ ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2))
distance _ _ = error "incomparable points"

closestTo :: (Floating a, RealFrac a) => Point a -> [Point a] -> [Point a]
closestTo p ps = filter ((== minDist) . (distance p)) ps
 where
     minDist = minimum $ map (distance p) ps