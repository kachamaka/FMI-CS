main :: IO()
main = do 
    -- print $ minIf 15 60 == 15
    -- print $ minIf (-60) (-15) == (-60)
    -- print $ minGuard 60 15 == 15
    -- print $ minBuiltIn 60 15 == 15
    -- -- print $ minBuiltIn 60 15 == 15
    -- print $ minimum [1, 0, 9]
    -- print $ lastDigit 123
    print $ quotientWhole 130 10
    print $ divWhole 5 3
    -- print $ removeLastDigit 123
    -- print $ divReal 154.451 10.01
    -- print $ quotientReal 154.21 17.17
    -- print $ avgWhole 5 1542
    -- print $ roundTwoDig 3.1415534593245923
    -- print $ roundTwoDigWithMagic 3.1415534593245923

roundTwoDigWithMagic :: Double -> Double
roundTwoDigWithMagic = (/ 100) . fromIntegral . round . (*100)

roundTwoDig :: Double -> Double
roundTwoDig x = (fromIntegral $ round $ x * 100) / 100

avgWhole :: Int -> Int -> Double
avgWhole x y = (fromIntegral $ x + y) / 2

quotientReal :: Double -> Double -> Int
quotientReal x y = round $ x / y

divReal :: Double -> Double -> Double
divReal x y = x / y

removeLastDigit :: Int -> Int
removeLastDigit x = div x 10

divWhole :: Int -> Int -> Double
divWhole x y = (fromIntegral x) / (fromIntegral y)

quotientWhole :: Int -> Int -> Int
quotientWhole x y = div x y

lastDigit :: Int -> Int
lastDigit x = mod x 10

minBuiltIn :: Int -> Int -> Int
minBuiltIn x y = (min x y)

minGuard :: Int -> Int -> Int
minGuard x y
 | x < y = x
 | otherwise = y

minIf :: Int -> Int -> Int
minIf x y = if x < y then x else y
