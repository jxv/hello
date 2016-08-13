module Hello.FileSystemImpl
  ( readFile
  ) where

import qualified Data.Text as T
import qualified Data.Text.IO as T
import Prelude hiding (readFile)
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Error.Class (MonadError(..))
import Control.Exception.Safe (MonadCatch, catchIOError)
import Data.Text (Text)

readFile :: (MonadIO m, MonadError Text m, MonadCatch m) => Text -> m Text
readFile filePath = let
  try = T.readFile $ T.unpack filePath
  recover _ = throwError $ "no file: " `mappend` filePath
  in catchIOError (liftIO try) recover
