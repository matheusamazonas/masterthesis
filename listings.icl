module listings

// import StdEnv
import StdOverloaded
import StdClass
import StdInt
import StdString
import StdBool
import StdMisc
import StdList => qualified and
import iTasks

// ------------- Listing 2.1 -------------
// :: MyDSL = I Int
//     | B Bool
//     | Add MyDSL MyDSL
//     | Sub MyDSL MyDSL
//     | And MyDSL MyDSL
//     | Or MyDSL MyDSL
//     | Var String
    
// prettyPrint :: MyDSL -> [String]
// prettyPrint _ = undef
// eval :: MyDSL -> Int
// eval _ = undef


// ------------- Listing 2.2 -------------
// :: Sem a = Sem (a, [String])

// add :: (Sem a) (Sem a) -> Sem a | + a
// add _ _ = undef
// and :: (Sem Bool) (Sem Bool) -> Sem Bool
// and _ _ = undef
// eq :: (Sem a)  (Sem a) -> Sem Bool | == a
// eq _ _ = undef
// var :: String -> Sem Int
// var _ = undef

// ------------- Listing 2.3 -------------

// :: Print a = P [String]
// :: Eval a = E a
// class myDSL v where
//     lit :: t -> v t | toString t
//     add :: (v t) (v t) -> v t | + t
//     and :: (v Bool) (v Bool) -> v Bool
//     eq  :: (v t) (v t) -> v Bool | == t
    
// instance myDSL Print where
//     lit x = P [toString x]
//     add (P x) (P y) = P (x ++ [" + ":y])
//     and (P x) (P y) = P (x ++ [" && ":y])
//     eq  (P x) (P y) = P (x ++ [" == ":y])
    
// instance myDSL Eval where
//     lit x = E x
//     add (E x) (E y) = E (x + y)
//     and (E x) (E y) = E (x && y)
//     eq  (E x) (E y) = E (x == y)

// ------------- Listing 2.4 -------------
:: Eval a b = E a
:: In a b = In infixl 0 a b
:: Var = Var
:: Expr = Expr

class expr v where
    lit :: t -> v t Expr
    (+.) infixl 6 :: (v t p) (v t q) -> v t Expr | + t

class var v where
	var :: ((v t Var) -> In t (v a p)) -> v a p
	(=.) infixr 3 :: (v t Var) (v t p) -> v t Expr

instance expr Eval where
	lit x = E x
	(+.) (E a) (E b) = E (a + b)

instance var Eval where
	var _ = undef
	(=.) _ _ = undef

test1 :: Eval Int Expr
test1 = var \k = 4 In
	k  =. k +. lit 7

test2 :: Eval Int Expr
test2 = var \k = 4 In
	k  =. lit True 

// ------------- Listing 3.1 -------------
// class toPrompt d where
//     toPrompt :: !d -> UI

// enterInformation :: !d ![EnterOption m] -> Task m | toPrompt d & iTask m
// viewInformation :: !d ![ViewOption m] !m -> Task m | toPrompt d & iTask m
// updateInformation :: !d ![UpdateOption m m] m -> Task m | toPrompt d & iTask m 

// ------------- Listing 3.1 -------------

// :: Location = { city :: String, state :: String }

// location :: Location
// location = { city="Omaha", state="Nebraska"}

// derive class iTask Location

// enterLocation :: Task Location
// enterLocation = enterInformation "Enter the location" []

// viewLocation :: Task Location
// viewLocation = viewInformation "View the location" [] location

// updateLocation :: Task Location
// updateLocation = updateInformation "Update the location" [] location

Start w = 1//startEngine viewLocation w