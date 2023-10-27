-- Expressions arithmétiques
-- Q33
data Expression = Feuille Float | Noeud Expression Operator Expression
  deriving (Show)

data Operator = Plus | Moins | Mult | Divise
  deriving (Show)

-- Q34
showExpr :: Expression -> String
showExpr (Feuille x) = show x -- convertit x (FLoat) en Char
showExpr (Noeud fg op fd) = '(' : showExpr fg ++ showOp op ++ showExpr fd ++ ")"

showOp :: Operator -> String
showOp Plus = "+"
showOp Moins = "-"
showOp Mult = "*"
showOp Divise = "/"

-- Q35
eval :: Expression -> Float
eval (Feuille a) = a
eval (Noeud fg op fd) = eval fg `o` eval fd
  where
    o = evalOp op

evalOp :: Operator -> (Float -> Float -> Float)
evalOp Plus = (+)
evalOp Moins = (-)
evalOp Mult = (*)
evalOp Divise = (/)

-- Q36
data Pile a = PileVide | Cons a (Pile a)
data ElemNP = ValNP Float | OpNP Operator
type ExpressionNP = Pile ElemNP

-- Q37
parse :: ExpressionNP -> Expression
parse = fst . parse'
-- parse e = fst (parse' e)
-- parse e = e'
--   where (e', _) = parse' e


parse' :: ExpressionNP -> (Expression, ExpressionNP)
parse' (Cons (ValNP x) p) = (Feuille x, p)
parse' (Cons (OpNP op) p) = (Noeud fg op fd, p'')
  where
    (fg, p') = parse' p
    (fd, p'') = parse' p'