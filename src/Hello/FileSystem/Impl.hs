module Hello.FileSystem.Impl
  ( readFile
  ) where

import qualified Data.Text as T
import qualified Data.Text.IO as T
import Prelude hiding (readFile)
import Data.Text (Text)
import System.IO.Error (catchIOError)

readFile :: Text -> IO (Maybe Text)
readFile filePath = catchIOError
  (Just <$> T.readFile (T.unpack filePath))
  (\_ -> return Nothing)
