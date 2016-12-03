import Html exposing (text)

type alias Env = (String -> Int)
zero : Env
zero = \ask -> 0

type Exp =  Add Exp Exp
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
            | Num Int
            | Var String

type Prog = Attr String Exp
          | Seq Prog Prog

e1 : Exp
e1 = Add (Num 9) (Num 1)

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
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
        Num v               -> v
        Var var             -> (env var)

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

main = text (toString (lang p7))