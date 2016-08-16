module Hello.TimerImpl
  ( measureTime
  ) where

import Data.Time.Clock (diffUTCTime, NominalDiffTime)

import Hello.Clock (Clock(..))

measureTime :: Clock m => m () -> m NominalDiffTime
measureTime f = do
  before <- getCurrentTime
  f
  after <- getCurrentTime
  return $ diffUTCTime after before
