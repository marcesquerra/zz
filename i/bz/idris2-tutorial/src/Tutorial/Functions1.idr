module Tutorial.Functions1

export
isTriple : Integer -> Integer -> Integer -> Bool
isTriple i j k = i * i + j * j == k * k

export
square : Integer -> Integer
square n = n * n

export
times2 : Integer -> Integer
times2 n = 2 * n

export
squareTimes2 : Integer -> Integer
squareTimes2 = times2 . square


and : Bool -> Bool -> Bool
and x y = ?and_rhs
-- a and b = a && b
