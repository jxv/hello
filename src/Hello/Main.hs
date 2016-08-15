module Hello.Main
  ( main
  ) where

import Hello.Configuration (Configuration(..))
import Hello.Greeter (Greeter(..))
import Hello.Timer (Timer(..))

main :: (Timer m, Greeter m, Configuration m) => m ()
main = do
  t <- target
  measureTime $ greet t
