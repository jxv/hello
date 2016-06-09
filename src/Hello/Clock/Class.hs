module Hello.Clock.Class
  ( Clock(..)
  ) where

import Data.Time.Clock (UTCTime)

class Clock m where
  getCurrentTime :: m UTCTime
