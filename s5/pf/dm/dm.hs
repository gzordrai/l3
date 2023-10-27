import Data.List

data ArbreH a = Feuille a | Noeud (ArbreH a) (ArbreH a)
  deriving (Show)

data Direction = G | D
  deriving (Show)

type Codes = [Direction]

voyellesH :: ArbreH Char
voyellesH = Noeud (Feuille 'e') (Noeud (Noeud (Noeud (Feuille 'y') (Feuille 'o')) (Feuille 'i')) (Noeud (Feuille 'u') (Feuille 'a')))

-- Q1 9m
decodeH :: Codes -> ArbreH a -> (a, Codes)
decodeH c (Feuille f) = (f, c)
decodeH (G : cs) (Noeud fg _) = decodeH cs fg
decodeH (D : cs) (Noeud _ fd) = decodeH cs fd

-- Q2 13m
decodeToutH :: Codes -> ArbreH a -> [a]
decodeToutH [] _ = []
decodeToutH _ (Feuille f) = [f]
decodeToutH cs a = v : decodeToutH cs' a
  where
    (v, cs') = decodeH cs a

-- Q3 7m
data Freq a = F a Float
  deriving (Show)

voyellesF :: [Freq Char]
voyellesF = [F 'a' 17.5, F 'e' 42.2, F 'i' 14.3, F 'o' 10.4, F 'u' 14.7, F 'y' 0.8]

compareF :: Freq a -> Freq a -> Ordering
compareF (F _ p1) (F _ p2)
  | p1 == p2 = EQ
  | p1 < p2 = LT
  | p1 > p2 = GT

-- Q4 9m
sortF :: [Freq a] -> [Freq a]
sortF = sortBy compareF

-- Q5 7m
initH :: [Freq a] -> [Freq (ArbreH a)]
initH [] = []
initH ((F v p) : fs) = F (Feuille v) p : initH fs

-- Q6 13m
etapeH :: [Freq (ArbreH a)] -> [Freq (ArbreH a)]
etapeH ((F a1 p1) : (F a2 p2) : fs) = noeud : fs
  where
    noeud = F (Noeud a1 a2) (p1 + p2)

-- Q7 22m
arbreH :: [Freq a] -> ArbreH a
arbreH fs = a
  where
    ca :: [Freq (ArbreH a)] -> [Freq (ArbreH a)]
    ca [f] = [f]
    ca fas = ca (etapeH (sortF fas))
    fa = initH fs
    F a p = head (ca fa)

-- Q8 30m
codeH :: (Eq a) => ArbreH a -> (a -> Maybe Codes)
codeH a = \x -> recherche x a []
  where
    recherche :: (Eq a) => a -> ArbreH a -> Codes -> Maybe Codes
    recherche x (Feuille v) cs
      | x == v = Just cs
      | otherwise = Nothing
    recherche x (Noeud fg fd) cs =
      case (recherche x fg (cs ++ [G]), recherche x fd (cs ++ [D])) of
        (Just g, _) -> Just g
        (_, Just d) -> Just d
        _ -> Nothing
