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