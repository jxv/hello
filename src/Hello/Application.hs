module Hello.Application
  ( application
  ) where

import Hello.Configuration.Class
import Hello.Greeter.Class
import Hello.Timer.Class
import Hello.Exit.Class

application :: (Timer m, Greeter m, Configuration m, Exit m) => m ()
application = do
  eTarget <- target
  case eTarget of
    Left msg -> errorExit msg
    Right t -> measureTime (greet t)
