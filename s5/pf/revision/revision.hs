import Data.List.NonEmpty (unfold)
-- 1
-- 1.1
-- Q1
sommeDeXaY :: Int -> Int -> Int
sommeDeXaY x y = sum [x .. y]

-- Q2
sommeListe :: (Num a) => [a] -> a
sommeListe = sum

-- Q3
produitListe :: (Num a) => [a] -> a
produitListe [] = 0
produitListe (x : xs) = x * produitListe xs

-- 1.2
-- Q4
-- ['a', 'b', 'c']                  [Char]
-- [(False, '0'), (True, '1')]      [(Bool, Char)]
-- ([False, True], ['0', '1'])      ([Bool], [Char])
-- (['a', 'b'], 'c')                ([Char], Char)
-- [tail, init, reverse]            [[a] -> a]
-- take 5                           [a]

-- Q5
second :: [a] -> a
second xs = head (tail xs)

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

pair :: a -> b -> (a, b)
pair x y = (x, y)

fst :: (a, b) -> a
fst (x, _) = x

double :: (Num a) => a -> a
double x = x * 2

palindrome :: (Eq a) => [a] -> Bool
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f (f x)

-- 1.3
-- Q6
curryfie :: ((t1, t2) -> t) -> t1 -> t2 -> t
curryfie f x y = f (x, y)

-- Q7
decurryfie :: (t1 -> t2 -> t) -> (t1, t2) -> t
decurryfie f (x, y) = f x y

-- 1.4
-- Q8
itere :: (t -> t) -> Int -> t -> t
itere _ 0 x = x
itere f n x = itere f (n - 1) (f x)

-- 1.5
-- Q9
f1 :: t -> t
f1 x = x

f2 :: a -> b -> a
f2 x _ = x

f3 :: (a -> b -> c) -> b -> a -> c
f3 f x y = f y x

f4 :: a -> b -> b
f4 _ y = y

f5 :: (t1 -> t) -> t1 -> t
f5 f = f

f6 :: (t2 -> t1) -> (t1 -> t) -> t2 -> t
f6 f g = g . f

f7 :: (Eq a) => a -> a -> Bool
f7 x y = x == y

f8 :: (Num a) => t -> a
f8 _ = 0

f9 :: (Eq a) => (t -> a) -> (t1 -> a) -> t -> t1 -> Bool
f9 f g x y = f x == g y

f10 :: (Eq a, Num a1, Num a2) => (a -> a2 -> a1) -> a -> a -> a1
f10 f x y =
  if x == y
    then f x 2 + 1
    else f x 3 + 1

f11 :: (t2 -> t1 -> t) -> (t2 -> t1) -> t2 -> t
f11 f g x = f x (g x)

f12 :: t -> t1
f12 _ = undefined

-- 1.6
-- Q10
g1 :: (Num a) => a -> a -> a
g1 x y = x + y

g2 :: (Num a, Num a1) => (a1 -> a) -> a
g2 f = f 10

g3 :: (Num a) => a -> (a -> a)
g3 x y = x + y

g4 :: (Num a) => a -> a -> a -> a
g4 x y z = x + y + z

g5 :: (Num a) => a -> (a -> a) -> a
g5 x f = f x

g6 :: (Num a) => (a -> a) -> a -> a
g6 = flip g5

g7 :: (Num a, Num a1, Num a2) => (a1 -> a2 -> a) -> a
g7 f = undefined

-- 1.7
-- Q11

h1 :: (a -> b -> c) -> a -> b -> c
h1 f x y = f x y

h2 :: (a -> b -> c) -> a -> b -> c
h2 f x y = (f x) y

h3 :: (b -> c) -> (a -> b) -> a -> c
h3 f x y = f (x y)

h4 :: (b -> c) -> (a -> (b -> c) -> b) -> a -> c
h4 f x y = f (x y f)

h5 :: (a -> b -> c) -> a -> ((a -> b -> c) -> b) -> c
h5 f x y = (f x) (y f)

h6 :: (Num a) => (a -> a) -> a -> a -> a
h6 f x y = (f x) + (f y)

h7 :: (a -> b) -> ((a -> b) -> b -> c) -> a -> c
h7 f x y = x f (f y)

h8 :: (a -> b -> a) -> a -> b -> b -> a
h8 f x y = f (f x y)

