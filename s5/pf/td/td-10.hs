import GHC.Unicode (isDigit)
import Parser ((<|>), some, car, carQuand, Parser)

-- 5.1
intOfChar :: Char -> Int
intOfChar c = read [c]

-- Q48
somme :: Parser Int
somme = some (carQuand isDigit) >>= \n -> pure (sum (map intOfChar n))

somme' :: Parser Int
somme' = sum . map intOfChar <$> some (carQuand isDigit)

-- Q49
data Arbre
  = Feuille
  | Noeud Arbre Arbre
  deriving (Show)

hauteur :: Parser Int
hauteur = noeud <|> feuille
  where
    noeud :: Parser Int
    noeud = do
      car '('
      hg <- hauteur
      car ','
      hd <- hauteur
      car ')'

      pure (1 + max hg hd)
    -- noeud = car '(' >> hauteur >>= \hg -> car ',' >> hauteur >>= \hd -> car ')' >> pure (1 + max hg hd)
    -- application partielle, car '(' set \_ dans la fonction puis continue jusqu'à avoir les 4 autres args
    -- noeud = (\_ h1 _ h2 _ -> 1 + max h1 h2) <$> car '(' <*> hauteur <*> car ',' <*> hauteur <*> car ')'

    feuille :: Parser Int
    -- feuille = car 'F' >> pure 0
    feuille = 0 <$ car 'F'

-- Q50
expr :: Parser Int
expr = binaire <|> entier
  where
    binaire :: Parser Int
    binaire = (\op _ x _ y -> charToOp op x y) <$> carQuand (`elem` ['+', '-', '*']) <*> car ' ' <*> expr <*> car ' ' <*> expr
    -- binaire = do
    --   op <- carQuand isDigit
    --   car ' '
    --   x <- expr
    --   car ' '
    --   charToOp op x <$> expr

      where
        charToOp ::  Char -> (Int -> Int -> Int)
        charToOp '+' = (+)
        charToOp '-' = (-)
        charToOp '/' = (*)

    entier :: Parser Int
    entier = read <$> some (carQuand isDigit)

-- Q51
hauteur' :: Parser Int
hauteur' = noeud <|> feuille <|> unaire
  where
    noeud :: Parser Int
    noeud = do
      car '('
      hg <- hauteur
      car ','
      hd <- hauteur
      car ')'

      pure (1 + max hg hd)

    feuille :: Parser Int
    feuille = 0 <$ car 'F'

    unaire :: Parser Int
    -- unaire = car '(' >> hauteur >> hauteur >>= \hu -> car ')' >> pure (1 + hu)
    unaire = (\_ hu _-> 1 + hu) <$> car '(' <*> hauteur <*> car ')'