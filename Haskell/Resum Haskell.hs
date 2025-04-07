{-|
Resum Ampliat de Conceptes Bàsics de Haskell

Aquest fitxer inclou exemples per:
  • Definir tipus i classes amb deriving.
  • Funcions amb pattern matching.
  • Ús de tipus Maybe.
  • Instàncies personalitzades de Show i Eq, incloent la diferència entre tipus concrets i parametritzats.
  • Operacions de la mónada IO.
  • Operadors functor (<$>) i applicative (<*>).
  • Funcions anònimes (lambdas).
  • Llistes per comprensió.
  • Llistes infinites i recursivitat.
-}

module Main where

-- ************************************************************
-- 1. Tipus de Dades i Classes
-- ************************************************************

-- Exemple d'un tipus de dada 'Persona' (tipus concret) amb derivació automàtica de Show.
data Persona = Persona String Int
  deriving Show

-- Funció que combina dues persones (concatenant noms i sumant edats).
combinaPersones :: Persona -> Persona -> Persona
combinaPersones (Persona nom1 edat1) (Persona nom2 edat2) =
  Persona (nom1 ++ " i " ++ nom2) (edat1 + edat2)

-- ************************************************************
-- 2. Tipus Maybe
-- ************************************************************

-- La utilització de Maybe per representar resultats opcionals.
sumaTupla :: Maybe (Int, Int) -> Int
sumaTupla maybePair =
  case maybePair of
    Just (a, b) -> a + b
    Nothing     -> 0

-- ************************************************************
-- 3. Instàncies Personalitzades: Show i Eq
-- ************************************************************

-- Exemple 1: Instància de Show per a un tipus concret
-- En aquest cas, no hi ha restriccions addicionals, perquè el tipus és completament definit.
data NomClasse = NomClasse Int Int
instance Show NomClasse where
  show (NomClasse x y) = "NomClasse: " ++ show x ++ ", " ++ show y

-- Exemple 2: Instància de Show per a un tipus parametritzat
-- Aquí, el tipus (Bst a) conté elements de tipus 'a' que han de ser també instàncies de Show.
data Bst a = Empty | Node a (Bst a) (Bst a)
instance Show a => Show (Bst a) where
  show Empty = "Empty"
  show (Node x left right) =
    "Node " ++ show x ++ " (" ++ show left ++ ") (" ++ show right ++ ")"

-- També un exemple d'instància d'Eq per a un tipus racional.
data Racional = Racional Int Int  -- Representat com a numerador i denominador
instance Eq Racional where
  (Racional n1 d1) == (Racional n2 d2) = n1 * d2 == n2 * d1

{-| 
Comentari:
  - 'instance Show NomClasse where' és per a un tipus **concret** sense paràmetres, així que no cal cap restricció.
  - 'instance Show a => Show (Bst a) where' és per a un tipus **parametritzat**. La clàusula 'Show a =>' indica que per a mostrar un 'Bst a'
    s'ha de poder mostrar també el contingut de tipus 'a'. Esto permet que només es puguin crear instàncies de 'Show' per a arbres
    amb elements que ja tinguin definida la seva instància de Show.
-}

-- ************************************************************
-- 4. Mónada IO i Operacions sobre Strings i Números
-- ************************************************************

main :: IO ()
main = do
  putStrLn "Introdueix una línia de text:"
  line <- getLine  -- Llegeix una línia de l'entrada estàndard.
  let paraules = words line  -- Divideix la línia en paraules (llista de strings).
  putStrLn "Les paraules separades són:"
  print paraules

  -- Llegir un número (de string a num) i mostrar el seu doble (de num a string).
  putStrLn "Introdueix un nombre:"
  numStr <- getLine
  let numero = read numStr :: Int
  putStrLn ("El doble del nombre és: " ++ show (numero * 2))

  -- Exemple amb 'mapM_' per aplicar print a cada element d'una llista.
  putStrLn "Imprimim els nombres del 1 al 5:"
  mapM_ print [1 .. 5]

-- ************************************************************
-- 5. Operadors Functor i Applicative
-- ************************************************************

-- <$>: És la versió infixa de fmap, per aplicar una funció dins d'un context.
exempleFunctor :: [Int]
exempleFunctor = (+1) <$> [1, 2, 3]
-- Resultat: [2,3,4]

-- <*>: Aplica funcions contingudes en un context (per exemple, llistes o Maybe) a valors dins del mateix context.
exempleApplicative :: [Int]
exempleApplicative = [(+1), (*2)] <*> [1, 2, 3]
-- Resultat: [2,3,4,2,4,6]

-- ************************************************************
-- 6. Funcions Anònimes (Lambda)
-- ************************************************************

-- Funció lambda que rep tres paràmetres i retorna (x * y + z).
exempleLambda :: Int -> Int -> Int -> Int
exempleLambda = \x y z -> x * y + z
-- Exemple: exempleLambda 2 3 4 retorna 10

-- ************************************************************
-- 7. Llistes per Comprensió
-- ************************************************************

-- Llista dels quadrats dels nombres parells de l'1 al 20.
listaComprensio :: [Int]
listaComprensio = [ x * x | x <- [1 .. 20], even x ]

-- ************************************************************
-- 8. Llistes Infinites i Recursivitat
-- ************************************************************

-- Llista infinita: per exemple, la seqüència de nombres naturals.
llistaInfinita :: [Int]
llistaInfinita = [1, 2 ..]

-- Pren els 10 primers elements de la llista infinita.
exempleTake :: [Int]
exempleTake = take 10 llistaInfinita

-- Funció factorial definida de forma recursiva.
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Exemple d'ús de la clàusula 'where' per definir una variable auxiliar.
sumaAmbWhere :: Int -> Int -> Int
sumaAmbWhere a b = total
  where
    total = a + b

{- 
Aquest fitxer resumeix diversos conceptes bàsics de Haskell:
  • Definició de tipus i classes.
  • Ús de Maybe per resultats opcionals.
  • Instàncies de classes (Show i Eq) amb exemples per a tipus concrets i parametritzats.
  • Mónada IO i operacions amb strings i nombres.
  • Operadors per a functors i applicatives.
  • Funcions lambda.
  • Comprensions de llistes.
  • Llistes infinita i recursivitat.
-}
