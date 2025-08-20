main :: IO()
main = do
    print $ isPerfectlyBalanced t1 == True

data BTree a = Nil | Node a (BTree a) (BTree a)

t1 = Node 'H' (Node 'a' (Node 'k' Nil Nil) (Node 'e' Nil Nil)) (Node 's' (Node 'l' Nil Nil) (Node 'l' Nil Nil))

getMaxDepth :: BTree a -> Int -> Int
getMaxDepth Nil d = d
getMaxDepth (Node _ l r) d = max (getMaxDepth l (d + 1)) (getMaxDepth r (d + 1))

getNodes :: BTree a -> [BTree a]
getNodes Nil = []
getNodes node@(Node _ l r) = (getNodes l) ++ [node] ++ (getNodes r)

getNodesCount :: BTree a -> Int
getNodesCount root = length $ getNodes root

twoPower :: Int -> Int
twoPower 0 = 1
twoPower n = 2 * twoPower (n - 1)

targetNum :: Int -> Int
targetNum n = (twoPower n) - 1

isPerfectlyBalanced :: BTree a -> Bool
isPerfectlyBalanced Nil = True
isPerfectlyBalanced root 
 | getNodesCount root == targetNum (getMaxDepth root 0) = True
 | otherwise = False