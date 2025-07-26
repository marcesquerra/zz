module Main

import Control.App
import Control.App.Console

hello : Console es => App es ()
hello = putStrLn "Hello, App world!"

fo : Bool -> Int

bz  : Bool -> Int

main : IO ()
main = run hello
