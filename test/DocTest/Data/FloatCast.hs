
{-# LANGUAGE NoMonomorphismRestriction, ExtendedDefaultRules#-}
module DocTest.Data.FloatCast where
import qualified DocTest
import           Test.Tasty                     ( TestTree
                                                , testGroup
                                                )
import           Data.FloatCast

tests :: IO TestTree
tests = testGroup "Data.FloatCast" <$> sequence
    [ DocTest.testProp "src/Data/FloatCast.hs:44"
                       (\f -> wordToFloat (floatToWord f) == f)
    , DocTest.test "src/Data/FloatCast.hs:38"
                   ["3189768192"]
                   (DocTest.asPrint (floatToWord (-0.15625)))
    , DocTest.test "src/Data/FloatCast.hs:41"
                   ["-0.15625"]
                   (DocTest.asPrint (wordToFloat 3189768192))
    , DocTest.testProp "src/Data/FloatCast.hs:64"
                       (\f -> wordToDouble (doubleToWord f) == f)
    , DocTest.test "src/Data/FloatCast.hs:58"
                   ["13818169556679524352"]
                   (DocTest.asPrint (doubleToWord (-0.15625)))
    , DocTest.test "src/Data/FloatCast.hs:61"
                   ["-0.15625"]
                   (DocTest.asPrint (wordToDouble 13818169556679524352))
    ]
