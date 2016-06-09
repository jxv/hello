module Hello.GreeterSpec (spec) where

import Test.Hspec
import Control.Monad.TestFixture

import Data.Text (Text)

import Hello.Fixture
import Hello.Greeter.Impl

fixture :: Fixture (WS [Text] ())
fixture = def
  { _stdout = \msg -> tell [msg]
  }

spec :: Spec
spec = do
  describe "greet" $ do
    context "should print out the expected text" $ do
      it "TEST" $ do
        let actual = logTestFixture (greet "TEST") fixture ()
        let expected = ["Hello, TEST!"]
        actual `shouldBe` expected
      it "WORLD" $ do
        let actual = logTestFixture (greet "WORLD") fixture ()
        let expected = ["Hello, WORLD!"]
        actual `shouldBe` expected
