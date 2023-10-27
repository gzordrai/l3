import Graphics.Gloss

-- Implementation
type Symbole = Char

type Mot = [Symbole]

type Axiome = Mot

type Regles = Symbole -> Mot

type LSysteme = [Mot]

-- Q1
motSuivant :: Regles -> Mot -> Mot
motSuivant _ [] = []
motSuivant f (x : xs) = f x ++ motSuivant f xs

motSuivant' :: Regles -> Mot -> Mot
motSuivant' = concatMap

-- motSuivant' f xs = concatMap f xs

motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' f xs = [s | x <- xs, s <- f x]

-- Q2
rules :: Regles
rules 'F' = "F-F++F-F"
rules '+' = "+"
rules '-' = "-"

-- Q3
lsysteme :: Axiome -> Regles -> LSysteme
lsysteme axiome f = iterate (motSuivant f) axiome

-- Tortue
type EtatTortue = (Point, Float)

type Config =
  ( EtatTortue, -- Etat initial de la tortue
    Float, -- Longueur initiale d'un pas
    Float, -- Facteur d'échelle
    Float, -- Angle pour les rotations de la tortue
    [Symbole] -- Liste des symboles compris par la tortue
  )

-- Q4
etatInitial :: Config -> EtatTortue
etatInitial (e, _, _, _, _) = e

longueurPas :: Config -> Float
longueurPas (_, x, _, _, _) = x

facteurEchelle :: Config -> Float
facteurEchelle (_, _, x, _, _) = x

angle :: Config -> Float
angle (_, _, _, x, _) = x

symbolesTortue :: Config -> [Symbole]
symbolesTortue (_, _, _, _, xs) = xs

-- Q5
avance :: Config -> EtatTortue -> EtatTortue
avance c e = ((x', y'), a)
  where
    x' = x + longueurPas c * cos a
    y' = y + longueurPas c * sin a
    ((x, y), a) = e

-- Q6
tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c ((x, y), a) = ((x, y), a + angle c)

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c ((x, y), a) = ((x, y), a - angle c)

-- Q7
filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue c = filter (`elem` symbolesTortue c)

-- filtreSymbolesTortue c m  = filter (`elem` symbolesTortue c) m

-- Q8
type EtatDessin = (EtatTortue, Path)

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (e, p) 'F' = (avance c e, fst (avance c e) : p)
interpreteSymbole c (e, p) '+' = (tourneAGauche c e, fst (tourneAGauche c e) : p)
interpreteSymbole c (e, p) '-' = (tourneADroite c e, fst (tourneADroite c e) : p)

-- Q9
-- Si on ajoute le point à la fin la compléxité est linéaire à la 1ere liste (cf td 3) alors que si on l'ajoute au debut elle est constante donc plus rapide et moins couteuse

-- Q10
interpreteMot :: Config -> Mot -> Picture
interpreteMot c m = Line (snd (f m))
  where
    f :: Mot -> EtatDessin
    f = foldl (interpreteSymbole c) (etatInitial c, [fst (etatInitial c)])

-- f m = foldl (interpreteSymbole c) (etatInitial c, [fst (etatInitial c)]) m

dessin :: Picture
dessin = interpreteMot (((-150, 0), 0), 100, 1, pi / 3, "F+-") "F+F--F+F"

lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime l c t = interpreteMot c (filtreSymbolesTortue c (l !! (round t `mod` 8)))

-- Exemples

vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
  where
    regles 'F' = "F-F++F-F"
    regles s = [s]

vonKoch2 :: LSysteme
vonKoch2 = lsysteme "F++F++F++" regles
  where
    regles 'F' = "F-F++F-F"
    regles s = [s]

hilbert :: LSysteme
hilbert = lsysteme "X" regles
  where
    regles 'X' = "+YF-XFX-FY+"
    regles 'Y' = "-XF+YFY+FX-"
    regles s = [s]

dragon :: LSysteme
dragon = lsysteme "FX" regles
  where
    regles 'X' = "X+YF+"
    regles 'Y' = "-FX-Y"
    regles s = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1 / 3, pi / 3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1 / 3, pi / 3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1 / 2, pi / 2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi / 2, "F+-")

-- Main
main :: IO ()
main = animate (InWindow "L-system" (1000, 1000) (0, 0)) white hilbertAnime

-- Not animated
-- main :: IO ()
-- main = display (InWindow "L-system" (1000, 1000) (0, 0)) white dessin