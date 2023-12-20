import Control.Monad qualified
import Data.Char (isAlpha, isDigit)
import Parser ( car, carQuand, (<|>), many, some, Parser )

-- Q1.1 1"
espP :: Parser ()
espP = Control.Monad.void (many (car ' '))

-- Q1.2 2"30
carG :: Char -> Parser ()
carG c = espP >> car c >> pure ()

carD :: Char -> Parser ()
carD c = car c >> espP

carE :: Char -> Parser ()
carE c = espP >> car c >> espP

-- Q1.3 0"30
nomP :: Parser String
nomP = some (carQuand isAlpha)

-- Q1.4 0"50
intP :: Parser Int
intP = read <$> some (carQuand isDigit)

-- Q1.5
data Caisse = Caisse
  { contenu :: String,
    poids :: Int
  }
  deriving (Show)

-- 2"16
caisseP :: Parser Caisse
caisseP = do
  carE '['
  c <- nomP
  carE ','
  p <- intP
  carE ']'

  pure (Caisse c p)

-- 5"50
caissePM :: Parser Caisse
caissePM =
  carE '['
    >> nomP
    >>= \c ->
      carE ','
        >> intP
        >>= \p ->
          carE ']'
            >> pure (Caisse c p)

-- 5"52
caissePA :: Parser Caisse
caissePA = Caisse <$> (carE '[' *> nomP) <*> (carE ',' *> intP <* carE ']')

-- Q1.6 5"29
ligneP :: Parser [Maybe Caisse]
ligneP = do
  carE '|'
  some (Just <$> caisseP <|> pure Nothing >>= \v -> carE '|' >>  pure v)

  -- where
  --   f :: Parser [Maybe Caisse]
  --   f = do
  --     c <- Just <$> caisseP <|> pure Nothing
  --     carE '|'
  --     cs <- f <|> pure []
  --     -- car '\n'

  --     pure (c : cs)

-- Q1.7
lignesP :: Parser [[Maybe Caisse]]
lignesP = do
  l <- ligneP
  ls <- lignesP <|> pure []

  pure (l : ls)

-- Q1.8
transposition :: [[Int]] -> [[Int]]
transposition [] = repeat []
transposition (l : ls) = f l (transposition ls)
  where
    f :: [Int] -> [[Int]] -> [[Int]]
    f [] _ = []
    f (x : xs) (l' : ls') = (x : l') : f xs ls'
-- foldr (zipWith (:)) (repeat []) l

-- Q1.9
pileCorrecte :: [Maybe Caisse] -> Bool
pileCorrecte xs = isCorrect (removeNothing xs)
  where
    removeNothing :: [Maybe Caisse] -> [Maybe Caisse]
    removeNothing [] = []
    removeNothing (Nothing : xs) = removeNothing xs
    removeNothing xs@(Just _ : _) = xs

    isCorrect :: [Maybe Caisse] -> Bool
    isCorrect [] = True
    isCorrect (Just x : xs) = isCorrect xs
    isCorrect (Nothing : xs) = False

-- Q1.10
enleveMaybe :: [Maybe a] -> [a]
enleveMaybe [] = []
enleveMaybe (Just x : xs) = x : enleveMaybe xs
enleveMaybe (Nothing : xs) = enleveMaybe xs

-- Q1.11
pilesCaisse :: Parser [[Caisse]]
pilesCaisse = undefined
-- pilesCaisse = do
--   ls <- lignesP

--   f ls

--   pure []
--   where
--     f :: [[Maybe Caisse]] -> [[Maybe Caisse]]
--     f (c : cs) = if pileCorrecte c then [] else []

-- Q2
data Noeud
  = Rep String [Noeud]
  | Fichier String Int
  deriving (Show)

type Fichiers = [Noeud]

foldN :: (String -> [a] -> a) -> (String -> Int -> a) -> Noeud -> a
foldN rep fich (Rep n lf) = rep n (map (foldN rep fich) lf)
foldN _ fich (Fichier n t) = fich n t

-- Q2.1 15m
tailleN :: Noeud -> Int
tailleN = foldN (\_ fs -> somme fs) (\_ t -> t)
  where
    somme :: (Num a) => [a] -> a
    somme [] = 0
    somme (x : xs) = x + somme xs

-- Q2.2 10m
tailleF :: Fichiers -> [(String, Int)]
tailleF = map f
  where
    f :: Noeud -> (String, Int)
    f (Rep n fs) = (n, sum (map tailleN fs))
    f (Fichier n t) = (n, t)

-- Q2.3 20m
fichiersN :: Noeud -> [[String]]
fichiersN = foldN (\nom chemins -> map (nom :) (f chemins)) (\nom _ -> [[nom]])
  where
    f :: [[a]] -> [a]
    f [] = []
    f (x : xs) = x ++ f xs

-- Q2.4 3m
fichiersF :: Fichiers -> [[String]]
fichiersF fs = concat f
  where
    f = map fichiersN fs

-- Q2.5 8m
descendreRep :: String -> Fichiers -> Maybe Fichiers
descendreRep _ [] = Nothing
descendreRep n ((Rep n' fs') : fs) =
  if n == n'
    then Just fs'
    else descendreRep n fs
descendreRep n (_ : fs) = descendreRep n fs

-- Q2.6 -- 10m
cd :: [String] -> Fichiers -> Maybe Fichiers
cd ps fs = foldl (\(Just fs') chemin -> descendreRep chemin fs') (Just fs) ps