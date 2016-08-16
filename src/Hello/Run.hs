module Hello.Run
  ( run
  ) where

import Hello.Configuration (Configuration(..))
import Hello.Greeter (Greeter(..))
import Hello.Timer (Timer(..))
import Hello.Notifier (Notifier(..))

run :: (Timer m, Greeter m, Configuration m, Notifier m) => m ()
run = do
  t <- target
  diff <- measureTime $ greet t
  timeTaken diff
