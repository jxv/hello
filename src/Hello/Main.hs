module Hello.Main
  ( main
  ) where

import Hello.Configuration (Configuration(..))
import Hello.Greeter (Greeter(..))
import Hello.Timer (Timer(..))
import Hello.Notifier (Notifier(..))

main :: (Timer m, Greeter m, Configuration m, Notifier m) => m ()
main = do
  t <- target
  diff <- measureTime $ greet t
  timeTaken diff
