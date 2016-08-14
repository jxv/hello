module Hello.Notifier
  ( Notifier(..)
  ) where

import Data.Time.Clock (NominalDiffTime)

class Monad m => Notifier m where
  timeTaken :: NominalDiffTime -> m ()
