module thesis

import StdEnv

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
:: Sem a = Sem (a, [String])

// add :: (Sem a) (Sem a) -> Sem a | + a
// add (Sem (a,pa)) (Sem (b,pb)) = Sem (a+b,pa ++ ["+"] ++ pb)
// andd :: (Sem Bool) (Sem Bool) -> Sem Bool
// andd (Sem (a,pa)) (Sem (b,pb)) = Sem (a&&b,pa ++ ["&&"] ++ pb)
// eq :: (Sem a) (Sem a) -> Sem Bool | == a
// eq (Sem (a,pa)) (Sem (b,pb)) = Sem (a==b,pa ++ ["=="] ++ pb)

// ------------- Listing 2.3 -------------

// :: Print a = P [String]
// :: Eval a = E a
// class myDSL v where
//     add :: (v t) (v t) -> v t | + t
//     andd :: (v Bool) (v Bool) -> v Bool
//     eq  :: (v t) (v t) -> v Bool | == t
    
// instance myDSL Print where
//     add (P x) (P y) = P (x ++ [" + "] ++ y)
//     andd (P x) (P y) = P (x ++ [" && "] ++ y)
//     eq  (P x) (P y) = P (x ++ [" == "] ++ y)
    
// instance myDSL Eval where
//     add (E x) (E y) = E (x + y)
//     andd (E x) (E y) = E (x && y)
//     eq  (E x) (E y) = E (x == y)

// ------------- Listing 2.4 -------------
:: Eval a = E a
:: In a b = In infixl 0 a b

class var v where
	var :: ((v t) -> In t (v a)) -> v a 

test = var \v = 4 In
	n ==. 0

Start = 1