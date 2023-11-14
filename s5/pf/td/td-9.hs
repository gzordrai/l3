import Control.Monad qualified
import Data.Char (isDigit)
import Parser

-- Q46
espacesP :: Parser ()
espacesP = Control.Monad.void (many (car ' '))

-- espacesP = many (car ' ') >> pure ()

espacesP' :: Parser ()
espacesP' = (car ' ' >> espacesP') <|> pure ()

espacesP'' :: Parser ()
espacesP'' =
  ( do
      car ' '
      espacesP''
  )
    <|> pure ()

-- Q47
entier :: Parser Int
entier = read <$> some (carQuand isDigit)

entier' :: Parser Int
entier' = do
  n <- some (carQuand (`elem` ['0' .. '9']))

  pure (read n)

entier'' :: Parser Int
entier'' = some (carQuand (\c -> c `elem` ['0' .. '9'])) >>= \n -> pure (read n)

entier''' :: Parser Int
entier''' = read <$> p
  where
    p :: Parser String
    p = carQuand isDigit >>= \c -> p <|> pure [] >>= \cs -> pure (c : cs)

entier'''' :: Parser Int
entier'''' = read <$> p
  where
    p :: Parser String
    p = do
      c <- carQuand isDigit
      cs <- p <|> pure []

      pure (c : cs)

entier''''' :: Parser Int
entier''''' = read <$> p
  where
    p :: Parser String
    p = (:) <$> carQuand isDigit <*> (p <|> pure []) -- (c:) :: [Char] -> [Char]

entierS :: Parser Int
entierS = entierN <|> entier
  where
    entierN :: Parser Int
    entierN = negate <$> (car '-' >> entier)
    -- entierN = car '-' >> negate <$> entier
    -- entierN = car ' ' >> entier >>= \n -> pure (negate n)