module Hello.App
  ( App
  , runApp
  ) where

import Control.Monad.Error.Class (MonadError)
import Control.Monad.IO.Class (MonadIO)
import Control.Exception.Safe (MonadCatch, MonadThrow)
import Control.Monad.Except (ExceptT(..), runExceptT)
import Data.Text (Text, unpack)

import qualified Hello.ConsoleImpl as Impl
import qualified Hello.ClockImpl as Impl
import qualified Hello.ConfigurationImpl as Impl
import qualified Hello.GreeterImpl as Impl
import qualified Hello.FileSystemImpl as Impl
import qualified Hello.TimerImpl as Impl
import Hello.Clock
import Hello.Console
import Hello.Configuration
import Hello.Greeter
import Hello.FileSystem
import Hello.Timer

newtype App a = App { unApp :: ExceptT Text IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadError Text, MonadCatch, MonadThrow)

runApp :: App a -> IO a
runApp f = do
  result <- runExceptT (unApp f)
  either (error . unpack) return result

instance Clock App where
  getCurrentTime = Impl.getCurrentTime

instance Console App where
  sysArg = Impl.sysArg
  stdout = Impl.stdout

instance Configuration App where
  target = Impl.target

instance FileSystem App where
  readFile = Impl.readFile

instance Greeter App where
  greet = Impl.greet

instance Timer App where
  measureTime = Impl.measureTime
