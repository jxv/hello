module Hello.System
  ( System
  , io
  ) where

import Control.Monad.Error.Class (MonadError)
import Control.Monad.IO.Class (MonadIO)
import Control.Exception.Safe (MonadCatch, MonadThrow)
import Control.Monad.Except (ExceptT(..), runExceptT)
import Data.Text (Text, unpack)

import qualified Hello.ConsoleImpl as Console
import qualified Hello.ClockImpl as Clock
import qualified Hello.ConfigurationImpl as Configuration
import qualified Hello.GreeterImpl as Greeter
import qualified Hello.FileSystemImpl as FileSystem
import qualified Hello.NotifierImpl as Notifier
import qualified Hello.TimerImpl as Timer
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
io system = do
  result <- runExceptT (unSystem system)
  either (error . unpack) return result

instance Clock System where
  getCurrentTime = Clock.getCurrentTime

instance Console System where
  sysArg = Console.sysArg
  stdout = Console.stdout

instance Configuration System where
  target = Configuration.target

instance FileSystem System where
  readFile = FileSystem.readFile

instance Greeter System where
  greet = Greeter.greet

instance Notifier System where
  timeTaken = Notifier.timeTaken

instance Timer System where
  measureTime = Timer.measureTime
