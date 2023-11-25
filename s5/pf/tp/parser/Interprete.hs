{-# LANGUAGE LambdaCase #-}

import Control.Monad qualified
import Data.Char (isAlpha, isDigit)
import Data.Maybe (fromJust)
import GHC.IO.Handle (isEOF)
import Parser (Parser, car, carQuand, chaine, many, runParser, some, (<|>))

-- Parser
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
exprP = exprParentheseeP <|> lambdaP <|> booleenP <|> nombreP <|> varP

exprsP :: Parser Expression
exprsP = applique <$> some exprP

-- Q6
lambdaP :: Parser Expression
lambdaP = do
  espacesP
  car '\\' <|> car 'λ'
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
  espacesP

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
ras s = case runParser exprsP s of
  (Just (c, [])) -> c
  _ -> error "Erreur d’analyse syntaxique"

-- Interpreter
data ValeurA
  = VLitteralA Litteral
  | VFonctionA (ValeurA -> ValeurA)

-- Q13
-- Show ne peut pas afficher de fonction (ValeurA -> ValeurA) même si un show est défini pour VLitteralA (Litteral)

-- Q14
instance Show ValeurA where
  show :: ValeurA -> String
  show (VFonctionA _) = "λ"
  show (VLitteralA (Entier x)) = show x
  show (VLitteralA (Bool x)) = show x

type Environnement a = [(Nom, a)]

-- Q15
interpreteA :: Environnement ValeurA -> Expression -> ValeurA
interpreteA _ (Lit x) = VLitteralA x
interpreteA env (Var x) = fromJust (lookup x env)
interpreteA env (Lam n e) = VFonctionA (\v -> interpreteA ((n, v) : env) e)
interpreteA env (App a b) = f (interpreteA env b)
  where
    VFonctionA f = interpreteA env a

-- Q16
negA :: ValeurA
negA = VFonctionA f
  where
    f :: ValeurA -> ValeurA
    f (VLitteralA (Entier x)) = VLitteralA (Entier (negate x))

-- Q17
addA :: ValeurA
addA = VFonctionA f
  where
    f :: ValeurA -> ValeurA
    f (VLitteralA (Entier x)) =
      VFonctionA
        ( \(VLitteralA (Entier y)) ->
            VLitteralA (Entier (x + y))
        )

-- Q18
envA :: Environnement ValeurA
envA =
  [ ("neg", negA),
    ("add", releveBinOpEntierA (+)),
    ("soust", releveBinOpEntierA (-)),
    ("mult", releveBinOpEntierA (*)),
    ("quot", releveBinOpEntierA quot),
    ("if", ifthenelseA)
  ]

releveBinOpEntierA :: (Integer -> Integer -> Integer) -> ValeurA
releveBinOpEntierA f = VFonctionA g
  where
    g (VLitteralA (Entier x)) =
      VFonctionA
        ( \(VLitteralA (Entier y)) ->
            VLitteralA (Entier (f x y))
        )

-- Q19
ifthenelseA :: ValeurA
ifthenelseA = VFonctionA f
  where
    f (VLitteralA (Bool True)) = VFonctionA (VFonctionA . const)
    f (VLitteralA (Bool False)) = VFonctionA (\_ -> VFonctionA id)

-- Q20
main :: IO ()
main = do
  putStr "minilang> "
  eof <- isEOF

  if eof
    then pure ()
    else do
      line <- getLine

      let result = interpreteA envA (ras line)

      print result
      main

-- Interpreter with errors
data ValeurB
  = VLitteralB Litteral
  | VFonctionB (ValeurB -> ErrValB)

type MsgErreur = String

type ErrValB = Either MsgErreur ValeurB

-- Q21
instance Show ValeurB where
  show :: ValeurB -> String
  show (VFonctionB _) = "λ"
  show (VLitteralB (Entier x)) = show x
  show (VLitteralB (Bool x)) = show x

-- Q22
interpreteB :: Environnement ValeurB -> Expression -> ErrValB
interpreteB _ (Lit x) = Right (VLitteralB x)
interpreteB env (Var x) = maybe (Left ("La variable " ++ x ++ " n'est pas definie")) Right (lookup x env)
interpreteB env (Lam n e) = Right (VFonctionB (\v -> interpreteB ((n, v) : env) e))
interpreteB env (App a b) = case interpreteB env a of
  Left err -> Left err
  Right (VFonctionB f) -> case interpreteB env b of
    Left err -> Left err
    Right val -> f val
  Right x -> Left (show x ++ " n'est pas une fonction, application impossible")

-- Q23
addB :: ValeurB
addB = VFonctionB f
  where
    f :: ValeurB -> ErrValB
    f (VLitteralB (Entier x)) =
      Right
        ( VFonctionB
            ( \case
                VLitteralB (Entier y) -> Right (VLitteralB (Entier (x + y)))
                y -> Left (show y ++ " n'est pas un entier")
            )
        )
    f x = Left (show x ++ " n'est pas un entier")

-- Q24
quotB :: ValeurB
quotB = VFonctionB f
  where
    f :: ValeurB -> ErrValB
    f (VLitteralB (Entier x)) =
      Right
        ( VFonctionB
            ( \case
                VLitteralB (Entier 0) -> Left "Division par zero"
                VLitteralB (Entier y) -> Right (VLitteralB (Entier (x `quot` y)))
                y -> Left (show y ++ " n'est pas un entier")
            )
        )
    f x = Left (show x ++ " n'est pas un entier")

-- Interprete with traces
data ValeurC
  = VLitteralC Litteral
  | VFonctionC (ValeurC -> OutValC)

type Trace = String

type OutValC = (Trace, ValeurC)

-- Q25
instance Show ValeurC where
  show :: ValeurC -> String
  show (VFonctionC _) = "λ"
  show (VLitteralC (Entier x)) = show x
  show (VLitteralC (Bool x)) = show x

-- Q26
interpreteC :: Environnement ValeurC -> Expression -> OutValC
interpreteC _ (Lit x) = ("", VLitteralC x)
interpreteC env (Var x) = ("", fromJust (lookup x env))
interpreteC env (Lam n e) = (".", VFonctionC (\v -> interpreteC ((n, v) : env) e))
interpreteC env (App a b) =
  case interpreteC env a of
    (t, VFonctionC f) -> (t ++ t' ++ t'', r)
      where
        (t', v) = interpreteC env b
        (t'', r) = f v
    _ -> error ""

-- Q27
pingC :: ValeurC
pingC = VFonctionC (".p",)

-- Interpreter monadic
data ValeurM m
  = VLitteralM Litteral
  | VFonctionM (ValeurM m -> m (ValeurM m))

-- Q28
instance Show (ValeurM m) where
  show :: ValeurM m -> String
  show (VFonctionM _) = "λ"
  show (VLitteralM (Entier x)) = show x
  show (VLitteralM (Bool x)) = show x

newtype SimpleM v = S v
  deriving (Show)

-- Q29
interpreteSimpleM :: Environnement (ValeurM SimpleM) -> Expression -> SimpleM (ValeurM SimpleM)
interpreteSimpleM = undefined
