module Hello.Notifier
  ( timeTaken
  ) where

import Data.Text.Conversions (toText)
import Data.Time.Clock (NominalDiffTime)

import Hello.Classes (Console(stdout))

timeTaken :: Console m => NominalDiffTime -> m ()
timeTaken = stdout . toText . show
