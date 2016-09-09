module Hello.Greeter
  ( Greeter(..)
  , greet'
  ) where

import Data.Text (Text)

import Hello.Console (Console(stdout))

class Monad m => Greeter m where
  greet :: Text -> m ()

greet' :: Console m => Text -> m ()
greet' name = stdout $ "Hello, " `mappend` name `mappend` "!"
