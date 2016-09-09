module Hello.FileSystem
  ( FileSystem(..)
  , readFile'
  ) where

import qualified Data.Text.IO as T (readFile)
import Prelude hiding (readFile)
import Control.Monad.IO.Class (MonadIO(liftIO))
import Control.Monad.Error.Class (MonadError(throwError))
import Control.Exception.Safe (MonadCatch, catchIOError)
import Data.Text (Text)
import Data.Text.Conversions (fromText)

class Monad m => FileSystem m where
  readFile :: Text -> m Text

readFile' :: (MonadIO m, MonadError Text m, MonadCatch m) => Text -> m Text
readFile' filePath = let
  try = T.readFile $ fromText filePath
  recover _ = throwError $ "no file: " `mappend` filePath
  in catchIOError (liftIO try) recover
