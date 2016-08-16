module Hello.Clock
  ( Clock(..)
  ) where

import Data.Time.Clock (UTCTime)

class Monad m => Clock m where
  getCurrentTime :: m UTCTime
