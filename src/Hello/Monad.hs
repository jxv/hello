module Hello.Monad
  ( Hello
  , runHello
  ) where

import Control.Monad.Error.Class (MonadError)
import Control.Monad.IO.Class (MonadIO)
import Control.Exception.Safe (MonadCatch, MonadThrow)
import Control.Monad.Except (ExceptT(..), runExceptT)
import Data.Text (Text, unpack)

import Hello.Console
import Hello.Clock
import Hello.Configuration
import Hello.Greeter
import Hello.FileSystem
import Hello.Notifier
import Hello.Timer

newtype Hello a = Hello { unHello :: ExceptT Text IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadError Text, MonadCatch, MonadThrow)

runHello :: Hello a -> IO a
runHello hello = do
  result <- runExceptT (unHello hello)
  either (error . unpack) return result

instance Clock Hello where
  getCurrentTime = getCurrentTime'

instance Console Hello where
  sysArg = sysArg'
  stdout = stdout'

instance Configuration Hello where
  target = target'

instance FileSystem Hello where
  readFile = readFile'

instance Greeter Hello where
  greet = greet'

instance Notifier Hello where
  timeTaken = timeTaken'

instance Timer Hello where
  measureTime = measureTime'
