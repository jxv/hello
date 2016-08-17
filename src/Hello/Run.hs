module Hello.Run
  ( run
  ) where

import Hello.Configuration (Configuration(target))
import Hello.Greeter (Greeter(greet))
import Hello.Timer (Timer(measureTime))
import Hello.Notifier (Notifier(timeTaken))

run :: (Timer m, Greeter m, Configuration m, Notifier m) => m ()
run = do
  t <- target
  diff <- measureTime $ greet t
  timeTaken diff
