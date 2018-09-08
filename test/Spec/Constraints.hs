{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Spec.Constraints
  ( lawAdjProofPrj
  , lawProofEquivPrj
  )

where

import Clothes(F)
import Data.Barbie(bmap, ConstraintsB(..), ProofB(..))
import Data.Barbie.Constraints(ClassF, Dict)

import Data.Functor.Product (Product(Pair))
import Data.Typeable(Typeable, Proxy(..), typeRep)

import Test.Tasty(TestTree)
import Test.Tasty.QuickCheck(Arbitrary(..), testProperty, (===))


lawAdjProofPrj
  :: forall b
  . ( ConstraintsB b, AllB (ClassF Show F) b
    , Eq (b F)
    , Show (b F)
    , Arbitrary (b F)
    , Typeable b
    )
  => TestTree
lawAdjProofPrj
  = testProperty (show (typeRep (Proxy :: Proxy b))) $ \b ->
      bmap second (adjProof b :: b (Product (Dict (ClassF Show F)) F)) === b
  where
    second (Pair _ b) = b


lawProofEquivPrj
  :: forall b
  . ( ProofB b, AllB (ClassF Show F) b
    , Eq (b (Dict (ClassF Show F)))
    , Show (b F), Show (b (Dict (ClassF Show F)))
    , Arbitrary (b F)
    , Typeable b
    )
  => TestTree
lawProofEquivPrj
  = testProperty (show (typeRep (Proxy :: Proxy b))) $ \b ->
      bmap first (adjProof b :: b (Product (Dict (ClassF Show F)) F)) === bproof
  where
    first (Pair a _) = a
