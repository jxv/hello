module Test.Hello.TimerSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Data.Time.Clock (UTCTime(..))
import Data.Time.Calendar (Day(..))
import Test.Hspec

import Hello.TimerImpl (measureTime)
import Hello.Clock (Clock(..))

mkFixture "Fixture" [''Clock]

spec :: Spec
spec = do
  describe "measureTime" $ do
    it "should call getCurrentTime twice and stdout the difference" $ do
      let fixture = def
            { _getCurrentTime = get
            }
      let passTime = do
            (UTCTime day secs) <- get
            put $ UTCTime day (secs + 234)
      let (diff, _, _) = runTestFixture (measureTime passTime) fixture (UTCTime (ModifiedJulianDay 0) 1000)
      diff `shouldBe` 234