-- 2
-- 2.1
-- Q12
last' :: [a] -> a
last' = head . reverse

init' :: [a] -> [a]
init' = reverse . tail . reverse

-- Q13
index' :: [a] -> Int -> a
index' [] _ = undefined
index' (x : _) 0 = x
index' (x : xs) n = index' xs (n - 1)

concat' :: [a] -> [a] -> [a]
concat' [] ys = ys
concat' xs [] = xs
concat' (x:xs) ys = x : concat' xs ys

concat'' :: [[a]] -> [a]
concat'' [] = []
concat'' (x : xs) = x ++ concat'' xs

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs

-- Q14
myReverse :: [a] -> [a]
myReverse [] = []
myReverse xs = go [] xs
  where
    go :: [a] -> [a] -> [a]
    go acc [] = acc
    go acc (y : ys) = go (y : acc) ys

-- Q15
myButLast :: [a] -> a
myButLast [] = undefined
myButLast [x] = undefined
myButLast [x, y] = x
myButLast (x : xs) = myButLast xs

-- Q16
compress :: (Eq a) => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x : y : xs) =
  if x == y
    then compress (y : xs)
    else x : compress (y : xs)

-- 2.2
-- Q17
-- (\x -> x * 2) 3                            6
-- (\x -> \y -> x + y) ((\x -> x + x) 1) 1    3
-- (\x -> x 3) (\x -> x * 2)                  6
-- (\x -> x) (\x -> x) 1                      1
-- (\x -> x 1) (\x -> x)                      1

-- Q18
compose :: (b -> c) -> (a -> b) -> (a -> c)
compose f g x = f (g x)

-- 2.3
-- Q19
somFac :: Integer -> Integer
somFac n = sum $ map factorial $ digits n
  where
    digits :: (Integral a) => a -> [a]
    digits 0 = []
    digits x = digits (x `div` 10) ++ [x `mod` 10]

    factorial 0 = 1
    factorial x = x * factorial (x - 1)

-- Q20
findNums :: [Integer]
findNums = filter (\n -> n == somFac n) [10..9999999]

-- Q21
vol :: Integer -> [Integer]
vol 0 = [somFac 0]
vol n = n : vol (somFac n)

-- Q22
-- detectCycle :: [Integer] -> Bool
-- detectCycle [] = False
-- detectCycle [x] = False
-- detectCycle (x : xs) = foldr (\y acc -> acc || x == y) False xs

-- detectCycleStart :: Eq a => [a] -> Maybe a
-- detectCycleStart vol = go vol vol
--   where
--     go tortoise hare
--       | null hare || null (tail hare) = Nothing
--       | head tortoise == head (tail hare) = Just (head tortoise)
--       | otherwise = go (tail tortoise) (tail (tail hare))


-- Q23

-- Q24

-- 3
-- 3.1
-- Q25
sumfl :: [Int] -> Int
sumfl = foldl (+) 0

sumfr :: [Int] -> Int
sumfr = foldr (+) 0

-- Q26
(+++) :: [a] -> [a] -> [a]
(+++) xs ys = foldr (:) ys xs

concat''' :: [[a]] -> [a]
concat''' = foldl (++) []

-- Q27
map'' :: (a -> a) -> [a] -> [a]
map'' f = foldr (\x acc -> f x : acc) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' f = foldr (\x acc -> if f x then x : acc else acc) []

-- Q28
digitsToInt :: [Int] -> Int
digitsToInt = foldl (\acc x -> acc * 10 + x) 0

-- Q29
-- intToBin converti un int en binaire

-- 3.2
-- Q30
data Pile a = PileVide | Cons a (Pile a)
  deriving (Show)

-- Q31
estVide :: Pile a -> Bool
estVide PileVide = True
estVide _ = False

sommet :: Pile a -> Maybe a
sommet PileVide = Nothing
sommet (Cons x _) = Just x

depiler :: Pile a -> Pile a
depiler PileVide = PileVide
depiler (Cons _ p) = p

-- Q32
empiler :: a -> Pile a -> Pile a
empiler x p = Cons x p

empilerTout :: [a] -> Pile a -> Pile a
empilerTout (x : xs) p = empiler x (empilerTout xs p)

