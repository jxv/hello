module Main (main) where

import Hello.Run (run)
import Hello.System (io)

main :: IO ()
main = io run
