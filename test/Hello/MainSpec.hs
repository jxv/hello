module Hello.MainSpec (spec) where

import Test.Hspec

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

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
            { _target = return "NAME"
            , _greet = \name -> do
                lift $ name `shouldBe` "NAME"
                log "greet"
            , _measureTime = \f -> f
            }
      captured <- logTestFixtureT main fixture
      captured `shouldBe` ["greet"]
