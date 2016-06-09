module Hello.Console.Class
  ( Console(..)
  ) where

import Data.Text (Text)

class Monad m => Console m where
  sysArgs :: m [Text]
  stdout :: Text -> m ()
