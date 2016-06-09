module Hello.Exit.Impl
  ( errorExit
  ) where

import qualified Data.Text.IO as T
import qualified System.IO as Sys
import Data.Text (Text)
import System.Exit (exitFailure)

errorExit :: Text -> IO ()
errorExit message = do
  T.hPutStrLn Sys.stderr message
  exitFailure
