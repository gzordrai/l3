-- Feuilles pliages
-- Q4
element :: (Eq a) => a -> [a] -> Bool
element y = foldl (\acc x -> acc || x == y) False

-- Q6
suffixes :: [a] -> [[a]]
suffixes = foldr op [[]]
  where
    op y acc@(x : _) = (y : x) : acc

suffixes' :: [a] -> [[a]]
suffixes' xs = snd (foldr op ([], [[]]) xs)
  where
    op x (s, ss) = let s' = x : s in (s', s' : ss)

suffixes'' :: [a] -> [[a]]
suffixes'' = foldl op [[]]
  where
    op acc x = [] : map (++ [x]) acc

-- Q7
-- TODO
prefixes :: [a]
prefixes = undefined

-- Q8
exApprox :: (Enum a, Fractional a) => a -> a -> a
exApprox n x = snd (foldl op (1, 1) [1 .. n])
  where
    op (t, s) k = (t * x / k, s + t * x / k)

-- t => x^n-1 / (n-1)!

-- Q9
premier :: (a -> Bool) -> [a] -> Maybe a
premier f = foldr (\x acc -> if f x then Just x else acc) Nothing

-- Q10
dernier :: (a -> Bool) -> [a] -> Maybe a
dernier f = foldl (\acc x -> if f x then Just x else acc) Nothing

-- Q11
data Op = Plus | Div | Mult | Minus

data Exp = Val Float | Bop Op Exp Exp

type NP = [Either Op Float]

parse :: NP -> Maybe [Exp]
parse = foldr op (Just [])
  where
    op :: Either Op Float -> Maybe [Exp] -> Maybe [Exp]
    op (Right v) (Just acc) = Just (Val v : acc)
    op (Left o) (Just (e1 : e2 : acc)) = Just (Bop o e1 e2 : acc)
    op _ _ = Nothing