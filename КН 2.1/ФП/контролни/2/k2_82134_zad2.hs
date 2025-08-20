main :: IO()
main = do
    print $ stocklist stocks ['A','B'] == [('A',200),('B',1140)]
    print $ stocklist stocks ['C','X'] == [('C',500),('X',0)]
    print $ stocklist stocks ['Y','X'] == [('Y',0),('X',0)]
    print $ stocklist stocks ['C'] == [('C', 500)]

data Stock = Stock String Int

stocks = [Stock "ABAR" 200, Stock "CDXE" 500, Stock "BKWR" 250, Stock "BTSQ" 890, Stock "DRTY" 600]

stocklist :: [Stock] -> [Char] -> [(Char, Int)]
stocklist _ [] = []
stocklist ss (c:cs) = [(c, (foldl (\ acc (Stock sname scount) -> if c == (head sname) then acc + scount else acc + 0) 0 ss))] ++ stocklist ss cs
