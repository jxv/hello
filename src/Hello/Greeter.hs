module Hello.Greeter
  ( Greeter(..)
  ) where

import Data.Text (Text)

class Monad m => Greeter m where
  greet :: Text -> m ()
