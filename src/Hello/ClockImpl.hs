module Hello.ClockImpl
  ( getCurrentTime
  ) where

import qualified Data.Time.Clock as IO (getCurrentTime)
import Data.Time.Clock (UTCTime)
import Control.Monad.IO.Class (MonadIO(..))

getCurrentTime :: MonadIO m => m UTCTime
getCurrentTime = liftIO IO.getCurrentTime
