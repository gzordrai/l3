import Graphics.Gloss

-- Courbe du dragon
-- Q5
pointAintercaler :: Point -> Point -> Point
pointAintercaler (xa, ya) (xb, yb) = (x, y)
                                    where
                                        x = (xa + xb) / 2 + (yb - ya) / 2
                                        y = (ya + yb) / 2 + (xa - xb) / 2

-- Q6
pasDragon :: Path -> Path
pasDragon [] = []
pasDragon [x] = [x]
pasDragon [x, y] = [x, pointAintercaler x y, y]
pasDragon (x:y:z:xs) = x : pointAintercaler x y : y : pointAintercaler z y : pasDragon (z : xs)

-- Q7
main :: IO ()
main = animate(InWindow "Dragon" (500, 500) (0,0)) white (dragon2 (50, 250) (450, 250))
-- main = animate(InWindow "Dragon" (500, 500) (0,0)) white (dragon1(50, 250) (450, 250) 10)

dragonAnime :: RealFrac a => (Point -> Point -> Int -> Path) ->  Point -> Point -> a -> Picture
dragonAnime f a b t = Line (f a b (round t `mod` 20))

dragon1 :: RealFrac a => Point -> Point -> a ->Picture
dragon1 = dragonAnime (\a b n -> dragon a b !! n)

dragon2 :: RealFrac a => Point -> Point -> a ->Picture
dragon2 = dragonAnime dragonOrdre

dragon :: Point -> Point -> [Path]
dragon x y = iterate pasDragon [x, y]

dragonOrdre :: Point -> Point -> Int -> Path
dragonOrdre x y 0 = [x, y]
dragonOrdre x y n = dragonOrdre x c (n - 1) ++ reverse (dragonOrdre y c (n - 1))
                    where c = pointAintercaler x y
-- dragonOrdre x y n = pointAintercaler x y : dragonOrdre y (pointAintercaler x y) (n - 1)

dragonOrdreAnime :: RealFrac a => Point -> Point -> Int -> a -> Picture
dragonOrdreAnime a b n t = Line (dragonOrdre a b n)