import Control.Monad qualified
import Data.Char (isAlpha, isDigit)
import Parser

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
  c <- caisseP
  cs <- ligneP <|> pure []

  car '\n'

  pure (Just c:cs)