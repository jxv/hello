module Test.Hello.TimerSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Data.Time.Clock (UTCTime(..))
import Data.Time.Calendar (Day(..))
import Test.Hspec

import Hello.Timer (measureTime)
import Hello.Classes (Clock(..))

mkFixture "Fixture" [''Clock]

spec :: Spec
spec = do
  describe "measureTime" $ do
    it "should call getCurrentTime twice and stdout the difference" $ do
      let fixture = def
            { _getCurrentTime = get
            } :: FixtureState UTCTime
      let passTime = do
            currentTime <- get
            put $ currentTime{ utctDayTime = utctDayTime currentTime + 234 }
      let startTime = UTCTime
            { utctDay = ModifiedJulianDay 0
            , utctDayTime = 1000
            }
      let (diff, _, _) = runTestFixture (measureTime passTime) fixture startTime
      diff `shouldBe` 234
