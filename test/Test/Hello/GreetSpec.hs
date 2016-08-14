module Test.Hello.GreetSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Test.Hspec

import Hello.GreeterImpl (greet)
import Hello.Console (Console(..))

mkFixture "Fixture" [''Console]

spec :: Spec
spec = do
  describe "greet" $ do
    it "should call stdout with hello message" $ do
      let fixture = def
            { _stdout = \msg -> do
                lift $ msg `shouldBe` "Hello, NAME!"
                log "stdout"
            }
      captured <- logTestFixtureT (greet "NAME") fixture
      captured `shouldBe` ["stdout"]
