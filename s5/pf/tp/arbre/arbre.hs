import Control.Concurrent (threadDelay)
import Data.Maybe (isJust)
import Test.QuickCheck

-- Q1
data Arbre c v = Feuille | Noeud c v (Arbre c v) (Arbre c v)
  deriving (Show)

-- Q2
mapArbre :: (c -> c') -> (v -> v') -> Arbre c v -> Arbre c' v'
mapArbre _ _ Feuille = Feuille
mapArbre f g (Noeud c v fg fd) = Noeud c' v' fg' fd'
  where
    c' = f c
    v' = g v
    fg' = mapArbre f g fg
    fd' = mapArbre f g fd

-- Q3
hauteur :: Arbre c v -> Int
hauteur Feuille = 0
hauteur (Noeud c v fg fd) = max hg hd
  where
    hg = 1 + hauteur fg
    hd = 1 + hauteur fd

taille :: Arbre c v -> Int
taille Feuille = 1
taille (Noeud _ _ fg fd) = 1 + taille fg + taille fd

-- Q4
dimension :: (a -> a -> a) -> a -> Arbre c v -> a
dimension _ v Feuille = v
dimension f ca (Noeud c v fg fd) = dimension f ca fg `f` dimension f ca fd

dimension' :: (a -> a -> a) -> a -> Arbre c v -> a
dimension' _ v Feuille = v
dimension' f ca (Noeud c v fg fd) = dimension f ca fg `f` dimension f ca fd

-- Q5
peigneGauche :: [(c, v)] -> Arbre c v
peigneGauche [] = Feuille
peigneGauche ((c, v) : xs) = Noeud c v (peigneGauche xs) Feuille

-- Q6
prop_hauteurPeigne :: [(c, v)] -> Bool
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)

-- Elle vérifie si la hauteur correspond à la taille de la liste qui a servie a créer l'arbre

-- Q7
prop_taillePeigne :: [(c, v)] -> Bool
prop_taillePeigne xs = length xs * 2 + 1 == taille (peigneGauche xs)

-- prop_mapArbre :: [(c, v)] -> Bool
-- prop_mapArbre xs =

prop_dimensionPeigne :: [(c, v)] -> Bool
prop_dimensionPeigne xs = length xs == dimension (\x y -> 1 + max x y) 0 (peigneGauche xs)

-- Q8
estParfait :: Arbre c v -> Bool
estParfait Feuille = True
estParfait (Noeud c v fg fd) = hauteur fg == hauteur fd && estParfait fg && estParfait fd

-- Q9
-- Oui il est possible de le faire
estParfait' :: Arbre c v -> Bool
estParfait' Feuille = True
estParfait' a = isJust x
  where
    x = dimension (\(Just hfg) (Just hfd) -> if hfg == hfd then Just (1 + hfd) else Nothing) (Just 0) a

-- dimension (\(Just hfg) (Just hfd) -> if hfg == hfd then Just (1 + hfd) else Nothing) (Just 0) (Noeud 'c' 'v' (Noeud 'c' 'v' Feuille Feuille) (Noeud 'c' 'v' Feuille Feuille))

-- Q10
-- TO FIX
prop_peigneGaucheParfait :: [(c, v)] -> Bool
prop_peigneGaucheParfait xs = estParfait (peigneGauche xs)

