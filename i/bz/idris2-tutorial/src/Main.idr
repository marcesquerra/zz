module Main

import Tutorial.Functions1

maxBits8 : Bits8
maxBits8 = 255

distanceToMax : Bits8 -> Bits8
distanceToMax n = maxBits8 - n

println : Show a => a -> IO ()
println = putStrLn . show

main : IO ()
main =
  do println "Exercises"
     println (isTriple 1 2 3)
     println (isTriple 3 4 5)
     println (squareTimes2 3)
     println ((\a => \b => a + b) 3 5)

