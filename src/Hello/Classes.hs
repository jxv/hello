module Hello.Classes
  ( Clock(..)
  , Configuration(..)
  , Console(..)
  , FileSystem(..)
  , Greeter(..)
  , Notifier(..)
  , Timer(..)
  ) where

import Prelude hiding (readFile)

import Data.Time.Clock (UTCTime, NominalDiffTime)
import Data.Text (Text)

class Monad m => Clock m where
  getCurrentTime :: m UTCTime

class Monad m => Configuration m where
  target :: m Text

class Monad m => Console m where
  sysArg :: m Text
  stdout :: Text -> m ()

class Monad m => FileSystem m where
  readFile :: Text -> m Text

class Monad m => Greeter m where
  greet :: Text -> m ()

class Monad m => Notifier m where
  timeTaken :: NominalDiffTime -> m ()

class Monad m => Timer m where
  measureTime :: m () -> m NominalDiffTime
