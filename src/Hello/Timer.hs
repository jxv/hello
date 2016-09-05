module Hello.Timer
  ( measureTime
  ) where

import Data.Time.Clock (diffUTCTime, NominalDiffTime)

import Hello.Classes (Clock(getCurrentTime))

measureTime :: Clock m => m () -> m NominalDiffTime
measureTime f = do
  before <- getCurrentTime
  f
  after <- getCurrentTime
  return $ diffUTCTime after before
