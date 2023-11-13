import Control.Monad qualified
import Data.Char (isAlpha, isDigit)
import Parser

type Nom = String

data Expression
  = Lam Nom Expression
  | App Expression Expression
  | Var Nom
  | Lit Litteral
  deriving (Show, Eq)

data Litteral
  = Entier Integer
  | Bool Bool
  deriving (Show, Eq)

-- Q1
espacesP :: Parser ()
espacesP = Control.Monad.void (many (car ' '))

-- espacesP = many (car ' ') >> pure ()

-- Q2
nomP :: Parser Nom
nomP = do
  espacesP
  nom <- some (carQuand isAlpha)
  espacesP

  pure nom

-- Q3
varP :: Parser Expression
varP = do
  Var <$> nomP

-- Q4
applique :: [Expression] -> Expression
applique [] = undefined
applique [e] = e
applique (e1 : e2 : es) = applique (App e1 e2 : es)

-- applique' :: [Expression] -> Expression
-- applique' (e : es) = foldl1 op e es
--   where
--     op acc x = undefined

-- Q5
exprP :: Parser Expression
exprP = exprParentheseeP <|> lambdaP <|> booleenP <|> varP

exprsP :: Parser Expression
exprsP = applique <$> some exprP

-- Q6
lambdaP :: Parser Expression
lambdaP = do
  espacesP
  car '\\'
  arg <- nomP
  espacesP
  chaine "->"
  espacesP

  Lam arg <$> exprsP

-- Q8
exprParentheseeP :: Parser Expression
exprParentheseeP = do
  espacesP
  car '('
  r <- exprsP
  car ')'

  pure r

-- Q9
nombreP :: Parser Expression
nombreP = do
  i <- some (carQuand isDigit)
  espacesP
  pure $ Lit (Entier (read i :: Integer))

-- Q10
booleenP :: Parser Expression
booleenP = do
  b <- chaine "True" <|> chaine "False"
  espacesP

  pure $ Lit (Bool (read b :: Bool))

-- Q11
expressionP :: Parser Expression
expressionP = do
  espacesP
  e <- exprP
  espacesP

  pure e

-- Q12
ras :: String -> Expression
ras = undefined

data ValeurA
  = VLitteralA Litteral
  | VFonctionA (ValeurA -> ValeurA)