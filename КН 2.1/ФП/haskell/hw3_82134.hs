import Data.List
import Data.Char

main :: IO()
main = do
    print $ willItFly [1] == True 
    print $ willItFly [1, 4, 2, 3] == True 
    print $ willItFly [1, 4, 2, -1, 6] == False

    print $ formatDuration 0 == "now"
    print $ formatDuration 1 == "1 second"
    print $ formatDuration 62 == "1 minute and 2 seconds"
    print $ formatDuration 120 == "2 minutes"
    print $ formatDuration 3600 == "1 hour"
    print $ formatDuration 3662  ==  "1 hour, 1 minute and 2 seconds"
    print $ formatDuration 100000 == "1 day, 3 hours, 46 minutes and 40 seconds"
    print $ formatDuration 200000 == "2 days, 7 hours, 33 minutes and 20 seconds"
    print $ formatDuration 32000000 == "1 year, 5 days, 8 hours, 53 minutes and 20 seconds"
    print $ formatDuration 68000000 == "2 years, 57 days, 53 minutes and 20 seconds"
    print $ formatDuration 67999980 == "2 years, 57 days and 53 minutes"
    print $ formatDuration 67809200 == "2 years, 54 days, 19 hours, 53 minutes and 20 seconds"
    print $ formatDuration 107806020 == "3 years, 152 days, 18 hours and 7 minutes"


willItFly :: [Int] -> Bool
willItFly xs = helper (head xs) (tail xs) (length xs)
 where
     helper :: Int -> [Int] -> Int -> Bool
     helper x [] len = True 
     helper x (y:ys) len
      | not (abs (y - x) > 0 && abs (y - x) < len) = False
      | otherwise = helper y ys len

-- another helper function for format duration
-- couldn't figure out how to do it with one helper function
printRes :: [String] -> String -> String
printRes (x:xs) res
    | length xs == 0 = (res ++ x)
    | length xs == 1 = printRes xs (res ++ x ++ " and ")
    | otherwise = printRes xs (res ++ x ++ ", ")

formatDuration :: Int -> String
formatDuration 0 = "now"
formatDuration n = helper (div n 31536000) n 'y' []
 where
     helper :: Int -> Int -> Char -> [String] -> String
     helper 0 0 '_' ys = printRes (filter (\x -> take 1 x /= "0") ys) ""
     helper num secs t ys 
      | 'y' == t = helper (div (secs - num*31536000) 86400) (secs - num*31536000) 'd' (ys ++ [show num ++ " year" ++ (if num == 1 then "" else "s")])
      | 'd' == t = helper (div (secs - num*86400) 3600) (secs - num*86400) 'h' (ys ++ [show num ++ " day" ++ (if num == 1 then "" else "s")])
      | 'h' == t = helper (div (secs - num*3600) 60) (secs - num*3600) 'm' (ys ++ [show num ++ " hour" ++ (if num == 1 then "" else "s")])
      | 'm' == t = helper (secs - num*60) (secs - num*60) 's' (ys ++ [show num ++ " minute" ++ (if num == 1 then "" else "s")])
      | 's' == t = helper 0 0 '_' (ys ++ [show num ++ " second" ++ (if num == 1 then "" else "s")])
    