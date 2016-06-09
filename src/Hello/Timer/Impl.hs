module Hello.Timer.Impl
  ( measureTime
  ) where

import qualified Data.Text as T
import Control.Monad.IO.Class (MonadIO(..))
import Data.Functor (void)
import Data.Time.Clock (diffUTCTime)
import Data.Text.Conversions (toText)

import Hello.Console.Class
import Hello.Clock.Class

measureTime :: (Clock m, Console m) => m () -> m ()
measureTime f = do
  before <- getCurrentTime
  void f
  after <- getCurrentTime
  let diff = diffUTCTime after before
  stdout $ toText (show diff)
