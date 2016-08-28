module Test.Hello.GreeterSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Test.Hspec

import Hello.GreeterImpl (greet)
import Hello.Parts (Console(..))

mkFixture "Fixture" [''Console]

spec :: Spec
spec = do
  describe "greet" $ do
    it "should call stdout with hello message" $ do
      let stubName = "NAME"
      let fixture = def
            { _stdout = \msg -> do
                lift $ msg `shouldBe` ("Hello, " `mappend` stubName `mappend` "!")
                log "stdout"
            }
      captured <- logTestFixtureT (greet stubName) fixture
      captured `shouldBe` ["stdout"]
