-- Q3
sommeDeXaY :: Int -> Int -> Int
sommeDeXaY x y = sum [x..y]

-- Q4
somme :: [Int] -> Int
somme [] = 0
somme (x:xs) = x + somme xs

-- Q5
last' :: [a] -> a
last' = head . reverse

init' :: [a] -> [a]
-- init' [] = []
-- init' [_] = []
-- init' (x : xs) = x : init' xs
init' = reverse . tail . reverse

-- Q6
index' :: [a] -> Int -> a
index' [] _ = undefined
index' (x:xs) 0 = x
index' (x:xs) y =  index' xs (y - 1)

concatene :: [a] -> [a] -> [a]
concatene [] ys = ys
concatene xs [] = xs
concatene (x:xs) ys = x : concatene xs ys

concat' :: [[a]] -> [a]
concat' [] = []
concat' (x:xs) = x ++ concat' xs

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (y:ys) = f y : map' f ys

-- Q7
-- x = (!!) l
-- Cela représente une application partielle

-- Q8
length' :: [Int] -> Int
length' xs = somme (map (const 1) xs)

-- Q9
-- f = x*x
iterate' :: (a -> a) -> a -> Int -> [a]
iterate' f x 0 = [x]
iterate' f x n = x : iterate' f (f x) (n - 1)

iterate'' :: (a -> a) -> a -> Int -> [a]
iterate'' f x n = take (n + 1)  (iterate f x)

-- Q10
range :: Int -> [Int]
range = iterate' (+ 1) 0
-- range x = iterate' (\y -> y + 1) 0 x