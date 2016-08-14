module Main where

import qualified Hello.Main as Hello (main)
import Hello.App (runApp)

main :: IO ()
main = runApp Hello.main
