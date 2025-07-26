module Main

maxBits8 : Bits8
maxBits8 = 255

distanceToMax : Bits8 -> Bits8
distanceToMax n = maxBits8 - n

main : IO ()
main = putStrLn "Hello World!!!"
