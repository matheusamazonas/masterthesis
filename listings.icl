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
// :: Eval a b = E a
// :: In a b = In infixl 0 a b
// :: Var = Var
// :: Expr = Expr

// class expr v where
//     lit :: t -> v t Expr
//     (+.) infixl 6 :: (v t p) (v t q) -> v t Expr | + t

// class var v where
// 	var :: ((v t Var) -> In t (v a p)) -> v a p
// 	(=.) infixr 3 :: (v t Var) (v t p) -> v t Expr

// instance expr Eval where
// 	lit x = E x
// 	(+.) (E a) (E b) = E (a + b)

// instance var Eval where
// 	var _ = undef
// 	(=.) _ _ = undef

// test1 :: Eval Int Expr
// test1 = var \k = 4 In
// 	k  =. k +. lit 7

// test2 :: Eval Int Expr
// test2 = var \k = 4 In
// 	k  =. lit True 

// ------------- Listing 3.1 -------------
// class toPrompt d where
//     toPrompt :: !d -> UI

// enterInformation :: !d ![EnterOption m] -> Task m | toPrompt d & iTask m
// viewInformation :: !d ![ViewOption m] !m -> Task m | toPrompt d & iTask m
// updateInformation :: !d ![UpdateOption m m] m -> Task m | toPrompt d & iTask m 

// ------------- Listing 3.2 -------------

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

// ------------- Listing 3.3 -------------

// (>>*) infixl 1 :: (Task a) [TaskCont a (Task b)] -> Task b | iTask a & iTask b

// :: TaskCont a b                               
// 	= OnValue ((TaskValue a) -> Maybe b)         
// 	| OnAction Action ((TaskValue a) -> Maybe b) 
// 	| E.e: OnException (e -> b) & iTask e        
// 	| OnAllExceptions (String -> b)

// (>>=) infixl 1 :: (m a) (a -> m b) -> m b   | iTask a & iTask b
// (>>|) infixl 1 :: (m a) (m b)     -> m b   | iTask a & iTask b

// ------------- Listing 3.4 -------------

// (-||-) infixr 3 :: (Task a) (Task a) -> Task a     | iTask a
// (-&&-) infixr 4 :: (Task a) (Task b) -> Task (a,b) | iTask a & iTask b

// ------------- Listing 3.5 -------------

// :: SDS p r w = ...
// :: ReadWriteShared r w :== SDS () r w
// :: Shared a :== SDS () a a

// get   :: (ReadWriteShared a w)           -> Task a | iTask a
// set   :: a (ReadWriteShared r a)         -> Task a | iTask a & TC r
// upd   :: (r -> w) (ReadWriteShared r w)   -> Task w | iTask r & iTask w
// watch :: (ReadWriteShared r w)           -> Task r | iTask r

// ------------- Listing 4.1 -------------
// class arith v where
//     lit :: t -> v t Expr                             | mTaskType t                       
//     (+.) infixl 6 :: (v t p) (v t q) -> v t Expr     | type, +, t & isExpr p & isExpr q

// ------------- Listing 4.2 -------------
// :: Upd   = Upd
// :: Expr  = Expr
// :: Stmt  = Stmt

// class isExpr a :: a
// instance isExpr Upd
// instance isExpr Expr

// ------------- Listing 4.3 -------------
// class arith v where
// 	lit :: t -> v t Expr 
// 	(+.) infixl 6 :: (v t p) (v t q) -> v t Expr | + t
// 	...

// class boolExpr v where
// 	(&.) infixr 3 :: (v Bool p) (v Bool q) -> v Bool Expr 
// 	Not           :: (v Bool p)            -> v Bool Expr 
// 	(==.) infix 4 :: (v a p) (v a q)       -> v Bool Expr | == a
// 	(<.)  infix 4 :: (v a p) (v a q)       -> v Bool Expr | < a
// 	...

// ------------- Listing 4.4 -------------class If v q r ~s where
//   If :: (v Bool p) (v t q) (v t r) -> v t s      | isExpr p 
// class IF v where
//   IF :: (v Bool p) (v t q) (v s r) -> v () Stmt  | isExpr p
//   (?) infix 1 :: (v Bool p) (v t q) -> v () Stmt | isExpr p
// class seq v where
//   (>>=.) infixr 0 :: (v t p) ((v t Expr) -> (v u q)) -> (v u Stmt) 
//   (:.) infixr 0 :: (v t p) (v u q) -> v u Stmt 
// class retrn v where
//   retrn :: v () Expr

// ------------- Listing 4.5 -------------
// :: In a b = In infix 0 a b
// :: Main a = {main :: a}

// class sds v where
//   sds :: ((v t Upd)  -> In t (Main (v c s))) -> (Main (v c s))
//   con :: ((v t Expr) -> In t (Main (v c s))) -> (Main (v c s)) 
// class sdspub v where
//   pub :: (v t Upd) -> v t Expr
// class assign v where
//   (=.) infixr 2 :: (v t Upd) (v t p) -> v t Expr | isExpr p

// ------------- Listing 4.6 -------------
// :: DigitalPin = D0 | D1 | D2 | D3 | D4 | D5 |D6 | D7 | D8 | D9 | D10 | D11 | D12 | D13
// :: AnalogPin  = A0 | A1 | A2 | A3 | A4 | A5
// :: Pin = Digital DigitalPin | Analog AnalogPin
// :: UserLED   = LED1 | LED2 | LED3

// class pin p |  == p where
// 	pin :: p -> Pin
// instance pin DigitalPin
// instance pin AnalogPin

// class digitalIO v where
//   digitalRead  :: p -> v Bool Expr            | pin p
//   digitalWrite :: p (v Bool q) -> v Bool Expr | pin  p
// class analogIO v where
//   analogRead  :: AnalogPin -> v Int Expr 
//   analogWrite :: AnalogPin (v Int p) -> v Int Expr
// class userLed v where
//   ledOn  :: (v UserLED q) -> (v () Stmt)
//   ledOff :: (v UserLED q) -> (v () Stmt)

// ------------- Listing 4.7 -------------
// :: BCValue = E.e: BCValue e & mTaskType e

// :: MTaskMSGSend = 
//       MTTask MTaskInterval String
//     | MTTaskDel Int
//     | MTShutdown
//     | MTSds Int BCValue
//     | MTUpd Int BCValue
//     | MTSpec

// ------------- Listing 4.8 -------------
// :: MTaskMSGRecv = 
//       MTTaskAck Int Int
//     | MTTaskDelAck Int
//     | MTSDSAck Int
//     | MTSDSDelAck Int
//     | MTPub Int BCValue
//     | MTMessage String
//     | MTDevSpec MTaskDeviceSpec
//     | MTEmpty

// ------------- Listing 4.9 -------------
// switch :: Main (v () Stmt) 
// switch = { main = 
// 	IF (digitalRead D0) (
// 		ledOn (lit LED1)
// 	) (
// 		ledOff (lit LED1)
// 	)}
	
// curtains :: Main (v () Stmt)
// curtains = sds \alarm=False In { main = 
// 	IF (analogRead A0 >. lit 3) (
// 		digitalWrite D0 (lit True) :.
// 		alarm =. lit True :.
// 		pub alarm :.
// 		retrn
// 	) (
// 		digitalWrite D0 (lit False)
// 	)}

Start w = 1//startEngine viewLocation w