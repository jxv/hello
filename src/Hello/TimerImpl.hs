module Hello.TimerImpl
  ( measureTime
  ) where

import Data.Time.Clock (diffUTCTime)
import Data.Text.Conversions (toText)

import Hello.Console (Console(..))
import Hello.Clock (Clock(..))
import Hello.Notifier (Notifier(..))

measureTime :: (Clock m, Notifier m) => m () -> m ()
measureTime f = do
  before <- getCurrentTime
  f
  after <- getCurrentTime
  let duration = diffUTCTime after before
  timeTaken duration
