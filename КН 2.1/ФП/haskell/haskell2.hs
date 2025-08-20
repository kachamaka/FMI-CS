main :: IO()
main = do
    print $ isInsideNoLists 5 1 4
    print $ isInsideNoLists 10 50 20

    print $ isInsideLists 5 1 4
    print $ isInsideLists 10 50 20

    print $ isInsideLambda 5 1 4
    print $ isInsideLambda 10 50 20


isInsideNoLists :: Int -> Int -> Int -> Bool
isInsideNoLists a b x = min a b <= x && x <= max a b 

isInsideLists :: Int -> Int -> Int -> Bool
isInsideLists a b x = elem x [min a b .. max a b]

isInsideLambda :: Int -> Int -> Int -> Bool
isInsideLambda a b = (\ x -> min a b <= x && x <= max a b )
