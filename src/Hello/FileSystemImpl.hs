module Hello.FileSystemImpl
  ( readFile
  ) where

import qualified Data.Text.IO as T (readFile)
import Prelude hiding (readFile)
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Error.Class (MonadError(..))
import Control.Exception.Safe (MonadCatch, catchIOError)
import Data.Text (Text)
import Data.Text.Conversions (fromText)

readFile :: (MonadIO m, MonadError Text m, MonadCatch m) => Text -> m Text
readFile filePath = let
  try = T.readFile $ fromText filePath
  recover _ = throwError $ "no file: " `mappend` filePath
  in catchIOError (liftIO try) recover
