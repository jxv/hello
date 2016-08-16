module Hello.System
  ( System
  , io
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
import qualified Hello.NotifierImpl as Impl
import qualified Hello.TimerImpl as Impl
import Hello.Clock (Clock(..))
import Hello.Console (Console(..))
import Hello.Configuration (Configuration(..))
import Hello.Greeter (Greeter(..))
import Hello.FileSystem (FileSystem(..))
import Hello.Notifier (Notifier(..))
import Hello.Timer (Timer(..))

newtype System a = System { unSystem :: ExceptT Text IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadError Text, MonadCatch, MonadThrow)

io :: System a -> IO a
io f = do
  result <- runExceptT (unSystem f)
  either (error . unpack) return result

instance Clock System where
  getCurrentTime = Impl.getCurrentTime

instance Console System where
  sysArg = Impl.sysArg
  stdout = Impl.stdout

instance Configuration System where
  target = Impl.target

instance FileSystem System where
  readFile = Impl.readFile

instance Greeter System where
  greet = Impl.greet

instance Notifier System where
  timeTaken = Impl.timeTaken

instance Timer System where
  measureTime = Impl.measureTime
