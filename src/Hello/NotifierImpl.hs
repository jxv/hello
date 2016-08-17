module Hello.NotifierImpl
  ( timeTaken
  ) where

import Data.Text.Conversions (toText)
import Data.Time.Clock (NominalDiffTime)

import Hello.Console (Console(stdout))

timeTaken :: Console m => NominalDiffTime -> m ()
timeTaken = stdout . toText . show
