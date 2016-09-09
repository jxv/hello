module Hello.Clock
  ( Clock(..)
  , getCurrentTime'
  ) where

import qualified Data.Time.Clock as IO (getCurrentTime)
import Data.Time.Clock (UTCTime)
import Control.Monad.IO.Class (MonadIO(liftIO))

class Monad m => Clock m where
  getCurrentTime :: m UTCTime

getCurrentTime' :: MonadIO m => m UTCTime
getCurrentTime' = liftIO IO.getCurrentTime
