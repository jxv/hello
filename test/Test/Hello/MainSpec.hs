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

mkFixture "Fixture" [''Configuration, ''Greeter,  ''Timer]

spec :: Spec
spec = do
  describe "main" $ do
    it "should call greet with stubbed target's name" $ do
      let fixture = def
            { _target = do
                log "target"
                return "NAME"
            , _greet = \name -> do
                log "greet"
                lift $ name `shouldBe` "NAME"
            , _measureTime = \f -> do
                log "measureTime"
                f
            }
      captured <- logTestFixtureT main fixture
      captured `shouldBe` ["target", "measureTime", "greet"]
