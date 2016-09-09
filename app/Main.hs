module Main where

import qualified Hello.Main as Hello (main)
import Hello.Monad (runHello)

main :: IO ()
main = runHello Hello.main
