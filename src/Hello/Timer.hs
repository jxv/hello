module Hello.Timer
  ( Timer(..)
  ) where

import Data.Time.Clock (NominalDiffTime)

class Monad m => Timer m where
  measureTime :: m () -> m ()
