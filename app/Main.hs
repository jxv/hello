module Main where

import System.Environment (getArgs)
import Data.Text.Conversions (toText)

import qualified Hello.Main as App
import Hello.App (runApp)

main :: IO ()
main = runApp App.main
