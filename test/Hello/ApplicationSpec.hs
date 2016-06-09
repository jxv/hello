module Hello.ApplicationSpec where

import Test.Hspec

import Control.Monad.RWS (lift)
import Control.Monad.TestFixture
import Data.Text (Text)

import Hello.Application
import Hello.Configuration.Class
import Hello.Greeter.Class
import Hello.Exit.Class
import Hello.Timer.Class

import  Data.Functor (void)

data Fixture m = Fixture
  { _target :: m (Either Text Text)
  , _greet :: Text -> m ()
  , _measureTime :: m () -> m ()
  , _errorExit :: Text -> m ()
  }

instance Monoid w => Configuration (TestFixture Fixture w s) where
  target = arg0 _target

instance Monoid w => Greeter (TestFixture Fixture w s) where
  greet = arg1 _greet

instance Monoid w => Exit (TestFixture Fixture w s) where
  errorExit = arg1 _errorExit

instance Monoid w => Timer (TestFixture Fixture w s) where
  measureTime m = do
    measureTimeRec <- asks _measureTime
    fixture <- ask
    s <- lift get
    lift . measureTimeRec $ do
      let (a, s, w) = runTestFixture m fixture s
      put s
      tell w
      return a

data Effect
  = Target Text
  | ErrorExit Text
  | MeasureTime
  | Greet Text
  deriving (Show, Eq)

base :: Fixture (WS [Effect] ())
base = Fixture
  { _target = return $ Left "error"
  , _greet = \who -> tell [Greet who]
  , _measureTime = \m -> do
      tell [MeasureTime]
      m
  , _errorExit = \msg -> tell [ErrorExit msg]
  }

spec :: Spec
spec = do
  describe "application" $ do
    it "should exit with no target" $ do
      let expected = logTestFixture application base ()
      let actual = [ErrorExit "error"]
      expected `shouldBe` actual
    it "should measure time of a greet given a target" $ do
      let fixture = base
            { _target = do
                let t = "HELLO"
                tell [Target t]
                return $ Right t
            }
      let expected = logTestFixture application fixture ()
      let actual = [Target "HELLO", MeasureTime, Greet "HELLO"]
      expected `shouldBe` actual
