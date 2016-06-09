module Hello.TimerSpec (spec) where

import Test.Hspec
import Control.Monad.TestFixture
import Data.Text (Text)
import Data.Time.Clock
import Data.Time.Calendar

import Hello.Fixture
import Hello.Timer.Impl

mkUTCTime :: Integer -> DiffTime -> UTCTime
mkUTCTime day diffTime = UTCTime (ModifiedJulianDay day) diffTime

data Effect
  = GetCurrentTime UTCTime
  | Stdout Text
  | CalledFunction
  deriving (Show, Eq)

fixture :: Fixture (WS [Effect] Int)
fixture = def
  { _getCurrentTime = do
      calls <- get
      put (calls + 1)
      let diffTime = sum (replicate calls 1000)
      let utcTime = mkUTCTime 0 diffTime
      tell [GetCurrentTime utcTime]
      return utcTime
  , _stdout = \msg -> tell [Stdout msg]
  }

spec :: Spec
spec = do
  describe "measureTime" $ do
    it "should ensure the logic has the expected flow with a function call" $ do
      let call = tell [CalledFunction]
      let actual = logTestFixture (measureTime call) fixture 0
      let expected = [GetCurrentTime (mkUTCTime 0 0), CalledFunction, GetCurrentTime (mkUTCTime 0 1000), Stdout "1000s"]
      actual `shouldBe` expected
