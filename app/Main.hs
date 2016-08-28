module Main (main) where

import qualified Hello.Main as Hello (main)
import Hello.System (runIO)

main :: IO ()
main = runIO Hello.main
