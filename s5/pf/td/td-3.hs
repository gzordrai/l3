-- 2.1
-- Q13
-- !!
index' :: [a] -> Int -> a
index' [] _ = undefined
index' (x:_) 0 = x
index' (x:xs) n = index' xs (n- 1)

-- ++
concat' :: [a] -> [a] -> [a]
concat' [] ys = ys
concat' xs [] = xs
concat' (x:xs) ys = x : concat' xs ys
-- concat' (x:xs) ys = concat' xs (x : ys)

concat'' :: [[a]] -> [a]
concat'' [] = []
concat'' (x:xs) = x ++ concat'' xs

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- Q14
-- Compléxité plus grande car ++ n'a pas une compléxité linéaire comme les appels récursifs
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]
-- myReverse xs = foldr (:) [] xs

-- Compléxité moins grande car uniquement linéaire
myReverse' :: [a] -> [a]
myReverse' xs = go xs []
                where
                    go :: [a] -> [a] -> [a]
                    go [] ys = ys
                    go (x:xs) ys = go xs (x:ys)

-- Q15
myButLast :: [a] -> a
myButLast xs = xs !! ((length xs) - 2)

-- Q16
compress :: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:y:xs) = if x == y
                    then compress (y : xs)
                    else x :  compress (y : xs)

-- Q17
-- Num a => a -> a
-- (\x -> x * 2) 3 => 6

-- Num a => (a -> (a -> a))
-- (\x -> \y -> x + y) ((\x -> x + x) 1) 1 => 3

-- Num a => (a -> b) -> b
-- (\x -> x 3) (\x -> x * 2) => 6

-- a -> a
-- (\x -> x) (\x -> x) 1 => 1

-- Num a => ((a -> b)) -> b
-- (\x -> x 1) (\x -> x) => 1

-- Q18 
compose :: (b -> c) -> (a -> b) -> (a -> c)
compose f g x = f (g x)