-- Q11
parfait :: Int -> [(c, a)] -> Arbre c a
parfait k vs = fst (parfait' k vs)
  where
    parfait' 0 ls = (Feuille, ls)
    parfait' n ls = (Noeud c v fg fd, ls'')
      where
        (fg, (c, v) : ls') = parfait' (n - 1) ls
        (fd, ls'') = parfait' (n - 1) ls'

-- Noeuds: 2 ^ (n + 1) - 1
-- Feuilles: (2 ^ (n + 1) - 1) / 2

-- Q12
infinite :: a -> [a]
infinite = iterate id

-- Q13
pairs :: [a] -> [((), a)]
pairs = map ((),)

-- Q14
aplatit :: Arbre c a -> [(c, a)]
aplatit Feuille = []
aplatit (Noeud c a fg fd) = (c, a) : aplatit fg ++ aplatit fd

prop_aplatit :: [(c, Char)] -> Bool
prop_aplatit xs = map snd (aplatit (parfait 4 xs)) == "abcdefghijklmno"

-- Q15
element :: (Eq a) => a -> Arbre c a -> Bool
element _ Feuille = False
element e (Noeud c a fg fd) = (e == a) || (element e fg || element e fd)

-- Q16
noeud :: (c -> String) -> (a -> String) -> (c, a) -> String
noeud f g (c, a) = "\t" ++ g a ++ " [color = " ++ color ++ " , fontcolor = " ++ color ++ "]"
  where
    color = f c

-- Q17
arcs :: Arbre c a -> [(a, a)]
arcs Feuille = []
arcs (Noeud _ _ Feuille Feuille) = []
arcs (Noeud _ a fg@(Noeud _ a1 _ _) Feuille) = (a, a1) : arcs fg
arcs (Noeud _ a Feuille fd@(Noeud _ a2 _ _)) = (a, a2) : arcs fd
arcs (Noeud _ a fg@(Noeud _ a1 _ _) fd@(Noeud _ a2 _ _)) = (a, a1) : (a, a2) : arcs fg ++ arcs fd

-- Q18
arc :: (a -> String) -> (a, a) -> String
arc f (a, b) = "\t" ++ f a ++ " -> " ++ f b

-- Q19
dotise :: String -> (c -> String) -> (a -> String) -> Arbre c a -> String
dotise n f g a = header ++ options ++ noeuds ++ "\n" ++ acs ++ "}"
  where
    header = "digraph \"" ++ n ++ "\" {\n"
    options = "\tnode [fontname = \"DejaVu-Sans\", shape = circle]\n\n"
    noeuds = unlines (map (noeud f g) (aplatit a))
    acs = unlines (map (arc g) (arcs a))

-- Q20
-- Maybe v instead of bool ?
elementR :: (Ord v) => v -> Arbre c v -> Bool
elementR _ Feuille = False
elementR e (Noeud _ v fg fd)
  | e == v = True
  | e < v = elementR e fg
  | e > v = elementR e fd

-- Q21
data Couleur
  = R
  | N
  deriving (Show, Eq)

type ArbreRN a = Arbre Couleur a

-- Q22
equilibre :: ArbreRN a -> ArbreRN a
equilibre Feuille = Feuille
equilibre (Noeud N z (Noeud R y (Noeud R x xg xd) yd) zd) = Noeud R y (Noeud N x xg xd) (Noeud N z yd zd)
equilibre (Noeud N z (Noeud R x xg (Noeud R y yg yd)) zd) = Noeud R y (Noeud N x xg yg) (Noeud N z yd zd)
equilibre (Noeud N x xg (Noeud R z (Noeud R y yg yd) zd)) = Noeud R y (Noeud N x xg yg) (Noeud N z yd zd)
equilibre (Noeud N x xg (Noeud R y yg (Noeud R z zg zd))) = Noeud R y (Noeud N x xg yg) (Noeud N z zg zd)
equilibre (Noeud c v fg fd) = Noeud c v fg fd

equilibre' :: Couleur -> a -> ArbreRN a -> ArbreRN a -> ArbreRN a
equilibre' c v (Noeud c' v' fg' fd') (Noeud c'' v'' fg'' fd'') = undefined

-- Q23
insertVal :: (Ord a) => a -> ArbreRN a -> ArbreRN a
insertVal v a = Noeud N val fg fd
  where
  f :: (Ord a) => a -> ArbreRN a -> ArbreRN a
  f v Feuille = Noeud R v Feuille Feuille
  f v' a'@(Noeud c v'' fg fd)
    | v' == v'' = a'
    | v' > v'' = Noeud c v'' fg (equilibre (f v' fd))
    | v' < v'' = Noeud c v'' (equilibre (f v' fg)) fd

  (Noeud _ val fg fd) = equilibre (f v a)

-- Q24

-- Q25
(====) :: (Eq a) => ArbreRN a -> ArbreRN a -> Bool
(====) Feuille Feuille = True
(====) (Noeud c v fg fd) (Noeud c' v' fg' fd') = c == c' && v == v' && fg ==== fg' && fd ==== fd'
(====) _ _ = False

(~===) :: (Eq a) => ArbreRN a -> ArbreRN a -> Bool
(~===) Feuille Feuille = False
(~===) (Noeud c v fg fd) (Noeud c' v' fg' fd') = c /= c' || v /= v' || fg ~=== fg' || fd ~=== fd'
(~===) _ _ = True

-- Q26
arbresDot :: [Char] -> [String]
arbresDot cs = f cs Feuille
  where
    colorToString :: Couleur -> String
    colorToString N = "Black"
    colorToString R = "Red"

    valToString :: Char -> String
    valToString v = [v]

    f :: [Char] -> ArbreRN Char -> [String]
    f [] _ = []
    f (c : cs') a = dotise "arbre" colorToString valToString arbre : f cs' arbre
      where
        arbre = insertVal c a

main :: IO ()
main = mapM_ ecrit arbres
  where
    ecrit a = do
      writeFile "arbre.dot" a
      threadDelay 1000000
    arbres = arbresDot "gcfxieqzrujlmdoywnbakhpvst"