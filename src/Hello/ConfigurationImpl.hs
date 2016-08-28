module Hello.ConfigurationImpl
  ( target
  , initText
  ) where

import qualified Data.Text as T (null, init)
import Prelude hiding (readFile)
import Data.Text (Text)

import Hello.Parts (Console(sysArg), FileSystem(readFile))

target :: (Console m, FileSystem m) => m Text
target = do
  filePath <- sysArg
  contents <- readFile filePath
  return $ initText contents

initText :: Text -> Text
initText txt
  | T.null txt = ""
  | otherwise = T.init txt
