module Hello.FileSystem
  ( FileSystem(..)
  ) where

import Prelude hiding (readFile)
import Data.Text (Text)

class Monad m => FileSystem m where
  readFile :: Text -> m Text
