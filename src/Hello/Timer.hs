module Hello.Timer
  ( Timer(..)
  , measureTime'
  ) where

import Data.Time.Clock (diffUTCTime, NominalDiffTime)

import Hello.Clock (Clock(getCurrentTime))

class Monad m => Timer m where
  measureTime :: m () -> m NominalDiffTime

measureTime' :: Clock m => m () -> m NominalDiffTime
measureTime' f = do
  before <- getCurrentTime
  f
  after <- getCurrentTime
  return $ diffUTCTime after before
