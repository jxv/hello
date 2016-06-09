module Hello.Fixture
  ( Fixture(..)
  , def
  ) where

import Prelude hiding (readFile)
import Control.Monad.TestFixture
import Control.Monad.RWS (lift)
import Data.Text (Text)
import Data.Default
import Data.Time.Clock (UTCTime)

import Hello.Console.Class (Console(..))
import Hello.Exit.Class (Exit(..))
import Hello.Clock.Class (Clock(..))
import Hello.FileSystem.Class (FileSystem(..))

data Fixture m = Fixture
  { _sysArgs :: m [Text]
  , _stdout :: Text -> m ()
  , _errorExit :: Text -> m ()
  , _getCurrentTime :: m UTCTime
  , _readFile :: Text -> m (Maybe Text)
  }

instance Default (Fixture m) where
  def = Fixture
    { _sysArgs = unimplemented "sysArgs"
    , _stdout = unimplemented "stdout"
    , _errorExit = unimplemented "errorExit"
    , _getCurrentTime = unimplemented "getCurrentTime"
    , _readFile = unimplemented "readFile"
    }

instance Monoid w => Console (TestFixture Fixture w s) where
  sysArgs = arg0 _sysArgs
  stdout = arg1 _stdout

instance Monoid w => Exit (TestFixture Fixture w s) where
  errorExit msg = do
    rec <- asks _errorExit
    lift $ rec msg

instance Monoid w => Clock (TestFixture Fixture w s) where
  getCurrentTime = arg0 _getCurrentTime

instance Monoid w => FileSystem (TestFixture Fixture w s) where
  readFile = arg1 _readFile
