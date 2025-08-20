main :: IO()
main = do
    print $ "Test"

grandchildrenIncreased :: BTree -> Bool
grandchildrenIncreased (Node val lTree rTree) = helper val lTree && helper val rTree && grandchildrenIncreased lTree && grandchildrenIncreased rTree
    where 
        helper value Nil Nil    = True
        helper value (Node _ (Node v1 _ _) (Node v2 _ _)) (Node _ (Node v3 _ _) (Node v4 _ _))
            | value < v1 && value < v2 && value < v3 && value < v4    = True
            | otherwise                                             = False