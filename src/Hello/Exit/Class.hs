module Hello.Exit.Class
  ( Exit(..)
  ) where

import Data.Text (Text)

class Monad m => Exit m where
  errorExit :: Text -> m ()
