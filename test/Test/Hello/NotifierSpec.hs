module Test.Hello.NotifierSpec (spec) where

import Prelude hiding (log)
import Control.Monad.Trans.Class (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH
import Data.Time.Clock (NominalDiffTime)
import Test.Hspec

import Hello.NotifierImpl (timeTaken)
import Hello.Parts (Console(..))

mkFixture "Fixture" [''Console]

spec :: Spec
spec = do
  describe "timeTaken" $ do
    it "should call stdout with 0s" $ do
      let fixture = def
            { _stdout = \msg -> do
                log "stdout"
                lift $ msg `shouldBe` "0s"
            }
      captured <- logTestFixtureT (timeTaken 0) fixture
      captured `shouldBe` ["stdout"]
