module Hello.Monad
  ( Hello
  , runIO
  ) where

import Control.Monad.Error.Class (MonadError)
import Control.Monad.IO.Class (MonadIO)
import Control.Exception.Safe (MonadCatch, MonadThrow)
import Control.Monad.Except (ExceptT(..), runExceptT)
import Data.Text (Text, unpack)

import qualified Hello.Console as Console
import qualified Hello.Clock as Clock
import qualified Hello.Configuration as Configuration
import qualified Hello.Greeter as Greeter
import qualified Hello.FileSystem as FileSystem
import qualified Hello.Notifier as Notifier
import qualified Hello.Timer as Timer
import Hello.Classes

newtype Hello a = Hello { unHello :: ExceptT Text IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadError Text, MonadCatch, MonadThrow)

runIO :: Hello a -> IO a
runIO hello = do
  result <- runExceptT (unHello hello)
  either (error . unpack) return result

instance Clock Hello where
  getCurrentTime = Clock.getCurrentTime

instance Console Hello where
  sysArg = Console.sysArg
  stdout = Console.stdout

instance Configuration Hello where
  target = Configuration.target

instance FileSystem Hello where
  readFile = FileSystem.readFile

instance Greeter Hello where
  greet = Greeter.greet

instance Notifier Hello where
  timeTaken = Notifier.timeTaken

instance Timer Hello where
  measureTime = Timer.measureTime
