-- 1.4
-- Q8
itere :: (t -> t) -> Int -> t -> t
itere _ 0 x = x
itere f n x = f (itere f (n - 1) x)

-- 1.5
-- Q9
f1 :: t -> t
f1 x = x

f2 :: a -> b -> a
f2 x y = x

f3 :: (a -> b -> c) -> b -> a -> c
f3 f x y = f y x

f4 :: a -> b -> b
f4 x y = y

f5 :: (t1 -> t) -> t1 -> t
f5 f x = f x
-- f5 f = f

f6 :: (t2 -> t1) -> (t1 -> t) -> t2 -> t
f6 f g = g . f
-- f6 f g x = (g . f) x
-- f6 f g x = g (f x)

f7 :: Eq a => a -> a -> Bool
f7 x y = x == y

f8 :: Num a => t -> a
f8 _ = 0

f9 :: Eq a => (t -> a) -> (t1 -> a) -> t -> t1 -> Bool
f9 f g x y = f x == g y

f10 :: (Eq a, Num a1, Num a2) => (a -> a2 -> a1) -> a -> a -> a1
f10 f x y = if x == y
            then f x 2 + 1 -- (f x 2) + 1 => (+ 1) car on est pas sur que f retourne un Num
            else f y 3 + 1

f11 :: (t2 -> t1 -> t) -> (t2 -> t1) -> t2 -> t
f11 f g x = f x (g x)

f12 :: t -> t1
f12 _ = undefined
-- f12 x = f12 x recursion infinie

-- Q11
h1 :: (a -> b -> c) -> a -> b -> c
h1 f x y = f x y

h2 :: (a -> b -> c) -> a -> b -> c
h2 f x y = (f x) y

h3 :: (b -> c) -> (a -> b) -> a -> c
h3 f x y = f (x y)

-- 2.1
-- Q12
last' :: [a] -> a
last' = head . reverse
-- last' xs = take (length xs - 1) xs

init' :: [a] -> [a]
init' = reverse . tail . reverse