module Hello.Console.Impl
  ( stdout
  ) where

import qualified Data.Text.IO as T
import Data.Text (Text)

stdout :: Text -> IO ()
stdout = T.putStrLn
