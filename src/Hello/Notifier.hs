module Hello.Notifier
  ( Notifier(..)
  , timeTaken'
  ) where

import Data.Text.Conversions (toText)
import Data.Time.Clock (NominalDiffTime)

import Hello.Console (Console(stdout))

class Monad m => Notifier m where
  timeTaken :: NominalDiffTime -> m ()

timeTaken' :: Console m => NominalDiffTime -> m ()
timeTaken' = stdout . toText . show
