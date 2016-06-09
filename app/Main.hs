module Main where

import System.Environment (getArgs)
import Data.Text.Conversions (toText)

import Hello.Application
import Wiring

main :: IO ()
main = do
  args <- map toText <$> getArgs
  run application args
