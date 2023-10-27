-- a -> a -> a == a -> (a -> a)
-- Equivalent a dire que a -> (a -> a) est une fonction qui retourne une fonction
-- -> == fonction

-- forme currifiée => f x y
-- forme non currifié => f (x, y)

-- Q6
curryfie :: ((t1, t2) -> t) -> t1 -> t2 -> t
curryfie f x y = f (x, y)

curryfie' :: ((t1, t2) -> t) -> t1 -> t2 -> t
curryfie' f = \x y -> f (x, y)

-- Q7
decurryfie :: (t1 -> t2 -> t) -> (t1, t2) -> t
decurryfie f (x, y) = f x y

decurryfie' :: (t1 -> t2 -> t) -> (t1, t2) -> t
decurryfie' f = \(x, y) -> f x y

-- Q18
compose :: (b -> c) -> (a -> b) -> (a -> c)
compose f g x = f (g x)

compose' :: (b -> c) -> (a -> b) -> (a -> c)
compose' f g = \x -> f (g x)

-- Types algébriques
-- Q30
data Pile a = PileVide | Cons a (Pile a)

-- Q31
estVide :: Pile a -> Bool
estVide PileVide = True
estVide _ = False
-- estVide (Cons _ _) = False

sommet :: Pile a -> Maybe a
sommet PileVide = Nothing
sommet (Cons e _) = Just e

depiler :: Pile a -> Pile a
depiler PileVide = PileVide
depiler (Cons _ p) = p

-- Q32
empiler :: a -> Pile a -> Pile a
empiler = Cons 
--empiler e p = Cons e p

-- [1, 2, 3]
empilerTout :: [a] -> Pile a -> Pile a
empilerTout [] p = p
empilerTout (x:xs) p = empiler x (empilerTout xs p)

empilerTout' :: [a] -> Pile a -> Pile a
empilerTout' [] _ = PileVide
empilerTout' xs p = undefined -- foldr

-- [3, 2, 1]
empilerTout'' :: [a] -> Pile a -> Pile a
empilerTout'' [] p = p
empilerTout'' (x:xs) p = empilerTout xs (Cons x p)

empilerTout''' :: [a] -> Pile a -> Pile a
empilerTout''' [] p = p
empilerTout''' xs p = undefined