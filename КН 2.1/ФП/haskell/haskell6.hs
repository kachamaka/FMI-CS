main :: IO()
main = do
    print $ getPalindromesLC 132465 == 8
    print $ getPalindromesLC 654546 == 8
    print $ getPalindromesLC 100001 == 100012
    print $ getPalindromesLC 21612 == 21614
    print $ getPalindromesLC 26362 == 26364

    print $ getPalindromesHOF 132465 == 8
    print $ getPalindromesHOF 654546 == 8
    print $ getPalindromesHOF 100001 == 100012
    print $ getPalindromesHOF 21612 == 21614
    print $ getPalindromesHOF 26362 == 26364

getPalindromesLC :: Int -> Int
getPalindromesLC n = minimum divs + maximum divs
 where
     divs :: [Int]
     divs = [d | d <- [2 .. n], show d == (reverse $ show d) && mod n d == 0 ]

getPalindromesHOF :: Int -> Int
getPalindromesHOF n = minimum divs + maximum divs
 where
     divs :: [Int]
     divs = filter (\d -> show d == (reverse $ show d) && mod n d == 0) [2 .. n]