{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Wiring where

import Control.Monad.Trans.Reader (ReaderT(..))
import Control.Monad.Reader.Class
import Control.Monad.IO.Class (MonadIO(..))
import Data.Text (Text)
import qualified Data.Time.Clock as IO

import qualified Hello.Console.Impl as Impl
import qualified Hello.Exit.Impl as Impl
import qualified Hello.Configuration.Impl as Impl
import qualified Hello.Greeter.Impl as Impl
import qualified Hello.FileSystem.Impl as Impl
import qualified Hello.Timer.Impl as Impl
import Hello.Application
import Hello.Clock.Class
import Hello.Console.Class
import Hello.Exit.Class
import Hello.Configuration.Class
import Hello.Greeter.Class
import Hello.FileSystem.Class
import Hello.Timer.Class

newtype AppM a = AppM { unAppM :: ReaderT [Text] IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader [Text])

run :: AppM a -> [Text] -> IO a
run proc args = runReaderT (unAppM proc) args

instance Clock AppM where
  getCurrentTime = liftIO IO.getCurrentTime

instance Console AppM where
  sysArgs = ask
  stdout = liftIO . Impl.stdout

instance Exit AppM where
  errorExit = liftIO . Impl.errorExit

instance Configuration AppM where
  target = Impl.target

instance FileSystem AppM where
  readFile = liftIO . Impl.readFile

instance Greeter AppM where
  greet = Impl.greet

instance Timer AppM where
  measureTime = Impl.measureTime
