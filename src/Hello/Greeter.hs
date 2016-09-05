module Hello.Greeter
  ( greet
  ) where

import Data.Text (Text)

import Hello.Classes (Console(stdout))

greet :: Console m => Text -> m ()
greet name = stdout $ "Hello, " `mappend` name `mappend` "!"
