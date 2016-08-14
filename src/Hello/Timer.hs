module Hello.Timer
  ( Timer(..)
  ) where

class Monad m => Timer m where
  measureTime :: m () -> m ()
