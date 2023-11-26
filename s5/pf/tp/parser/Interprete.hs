{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Control.Monad (ap, liftM, void)
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
espacesP = void (many (car ' '))

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

-- Q4 TODO
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
interpreteSimpleM _ (Lit x) = S (VLitteralM x)
interpreteSimpleM env (Var x) = S (fromJust (lookup x env))
interpreteSimpleM env (Lam n e) = S (VFonctionM (\v -> interpreteSimpleM ((n, v) : env) e))
interpreteSimpleM env (App a b) = f b'
  where
    S (VFonctionM f) = interpreteSimpleM env a
    S b' = interpreteSimpleM env b

-- Q30
instance Functor SimpleM where
  fmap :: (a -> b) -> SimpleM a -> SimpleM b
  fmap = liftM

instance Applicative SimpleM where
  pure :: a -> SimpleM a
  pure = S

  (<*>) :: SimpleM (a -> b) -> SimpleM a -> SimpleM b
  (<*>) = ap

instance Monad SimpleM where
  (>>=) :: SimpleM a -> (a -> SimpleM b) -> SimpleM b
  (S v) >>= f = f v

-- Q31
interpreteM :: (Monad m) => Environnement (ValeurM m) -> Expression -> m (ValeurM m)
interpreteM _ (Lit x) = pure (VLitteralM x)
interpreteM env (Var x) = pure (fromJust (lookup x env))
interpreteM env (Lam n e) = pure (VFonctionM (\v -> interpreteM ((n, v) : env) e))
interpreteM env (App a b) = interpreteM env a >>= \(VFonctionM f) -> interpreteM env b >>= f

type InterpreteM m = Environnement (ValeurM m) -> Expression -> m (ValeurM m)

interpreteS :: InterpreteM SimpleM
interpreteS = interpreteM

-- Q32
-- Le comportement de interpreteSimpleM et interpreteS sont les mêmes

newtype TraceM v = T (Trace, v)
  deriving (Show)

-- Q33
instance Functor TraceM where
  fmap :: (a -> b) -> TraceM a -> TraceM b
  fmap = liftM

instance Applicative TraceM where
  pure :: a -> TraceM a
  pure v = T ("", v)

  (<*>) :: TraceM (a -> b) -> TraceM a -> TraceM b
  (<*>) = ap

instance Monad TraceM where
  (>>=) :: TraceM a -> (a -> TraceM b) -> TraceM b
  (T (t, v)) >>= f =
    let T (t', v') = f v
     in T (t ++ t', v')

interpreteMT :: InterpreteM TraceM
interpreteMT = interpreteM

pingM :: ValeurM TraceM
pingM = VFonctionM (\v -> T ("p", v))

-- Q34 TODO
-- Redefinir un interprete ?
interpreteMT' :: InterpreteM TraceM
interpreteMT' = undefined

-- Q35
-- MonadFail m => String -> m a

data ErreurM v
  = Succes v
  | Erreur String
  deriving (Show)

-- Q36
instance Functor ErreurM where
  fmap :: (a -> b) -> ErreurM a -> ErreurM b
  fmap = liftM

instance Applicative ErreurM where
  pure :: a -> ErreurM a
  pure = Succes

  (<*>) :: ErreurM (a -> b) -> ErreurM a -> ErreurM b
  (<*>) = ap

instance Monad ErreurM where
  (>>=) :: ErreurM a -> (a -> ErreurM b) -> ErreurM b
  Succes v >>= f = f v

instance MonadFail ErreurM where
  fail :: String -> ErreurM a
  fail = Erreur

-- Q37
-- interpreteE :: InterpreteM ErreurM -- (MonadFail m) => InterpreteM m
-- interpreteE _ (Lit x) = pure (VLitteralM x)
-- interpreteE env (Var x) =
--   case lookup x env of
--     Just v -> pure v
--     Nothing -> fail ("La variable " ++ x ++ " n'est pas definie")
-- interpreteE env (Lam n e) = pure (VFonctionM (\v -> interpreteE ((n, v) : env) e))
-- interpreteE env (App a b) =
--   case interpreteE env a of
--     Erreur err -> Erreur err
--     Succes (VFonctionM f) ->
--       case interpreteE env b of
--         Erreur err -> Erreur err
--         Succes v -> f v
--     Succes x -> Erreur (show x ++ " n'est pas une fonction, application impossible")

interpreteE :: (MonadFail m) => InterpreteM m
interpreteE _ (Lit x) = return (VLitteralM x)
interpreteE env (Var x) =
  case lookup x env of
    Just v -> return v
    Nothing -> fail ("La variable " ++ x ++ " n'est pas definie")
interpreteE env (Lam n e) = return (VFonctionM (\v -> interpreteE ((n, v) : env) e))
interpreteE env (App a b) = do
  f <- interpreteE env a

  case f of
    VFonctionM g -> do
      v <- interpreteE env b
      g v
    _ -> fail (show f ++ " n'est pas une fonction, application impossible")

class Injectable m t where
  injecte :: t -> ValeurM m

instance Injectable m Bool where
  injecte :: Bool -> ValeurM m
  injecte = VLitteralM . Bool

-- Q38
instance Injectable m Integer where
  injecte :: Integer -> ValeurM m
  injecte = VLitteralM . Entier

-- Q39
instance (MonadFail m, Injectable m t) => Injectable m (Bool -> t) where
  injecte :: (MonadFail m, Injectable m t) => (Bool -> t) -> ValeurM m
  injecte f = VFonctionM (\(VLitteralM (Bool x)) -> pure $ injecte (f x))

instance (MonadFail m, Injectable m t) => Injectable m (Integer -> t) where
  injecte :: (MonadFail m, Injectable m t) => (Integer -> t) -> ValeurM m
  injecte f = VFonctionM (\(VLitteralM (Entier x)) -> pure $ injecte (f x))

-- Q40 && Q42
envM :: (MonadFail m) => Environnement (ValeurM m)
envM =
  [ ("add", injecte ((+) :: Integer -> Integer -> Integer)),
    ("soust", injecte ((-) :: Integer -> Integer -> Integer)),
    ("mult", injecte ((*) :: Integer -> Integer -> Integer)),
    ("quot", injecte (quot :: Integer -> Integer -> Integer)),
    ("et", injecte (&&)),
    ("ou", injecte (||)),
    ("non", injecte not),
    ("if", VFonctionM (\b -> pure $ VFonctionM (pure . VFonctionM . ifthenelseM b))),
    ("infst", injecte ((<) :: Integer -> Integer -> Bool))
  ]

-- Q41
-- Si il n'y avait pas les \lasy l'évaluation de fib 0 (soust n 1) et fib 0 (soust n 2) se fera immédiatement,
-- ce qui entraînera une boucle infinie car ces appels de fonction se réfèrent à eux-mêmes

-- Q42
ifthenelseM :: (MonadFail m) => ValeurM m -> ValeurM m -> ValeurM m -> m (ValeurM m)
ifthenelseM (VLitteralM (Bool b)) v1 v2 =
  if b
    then pure v1
    else pure v2
ifthenelseM _ _ _ = fail "Le premier argument doit être un Bool"