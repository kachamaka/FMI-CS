main :: IO()
main = do
    print $ distance (TwoD 2 5) (TwoD 6 9) == 5.66
    print $ distance (ThreeD 2 5 10) (ThreeD 6 9 (-5)) == 16.03

data Point a = TwoD a a | ThreeD a a a
 deriving (Show, Eq)

roundTwoDig :: (RealFrac a) =>  a -> a
roundTwoDig = (/100) . fromIntegral . round . (*100)

distance :: (Num a, Floating a, RealFrac a) => Point a -> Point a -> a
distance (TwoD x1 y1) (TwoD x2 y2) = roundTwoDig $ sqrt $ ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
distance (ThreeD x1 y1 z1) (ThreeD x2 y2 z2) = roundTwoDig $ sqrt $ ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2))
distance _ _ = error "incomparable points"
