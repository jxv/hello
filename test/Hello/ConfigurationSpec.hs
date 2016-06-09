module Hello.ConfigurationSpec (spec) where

import Test.Hspec
import Control.Monad.TestFixture

import Hello.Fixture
import Hello.Configuration.Impl

base :: Fixture (WS () ())
base = def
  { _sysArgs = return []
  , _readFile = \_ -> return Nothing
  , _errorExit = \_ -> return ()
  } 

spec :: Spec
spec = do
  describe "target" $ do
    it "should fail to open a file without path" $ do
      let (Left actual, _) = evalTestFixture target base ()
      let expected = "No file path provided."
      actual `shouldBe` expected
    it "should fail to open a file with bad path" $ do
      let fixture = base { _sysArgs = return ["bad_file.txt"] }
      let (Left actual, _) = evalTestFixture target fixture ()
      let expected = "Can't open file: bad_file.txt"
      actual `shouldBe` expected
    it "should open a file with return its contents" $ do
      let fixture = base { _sysArgs = return ["file.txt"], _readFile = \_ -> return $ Just "content\n" }
      let (Right actual, _) = evalTestFixture target fixture ()
      let expected = "content"
      actual `shouldBe` expected
