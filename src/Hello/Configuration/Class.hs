module Hello.Configuration.Class
  ( Configuration(..)
  ) where

import Data.Text (Text)

class Monad m => Configuration m where
  target :: m (Either Text Text)
