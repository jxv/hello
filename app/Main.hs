module Main (main) where

import qualified Hello.Main as Hello (main)
import qualified Hello.Monad as Hello (runIO)

main :: IO ()
main = Hello.runIO Hello.main
