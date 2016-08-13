module Hello.ConsoleImpl
  ( sysArg
  , stdout
  ) where

import qualified Data.Text.IO as T (putStrLn)
import Data.Text (Text)
import Data.Text.Conversions (toText)
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Error.Class (MonadError(..))
import System.Environment (getArgs)

sysArg :: (MonadIO m, MonadError Text m) => m Text
sysArg = do
  args <- liftIO $ getArgs
  case args of
    (arg:_) -> return $ toText arg
    _ -> throwError "no argument"

stdout :: MonadIO m => Text -> m ()
stdout = liftIO . T.putStrLn
