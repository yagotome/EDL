import Html exposing (text)

type alias Env = (String -> Int)

type Exp =    Num Int
            | Var String
            -- Boolean operations
            | Gt Exp Exp
            | Lt Exp Exp
            | Eq Exp Exp
            | And Exp Exp
            | Or Exp Exp
            | Xor Exp Exp
            | Not Exp
            -- Mathematics operations
            | Add Exp Exp
            | Sub Exp Exp
            | Times Exp Exp
            | Div Exp Exp
            | Mod Exp Exp
            | Exponential Exp Exp
            | NthRootf Exp Exp
            | NthRootc Exp Exp
            | NthRootr Exp Exp
            | Logf Exp Exp
            | Logc Exp Exp
            | Logr Exp Exp

type Prog = Attr String Exp
          | Seq Prog Prog
          | If Exp Prog Prog

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        Num v               -> v
        Var var             -> (env var)
        -- Boolean operations
        Gt exp1 exp2        ->
                if (evalExp exp1 env) > (evalExp exp2 env) then
                    1
                else
                    0
        Lt exp1 exp2        ->
                if (evalExp exp1 env) < (evalExp exp2 env) then
                    1
                else
                    0
        Eq exp1 exp2        ->
                if (evalExp exp1 env) == (evalExp exp2 env) then
                    1
                else
                    0
        And exp1 exp2       ->
                if ((evalExp exp1 env) /= 0) && ((evalExp exp2 env) /= 0) then
                    1
                else
                    0
        Or exp1 exp2        ->
                if ((evalExp exp1 env) /= 0) || ((evalExp exp2 env) /= 0) then
                    1
                else
                    0
        Xor exp1 exp2       ->
                if (xor ((evalExp exp1 env) /= 0) ((evalExp exp2 env) /= 0)) then
                    1
                else
                    0
        Not exp             ->
                if (evalExp exp env) == 0 then
                    1
                else
                    0
        -- Mathematics operations
        Add exp1 exp2       -> (evalExp exp1 env) + (evalExp exp2 env)
        Sub exp1 exp2       -> (evalExp exp1 env) - (evalExp exp2 env)        
        Times exp1 exp2     -> (evalExp exp1 env) * (evalExp exp2 env)
        Div exp1 exp2       -> (evalExp exp1 env) // (evalExp exp2 env)
        Mod exp1 exp2       -> (evalExp exp1 env) % (evalExp exp2 env)
        Exponential e1 e2   -> (evalExp e1 env) ^ (evalExp e2 env)
        NthRootf exp1 exp2  -> floor ((toFloat (evalExp exp1 env)) ^ (1 / (toFloat (evalExp exp2 env))))
        NthRootc exp1 exp2  -> ceiling ((toFloat (evalExp exp1 env)) ^ (1 / (toFloat (evalExp exp2 env))))
        NthRootr exp1 exp2  -> round ((toFloat (evalExp exp1 env)) ^ (1 / (toFloat (evalExp exp2 env))))
        Logf exp1 exp2      -> floor (logBase (toFloat (evalExp exp1 env)) (toFloat (evalExp exp2 env)))
        Logc exp1 exp2      -> ceiling (logBase (toFloat (evalExp exp1 env)) (toFloat (evalExp exp2 env)))
        Logr exp1 exp2      -> round (logBase (toFloat (evalExp exp1 env)) (toFloat (evalExp exp2 env)))

evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Seq s1 s2 ->
            (evalProg s2 (evalProg s1 env))
        Attr var exp ->
            let
                val = (evalExp exp env)
            in
                \ask -> if ask==var then val else (env ask)        
        If cond p1 p2   ->
                if (evalExp cond env) /= 0 then
                    (evalProg p1 env)
                else
                    (evalProg p2 env)

zero : Env
zero = \ask -> 0

lang : Prog -> Int
lang p = ((evalProg p zero) "ret")

p1 : Prog
p1 = (Attr "ret" (Add (Num 11) (Num 9)))

p2 : Prog
p2 = Seq
        (Attr "x" (Sub (Times (Num 2) (Div (Num 20) (Num 6))) (Num 11)))
        (Attr "ret" (Mod (Add (Var "x") (Num 9)) (Num 3)))

p3 = (Attr "ret" (NthRootf (Num 15) (Num 2)))
p4 = (Attr "ret" (NthRootc (Num 15) (Num 2)))
p5 = (Attr "ret" (Exponential (Num 2) (Num 5)))

p6 = (Attr "ret" (Logf (Num 2) (Num 7)))
p7 = (Attr "ret" (Logc (Num 2) (Num 7)))

p8 = (If (Gt (Num 2) (Num 1)) (Attr "ret" (Num 1)) ((Attr "ret" (Num 0))))
p9 = 
        (If 
            (Not 
                (And 
                    (Or 
                        (Num 0)
                        (Num 1)
                    )
                    (Num 1)
                )
            )
            (Attr "ret" (Num 1))
            (Attr "ret" (Num 0))
        )

main = text (toString (lang p9))