import Data.List

main :: IO()
main = do
    print $ getSunk database == [
        ("Guadalcanal",["Kirishima"]),
        ("North Atlantic",["Bismarck","Hood"]),
        ("North Cape",["Schamhorst"]),
        ("Surigao Strait",["Fuso","Yamashiro"])]

    print $ inBattleAfterDamaged database == ["California","Prince of Wales"]
    print $ (grandchildrenIncreased $ t1) == True
    print $ (grandchildrenIncreased $ t2) == False

-----------------------------------------------------------------------
----Task 1-------------------------------------------------------------
-----------------------------------------------------------------------

type Name = String
type Date = String
type Class = String
type Result = String
type Launched = Int
 -- Place Date
data Battle = Battle Name Date 
 deriving Show
data Ship = Ship Name Class Launched 
 deriving Show
 -- ShipName BattleName Outcome
data Outcome = Outcome Name Name Result 
 deriving Show
type Database = ([Outcome], [Battle], [Ship])

-- getBattleDate :: Battle -> Date
-- getBattleDate (Battle name date) = date

-- sortedBattles :: [Battle]
-- sortedBattles = sortOn getBattleDate $ battles

addShip :: Name -> Name -> [(Name, [Name])] -> [(Name, [Name])]
addShip ship place [] = [(place, [ship])]
addShip ship place ((x, xs):ys)
 | place == x = [(x, xs ++ [ship])] ++ ys 
 | otherwise = [(x, xs)] ++ addShip ship place ys

getSunk :: Database -> [(Name, [Name])]
getSunk (outcomes, _, _) = let os = (filter (\ (Outcome _ _ c) -> c == "sunk") outcomes) in sortOn fst $ helper os []
 where
     helper :: [Outcome] -> [(Name, [Name])] -> [(Name, [Name])]
     helper [] res = res
     helper ((Outcome ship place _):xs) res = helper xs (addShip ship place res)
     
examinePotential :: ([Name], [Name]) -> [Name] -> ([Name], [Name])
examinePotential ([], potential) res = (potential, res)
examinePotential ((p:newPots), potential) res
 | elem p potential = examinePotential (newPots, (filter (\ pot -> pot /= p) potential)) (res ++ [p])
 | otherwise = examinePotential (newPots, (potential ++ [p])) res

inBattleAfterDamaged :: Database -> [Name]
inBattleAfterDamaged db = helper db ([], [])
 where
     helper :: Database -> ([Name], [Name]) -> [Name]
     helper (_, [], _) (_, res) = sort res
     helper (os, ((Battle name _):bs), ss) (potential, res)
      | null potential = helper ((filter (\ (Outcome _ place _) -> place /= name) os), bs, ss) ((foldl (\ acc (Outcome s _ _) -> acc ++ [s]) [] (filter (\ (Outcome _ place state) -> place == name && state == "damaged") os)), res)
      | otherwise = helper ((filter (\ (Outcome _ place _) -> place /= name) os), bs, ss) (examinePotential ((foldl (\ acc (Outcome s _ _) -> acc ++ [s]) [] (filter (\ (Outcome _ place _) -> place == name) os)), potential) res)

outcomes :: [Outcome]
outcomes = [  
    Outcome "Bismarck" "North Atlantic" "sunk",
    Outcome "California" "Surigao Strait" "ok", 
    Outcome "Duke of York" "North Cape" "ok", 
    Outcome "Fuso" "Surigao Strait" "sunk", 
    Outcome "Hood" "North Atlantic" "sunk", 
    Outcome "King George V" "North Atlantic" "ok", 
    Outcome "Kirishima" "Guadalcanal" "sunk", 
    Outcome "Prince of Wales" "North Atlantic" "damaged", 
    Outcome "Rodney" "North Atlantic" "ok", 
    Outcome "Schamhorst" "North Cape" "sunk", 
    Outcome "South Dakota" "Guadalcanal" "damaged", 
    Outcome "Tennessee" "Surigao Strait" "ok", 
    Outcome "Washington" "Guadalcanal" "ok", 
    Outcome "Prince of Wales" "Guadalcanal" "ok", 
    Outcome "West Virginia" "Surigao Strait" "ok", 
    Outcome "Yamashiro" "Surigao Strait" "sunk", 
    Outcome "California" "Guadalcanal" "damaged"
    ]

