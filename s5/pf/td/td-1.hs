-- Partie 1
-- 1.1
-- Q1
sommeDeXaY :: Int -> Int -> Int
sommeDeXaY x y = sum [x..y]
-- sommeDeXaY x y | x > y     = 0
--                | otherwise = x + sommeDeXaY (x + 1) y

-- Q2
sommeListe :: [Int] -> Int
sommeListe [] = 0
sommeListe (x:xs) = x + sommeListe xs
-- sommeListe xs    | null xs = 0
-- sommeListe       | othewise = head xs + sommeListe (tail xs)

-- Q3
produitListe :: [Int] -> Int
produitListe [] = 1
produitListe (x:xs) = x * produitListe xs

-- 1.2
-- Q4
-- ['a', 'b', 'c']                 -- [Char]
-- [(False, '0'), (True, '1')]     -- [(Bool, Char)]
-- ([False, True], ['0', '1'])     -- ([Bool], [Char])
-- (['a', 'b'], 'c')               -- ([Char], Char)
-- [tail, init, reverse]           -- [[a] -> [a]]
-- take 5                          -- Int -> [a] -> [a]
-- -- take => Application partielle car il manque l'arguemnt [a]
-- -- (['a', 'b'], 'c') devient [('a', 'b'), 'c']
-- [('a', 'b'), 'c']               -- 2 éléments de type différents (invalide)

-- Q5
second :: [a] -> a
second xs = head (tail xs)

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

pair :: a -> b -> (a, b)
pair x y = (x, y)

fst  :: (a, b) -> a
fst (x, _) = x

-- double :: Int -> Int
double :: Num a => a -> a
double x = x * 2

palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f (f x)