import Parser

-- Q44
-- type Resultat a = Maybe (a, String)

-- data Parser a = MkParser {runParser :: String -> Resultat a}

-- toutp :: Parser String
-- toutp = MkParser (\s -> Just (s, []))

-- uncar :: Parser Char
-- uncar = MkParser f
--   where
--     f [] = Nothing
--     f (c : cs) = Just (c, cs)

-- Q45
-- runParser empty "haskell"                      Nothing
-- runParser (pure 5) "haskell"                   Just (5, "Haskell")
-- runParser unCaractereQuelconque "haskell"      Just ('h', "askell")
-- runParser (empty <|> pure 5) "haskell"         Just (5, "Haskell")
-- runParser (pure 5 <|> empty) "haskell"         Just (5, "Haskell")
-- runParser (empty >>= \_ -> pure 5) "haskell"   Nothing (empty >> pure 5)
-- runParser (pure 5 >>= \_ -> empty) "haskell"   Nothing
-- runParser (unCaractereQuelconque >>= \c ->     Just ("ha", "skell")
--    unCaractereQuelconque >>= \c' ->
--      pure [c',c]) "haskell"