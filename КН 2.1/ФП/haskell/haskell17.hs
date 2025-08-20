import Data.List

main :: IO()
main = do
    print $ getClosestDistance [(ThreeD 4 5 6), (ThreeD 2 5 10), (ThreeD 5 2 (-10)), (ThreeD (-2) 1 45), (ThreeD 12 0 2), (ThreeD 6 5 4)] == (2.83,ThreeD 4.0 5.0 6.0,ThreeD 6.0 5.0 4.0)

data Point a = TwoD a a | ThreeD a a a
 deriving (Show, Eq)

roundTwoDig :: (RealFrac a) =>  a -> a
roundTwoDig = (/100) . fromIntegral . round . (*100)

distance :: (Num a, Floating a, RealFrac a) => Point a -> Point a -> a
distance (TwoD x1 y1) (TwoD x2 y2) = roundTwoDig $ sqrt $ ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
distance (ThreeD x1 y1 z1) (ThreeD x2 y2 z2) = roundTwoDig $ sqrt $ ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2))
distance _ _ = error "incomparable points"

getClosestDistance :: (Num a, Floating a, RealFrac a) => [Point a] -> (a, Point a, Point a)
getClosestDistance = foldl1 (\ pair1@(d1, _, _) pair2@(d2, _, _) -> if d1 < d2 then pair1 else pair2) 
                        . map (\ [p1, p2] -> (distance p1 p2, p1, p2)) 
                        . filter ((==2) . length) 
                        . subsequences