module Test.Hello.ConfigurationSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Test.Hspec

import Hello.ConfigurationImpl (target, initText)
import Hello.Parts (Console(..), FileSystem(..))

mkFixture "Fixture" [''Console, ''FileSystem]

spec :: Spec
spec = do
  describe "initText" $ do
    it "should be empty when input is empty" $ do
      initText "" `shouldBe` ""

    it "should drop the last character when input is non-empty" $ do
      initText "12345" `shouldBe` "1234"

  describe "target" $ do
    it "should call greet with stubbed target's name" $ do
      let fixture = def
            { _sysArg = do
                return "file.txt"
            , _readFile = \filePath -> do
                lift $ filePath `shouldBe` "file.txt"
                return "contents\n"
            }
      contents <- unTestFixtureT target fixture
      contents `shouldBe` "contents"
