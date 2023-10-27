-- Type Maybe
-- Q38
atSafe :: [a] -> Int -> Maybe a
atSafe [] _ = Nothing
atSafe (x : xs) 0 = Just x
atSafe (x : xs) n = atSafe xs (n - 1)

-- Q39
tailSafe :: [a] -> Maybe [a]
tailSafe [] = Nothing
tailSafe (x : xs) = Just xs

-- Q40
minimumSafe :: (Ord a) => [a] -> Maybe a
minimumSafe [] = Nothing
minimumSafe [x] = Just x
minimumSafe (x : y : xs) = minimumSafe (min x y : xs) -- récursion terminale
-- minimumSafe (x : xs) = min (Just x) (minimumSafe xs) -- récursion non terminale
-- minimumSafe (x : xs) = Just (min x y)                -- récursion non terminale
--   where
--     (Just y) = minimumSafe xs

-- Pliages (poly séparé)
sommeCarres :: Num a => [a] -> a
sommeCarres = foldr (\x y -> x * x + y) 0
-- sommeCarres = foldl (\acc x -> acc + x * x) 0 xs

min' :: Ord a =>  Maybe a -> a -> Maybe a
min' Nothing x = Just x
min' (Just x) y = Just (min x y)

minListe :: Ord a => [a] -> Maybe a
minListe = foldl min' Nothing

minListe' :: Ord a => [a] -> Maybe a
-- minListe' = foldr (x y -> min' y x) Nothing
minListe' = foldr (flip min') Nothing

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x acc -> if p x then x : acc else acc) []
-- filter p = foldl (\acc x -> if p x then x : acc else acc) []
