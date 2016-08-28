module Hello.Main
  ( main
  ) where

import Hello.Configuration (Configuration(target))
import Hello.Greeter (Greeter(greet))
import Hello.Timer (Timer(measureTime))
import Hello.Notifier (Notifier(timeTaken))

main :: (Timer m, Greeter m, Configuration m, Notifier m) => m ()
main = do
  t <- target
  diff <- measureTime $ greet t
  timeTaken diff
