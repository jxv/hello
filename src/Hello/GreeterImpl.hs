module Hello.GreeterImpl
  ( greet
  ) where

import Data.Text (Text)

import Hello.Console (Console(stdout))

greet :: Console m => Text -> m ()
greet name = stdout $ "Hello, " `mappend` name `mappend` "!"
