module Test.Hello.MainSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Test.Hspec

import Hello.Main (main)
import Hello.Configuration (Configuration(..))
import Hello.Greeter (Greeter(..))
import Hello.Timer (Timer(..))
import Hello.Notifier (Notifier(..))

mkFixture "Fixture" [''Configuration, ''Greeter,  ''Timer, ''Notifier]

spec :: Spec
spec = do
  describe "main" $ do
    it "should call greet with stubbed target's name" $ do
      let stubTarget = "NAME"
      let stubDiff = 100
      let fixture = def
            { _target = do
                return stubTarget
            , _greet = \name -> do
                log "greet"
                lift $ name `shouldBe` stubTarget
            , _measureTime = \f -> do
                f
                return stubDiff
            , _timeTaken = \diff -> do
                log "timeTaken"
                lift $ diff `shouldBe` stubDiff
            }
      captured <- logTestFixtureT main fixture
      captured `shouldBe` ["greet", "timeTaken"]
