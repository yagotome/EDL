import Html exposing (text)

l: List Int
l = [1, 2, 3, 4]

f1: Int -> Bool
f1 x = ((x % 2) == 1)
m1 = List.filter f1 l

f2: Int -> Bool
f2 x = (x > 2)
m2 = List.filter f2 l

--main = text (toString l)
--main = text (toString m1)
main = text (toString m2)