empilerTout' :: [a] -> Pile a -> Pile a
empilerTout' xs p = foldr (\x acc -> Cons x acc) p xs

-- 3.3
-- Q33
data Expression = Feuille Float | Noeud Operator Expression Expression
  deriving (Show)

data Operator = Plus | Moins | Mult | Divise
  deriving (Show)

-- Q34
showExpr :: Expression -> String
showExpr (Feuille x) = show x
showExpr (Noeud o fg fd) = "(" ++ showExpr fg ++ showOp o ++ showExpr fd ++ ")"

showOp :: Operator -> String
showOp Plus = "+"
showOp Moins = "-"
showOp Mult = "*"
showOp Divise = "/"

-- Q35
eval :: Expression -> Float
eval (Feuille x) = x
eval (Noeud o fg fd) = evalOp o (eval fg) (eval fd)

evalOp :: Operator -> (Float -> Float -> Float)
evalOp Plus = (+)
evalOp Moins = (-)
evalOp Mult = (*)
evalOp Divise = (/)

-- Q36
data ElemNP = ValNP Float | OpNP Operator
type ExpressionNP = Pile ElemNP

-- Q37
parse :: ExpressionNP -> Expression
parse e = e'
  where
    (e', _) = parse' e

parse' :: ExpressionNP -> (Expression, ExpressionNP)
parse' (Cons (ValNP x) p) = (Feuille x, p)
parse' (Cons (OpNP o) p) = (Noeud o fg fd, p'')
  where
    (fg, p') = parse' p
    (fd, p'') = parse' p'

-- 3
-- Q38
atSafe :: [a] -> Int -> Maybe a
atSafe [] _ = Nothing
atSafe (x : xs) 0 = Just x
atSafe (x : xs) i = atSafe xs (i - 1)

-- Q39
tailSafe :: [a] -> Maybe [a]
tailSafe [] = Nothing
tailSafe (_ : xs) = Just xs

-- Q40
minimumSafe :: (Ord a, Num a) => [a] -> Maybe a
minimumSafe [] = Nothing
minimumSafe [x] = Just x
minimumSafe (x : y : xs) = minimumSafe (min x y : xs)

-- Q41
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f acc (x : xs) = foldr' f (f x acc) xs

-- Feuille pliage
-- Q1
sommeCarres :: (Num a) => [a] -> a
sommeCarres = foldl (\acc x -> acc + x * x) 0

-- Q2
min' :: (Ord a) =>  Maybe a -> a -> Maybe a
min' Nothing x = Just x
min' (Just x) y = Just (min x y)

minListe :: (Ord a) => [a] -> Maybe a
minListe = foldl min' Nothing

-- Q3
-- f :: b -> [a] -> b

-- Q4
element :: (Eq a) => [a] -> a ->  Bool
element xs y = foldl (\acc x -> acc || x == y) False xs

-- Q5
filter'' :: (a -> Bool) -> [a] -> [a]
filter'' f = foldl (\acc x -> if f x then x : acc else acc) []

-- Q6
suffixes :: [a] -> [[a]]
suffixes = foldr op [[]]
  where
    op x acc@(y : _) = (x : y) : acc

-- Q7
prefixes :: [a] -> [[a]]
prefixes = foldl op [[]]
  where
    op acc@(x : _) y = (x ++ [y]) : acc

-- Q8
exApprox :: (Enum a, Fractional a) => a -> a -> a
exApprox x n = snd (foldl op (1, 1) [x..n])
  where
    op (t, s) k = (t * x / k, s + t * x / k)

-- Q9
premier :: (a -> Bool) -> [a] -> Maybe a
premier f = foldr (\x acc -> if f x then Just x else acc) Nothing

-- Q10
dernier :: (a -> Bool) -> [a] -> Maybe a
dernier f = foldl (\acc x -> if f x then Just x else acc) Nothing

-- Q11
data Exp = Val Float | Bop Operator Exp Exp

type NP = [Either Operator Float]

parse'' :: NP -> Maybe [Exp]
parse'' = foldr op (Just [])
  where
    op :: Either Operator Float -> Maybe [Exp] -> Maybe [Exp]
    op (Right v) (Just acc) = Just (Val v : acc)
    op (Left o) (Just (e1 : e2 : acc)) = Just (Bop o e1 e2 : acc)
    op _ _ = Nothing