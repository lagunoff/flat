-- | doctest utilities
module Flat.Instances.Test (
    tst,
    tstBits,
    asList,
    flatBits,
    allBits,
    encBits,
    prettyShow,
    module Data.Word,
) where

import           Control.Monad                  ((>=>))
import           Data.Word
import           Flat.Bits                      (Bits, asBytes, bits,
                                                 paddedBits, takeBits)
import           Flat.Class                     (Flat (..))
import           Flat.Encoder.Prim              (eFillerF)
import           Flat.Encoder.Strict            (Encoding (Encoding),
                                                 numEncodedBits, strictEncoder)
import           Flat.Run                       (flat, unflat)
import           Flat.Types                     (NumBits)
import           Text.PrettyPrint.HughesPJClass (prettyShow)

-- | Returns: result of flat/unflat test, encoding size in bits, byte encoding
tst :: (Eq a, Flat a) => a -> (Bool, NumBits, [Word8])
tst v = (unflat (flat v) == Right v, size v 0, showBytes v)

-- | Returns: result of flat/unflat test, encoding size in bits, bits encoding
tstBits :: (Eq a, Flat a) => a -> (Bool, NumBits, String)
tstBits v = (unflat (flat v) == Right v, Flat.Class.size v 0, flatBits v)

-- | Test that container is serialised as a List
asList :: (Eq a1, Eq a2, Flat a1, Flat a2) => (a2 -> a1) -> a2 -> Bool
asList f l = tst (f l) == tst l

flatBits :: Flat a => a -> String
flatBits = prettyShow . bits

allBits :: Flat a => a -> String
allBits = prettyShow . paddedBits

encBits :: NumBits -> Encoding -> Bits
encBits maxNumBits e@(Encoding enc) = takeBits (numEncodedBits maxNumBits e) (strictEncoder maxNumBits (Encoding $ enc >=> eFillerF))

showBytes :: Flat a => a -> [Word8]
showBytes = asBytes . bits
