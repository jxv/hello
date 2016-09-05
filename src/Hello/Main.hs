module Hello.Main
  ( main
  ) where

import Hello.Classes (Configuration(target), Greeter(greet), Timer(measureTime), Notifier(timeTaken))

main :: (Timer m, Greeter m, Configuration m, Notifier m) => m ()
main = do
  t <- target
  diff <- measureTime $ greet t
  timeTaken diff