battles :: [Battle]
battles = [
    Battle "North Atlantic" "1941-05-25", 
    Battle "Guadalcanal" "1942-11-15", 
    Battle "North Cape" "1943-12-26", 
    Battle "Surigao Strait" "1944-10-25" 
    ]

ships :: [Ship]
ships = [ 
    Ship "California" "Tennessee" 1921, 
    Ship "Haruna" "Kongo" 1916, 
    Ship "Hiei" "Kongo" 1914, 
    Ship "Iowa" "Iowa" 1943, 
    Ship "Kirishima" "Kongo" 1915, 
    Ship "Kongo" "Kongo" 1913, 
    Ship "Missouri" "Iowa" 1944, 
    Ship "Musashi" "Yamato" 1942, 
    Ship "New Jersey" "Iowa" 1943, 
    Ship "North Carolina" "North Carolina" 1941, 
    Ship "Ramillies" "Revenge" 1917, 
    Ship "Renown" "Renown" 1916, 
    Ship "Repulse" "Renown" 1916, 
    Ship "Resolution" "Renown" 1916, 
    Ship "Revenge" "Revenge" 1916, 
    Ship "Royal Oak" "Revenge" 1916, 
    Ship "Royal Sovereign" "Revenge" 1916, 
    Ship "Tennessee" "Tennessee" 1920, 
    Ship "Washington" "North Carolina" 1941, 
    Ship "Wisconsin" "Iowa" 1944, 
    Ship "Yamato" "Yamato" 1941, 
    Ship "Yamashiro" "Yamato" 1947, 
    Ship "South Dakota" "North Carolina" 1941, 
    Ship "Bismarck" "North Carolina" 1911, 
    Ship "Duke of York" "Renown" 1916, 
    Ship "Fuso" "Iowa" 1940, 
    Ship "Hood" "Iowa" 1942, 
    Ship "Rodney" "Yamato" 1915, 
    Ship "Yanashiro" "Yamato" 1918, 
    Ship "Schamhorst" "North Carolina" 1917, 
    Ship "Prince of Wales" "North Carolina" 1937, 
    Ship "King George V" "Iowa" 1942, 
    Ship "West Virginia" "Iowa" 1942 
    ] 

database :: Database
database = (outcomes, battles, ships)


-----------------------------------------------------------------------
----Task 2-------------------------------------------------------------
-----------------------------------------------------------------------

data BTree = Nil | Node Int BTree BTree

t1 :: BTree
t1 = Node 1 (Node (-1) (Node 2 Nil Nil) (Node 2 (Node 0 Nil Nil) Nil)) (Node (-1) Nil Nil)

t2 :: BTree
t2 = Node 1 (Node 2 (Node 1 Nil Nil) (Node 1 (Node 10 Nil Nil) Nil)) (Node 3 Nil Nil)

getChildren :: BTree -> [BTree]
getChildren Nil = []
getChildren (Node _ l r) = [l, r]

getGrandchildren :: BTree -> [BTree]
getGrandchildren Nil = []
getGrandchildren (Node _ l r) = getChildren l ++ getChildren r

examineNode :: Int -> BTree -> Bool
examineNode _ Nil = True
examineNode v (Node nv _ _) = nv > v

examineGrandchildren :: BTree -> [BTree] -> Bool
examineGrandchildren _ [] = True
examineGrandchildren Nil _ = True
examineGrandchildren root@(Node v _ _) (t:ts) 
 | examineNode v t == False = False
 | otherwise = examineGrandchildren root ts

grandchildrenIncreased :: BTree -> Bool
grandchildrenIncreased Nil = False
grandchildrenIncreased root@(Node _ l r)
 | examineGrandchildren root (getGrandchildren root) == False = False
 | otherwise = examineGrandchildren l (getGrandchildren l) && examineGrandchildren r (getGrandchildren r)

