module Hello.Greeter.Impl
  ( greet
  ) where

import Data.Text (Text)

import Hello.Console.Class (Console(..))

greet :: Console m => Text -> m ()
greet name = stdout $ "Hello, " `mappend` name `mappend` "!"
