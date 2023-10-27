-- Echauffement
-- Q1
alterne :: [a] -> [a]
alterne [] = []
alterne [x] = [x]
alterne (x:_:xs) = x : alterne xs

-- Q2
combine :: (a -> b -> c) -> [a] -> [b] -> [c]
combine f [] y = []
combine f x [] = []
combine f (x:xs) (y:ys) = f x y : combine f xs ys

-- Triangle de Pascal
-- Q3
pasPascal :: [Integer] -> [Integer]
pasPascal [] = [1]
pasPascal xs = 1 : zipWith (+) xs (tail xs) ++ [1]

-- Q4
pascal :: [[Integer]]
pascal = iterate pasPascal [1]