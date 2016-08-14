module Hello.TimerImpl
  ( measureTime
  ) where

import Data.Time.Clock (diffUTCTime)
import Data.Text.Conversions (toText)

import Hello.Console (Console(..))
import Hello.Clock (Clock(..))

measureTime :: (Clock m, Console m) => m () -> m ()
measureTime f = do
  before <- getCurrentTime
  f
  after <- getCurrentTime
  stdout . toText . show $ diffUTCTime after before
