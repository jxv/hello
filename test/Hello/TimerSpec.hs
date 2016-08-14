module Hello.TimerSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Data.Time.Clock (UTCTime(..))
import Data.Time.Calendar (Day(..))
import Test.Hspec

import Hello.TimerImpl (measureTime)
import Hello.Console (Console(..))
import Hello.Clock (Clock(..))

mkFixture "Fixture" [''Console, ''Clock]

spec :: Spec
spec = do
  describe "measureTime" $ do
    it "should call getCurrentTime twice and stdout the difference" $ do
      let fixture = def
            { _getCurrentTime = do
                log "getCurrentTime"
                return $ UTCTime (ModifiedJulianDay 0) 0
            , _stdout = \msg -> do
                log "stdout"
                lift $ msg `shouldBe` "0s"
            }
      let function = log "function"
      captured <- logTestFixtureT (measureTime function) fixture
      captured `shouldBe` ["getCurrentTime", "function", "getCurrentTime", "stdout"]
