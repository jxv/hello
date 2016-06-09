module Hello.Configuration.Impl
  ( target
  ) where

import qualified Data.Text as T
import Prelude hiding (readFile)
import Data.Text (Text)

import Hello.Console.Class (Console(..))
import Hello.FileSystem.Class (FileSystem(..))

target :: (Console m, FileSystem m) => m (Either Text Text)
target = do
  args <- sysArgs
  case args of
    (filePath:_) -> do
      mContents <- readFile filePath
      case mContents of
        Just contents -> return . Right $ initText contents
        Nothing -> return . Left $ "Can't open file: " `mappend` filePath
    _ -> return . Left $ "No file path provided."

initText :: Text -> Text
initText txt
  | T.null txt = ""
  | otherwise = T.init txt
