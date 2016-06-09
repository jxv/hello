module Hello.FileSystem.Class
  ( FileSystem(..)
  ) where

import Prelude hiding (readFile)
import Data.Text (Text)

class Monad m => FileSystem m where
  readFile :: Text -> m (Maybe Text)
