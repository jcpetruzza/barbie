{-# OPTIONS_GHC -O0 #-}
{-# LANGUAGE DeriveAnyClass       #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE UndecidableInstances #-}
module TestBarbiesW
  ( Record1W(..)
  , Record3W(..)

  , Record1WS(..)
  , Record3WS(..)

  , Sum3W(..)

  , CompositeRecordW(..)
  , SumRecW(..)
  , InfRecW(..)

  , NestedFW(..)
  , Nested2FW(..)
  )

where

import Data.Functor.Barbie
import Barbies.Bare

import Data.Typeable
import GHC.Generics
import Test.Tasty.QuickCheck

----------------------------------------------------
-- Product Barbies
----------------------------------------------------

data Record1W t f
  = Record1W { rec1w_f1 :: Wear t f Int }
  deriving (Generic, Typeable)


instance FunctorB (Record1W Bare)
instance FunctorB (Record1W Covered)
instance TraversableB (Record1W Covered)
instance ApplicativeB (Record1W Covered)
instance ConstraintsB (Record1W Bare)
instance ConstraintsB (Record1W Covered)
instance BareB Record1W


deriving instance AllB  Show   (Record1W Bare)    => Show (Record1W Bare f)
deriving instance AllB  Eq     (Record1W Bare)    => Eq   (Record1W Bare f)
deriving instance AllBF Show f (Record1W Covered) => Show (Record1W Covered f)
deriving instance AllBF Eq   f (Record1W Covered) => Eq   (Record1W Covered f)

instance AllBF Arbitrary f (Record1W Covered) => Arbitrary (Record1W Covered f) where
  arbitrary = Record1W <$> arbitrary


data Record1WS t f
  = Record1WS { rec1ws_f1 :: !(Wear t f Int) }
  deriving (Generic, Typeable)


instance FunctorB (Record1WS Bare)
instance FunctorB (Record1WS Covered)
instance TraversableB (Record1WS Covered)
instance ApplicativeB (Record1WS Covered)
instance ConstraintsB (Record1WS Bare)
instance ConstraintsB (Record1WS Covered)
instance BareB Record1WS


deriving instance AllB  Show   (Record1WS Bare)    => Show (Record1WS Bare f)
deriving instance AllB  Eq     (Record1WS Bare)    => Eq   (Record1WS Bare f)
deriving instance AllBF Show f (Record1WS Covered) => Show (Record1WS Covered f)
deriving instance AllBF Eq   f (Record1WS Covered) => Eq   (Record1WS Covered f)

instance AllBF Arbitrary f (Record1WS Covered) => Arbitrary (Record1WS Covered f) where
  arbitrary = Record1WS <$> arbitrary

data Record3W t f
  = Record3W
      { rec3w_f1 :: Wear t f Int
      , rec3w_f2 :: Wear t f Bool
      , rec3w_f3 :: Wear t f Char
      }
  deriving (Generic, Typeable)


instance FunctorB (Record3W Bare)
instance FunctorB (Record3W Covered)
instance TraversableB (Record3W Bare)
instance TraversableB (Record3W Covered)
instance ApplicativeB (Record3W Covered)
instance ConstraintsB (Record3W Bare)
instance ConstraintsB (Record3W Covered)

instance BareB Record3W

deriving instance AllB  Show   (Record3W Bare)    => Show (Record3W Bare f)
deriving instance AllB  Eq     (Record3W Bare)    => Eq   (Record3W Bare f)
deriving instance AllBF Show f (Record3W Covered) => Show (Record3W Covered f)
deriving instance AllBF Eq   f (Record3W Covered) => Eq   (Record3W Covered f)

instance AllBF Arbitrary f (Record3W Covered) => Arbitrary (Record3W Covered f) where
  arbitrary = Record3W <$> arbitrary <*> arbitrary <*> arbitrary


data Record3WS t f
  = Record3WS
      { rec3ws_f1 :: !(Wear t f Int)
      , rec3ws_f2 :: !(Wear t f Bool)
      , rec3ws_f3 :: !(Wear t f Char)
      }
  deriving (Generic, Typeable)


instance FunctorB (Record3WS Bare)
instance FunctorB (Record3WS Covered)
instance TraversableB (Record3WS Covered)
instance ApplicativeB (Record3WS Covered)
instance ConstraintsB (Record3WS Bare)
instance ConstraintsB (Record3WS Covered)
instance BareB Record3WS

deriving instance AllB  Show   (Record3WS Bare)    => Show (Record3WS Bare f)
deriving instance AllB  Eq     (Record3WS Bare)    => Eq   (Record3WS Bare f)
deriving instance AllBF Show f (Record3WS Covered) => Show (Record3WS Covered f)
deriving instance AllBF Eq   f (Record3WS Covered) => Eq   (Record3WS Covered f)

instance AllBF Arbitrary f (Record3WS Covered) => Arbitrary (Record3WS Covered f) where
  arbitrary = Record3WS <$> arbitrary <*> arbitrary <*> arbitrary


----------------------------------------------------
-- Sum Barbies
----------------------------------------------------

data Sum3W t f
  = Sum3W_0
  | Sum3W_1 (Wear t f Int)
  | Sum3W_2 (Wear t f Int) (Wear t f Bool)
  deriving (Generic, Typeable)

instance FunctorB (Sum3W Bare)
instance FunctorB (Sum3W Covered)
instance TraversableB (Sum3W Covered)
instance ConstraintsB (Sum3W Bare)
instance ConstraintsB (Sum3W Covered)
instance BareB Sum3W

deriving instance AllB  Show   (Sum3W Bare)    => Show (Sum3W Bare f)
deriving instance AllB  Eq     (Sum3W Bare)    => Eq   (Sum3W Bare f)
deriving instance AllBF Show f (Sum3W Covered) => Show (Sum3W Covered f)
deriving instance AllBF Eq   f (Sum3W Covered) => Eq   (Sum3W Covered f)

instance AllBF Arbitrary f (Sum3W Covered) => Arbitrary (Sum3W Covered f) where
  arbitrary
    = oneof
        [ pure Sum3W_0
        , Sum3W_1 <$> arbitrary
        , Sum3W_2 <$> arbitrary <*> arbitrary
        ]


-----------------------------------------------------
-- Composite and recursive
-----------------------------------------------------


data CompositeRecordW t f
  = CompositeRecordW
      { crecw_f1 :: Wear t f Int
      , crecw_F2 :: Wear t f Bool
      , crecw_f3 :: Record3W t f
      , crecw_f4 :: Record1W t f
      }
  deriving (Generic, Typeable)

instance FunctorB (CompositeRecordW Bare)
instance FunctorB (CompositeRecordW Covered)
instance TraversableB (CompositeRecordW Covered)
instance ApplicativeB (CompositeRecordW Covered)
instance ConstraintsB (CompositeRecordW Bare)
instance ConstraintsB (CompositeRecordW Covered)
instance BareB CompositeRecordW

deriving instance AllB  Show   (CompositeRecordW Bare)    => Show (CompositeRecordW Bare f)
deriving instance AllB  Eq     (CompositeRecordW Bare)    => Eq   (CompositeRecordW Bare f)
deriving instance AllBF Show f (CompositeRecordW Covered) => Show (CompositeRecordW Covered f)
deriving instance AllBF Eq   f (CompositeRecordW Covered) => Eq   (CompositeRecordW Covered f)

instance AllBF Arbitrary f (CompositeRecordW Covered) => Arbitrary (CompositeRecordW Covered f) where
  arbitrary
    = CompositeRecordW <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary


data SumRecW t f
  = SumRecW_0
  | SumRecW_1 (Wear t f Int)
  | SumRecW_2 (Wear t f Int) (SumRecW t f)
  deriving (Generic, Typeable)

instance FunctorB (SumRecW Bare)
instance FunctorB (SumRecW Covered)
instance TraversableB (SumRecW Covered)
instance ConstraintsB (SumRecW Bare)
instance ConstraintsB (SumRecW Covered)
instance BareB SumRecW

deriving instance AllB  Show   (SumRecW Bare)    => Show (SumRecW Bare f)
deriving instance AllB  Eq     (SumRecW Bare)    => Eq   (SumRecW Bare f)
deriving instance AllBF Show f (SumRecW Covered) => Show (SumRecW Covered f)
deriving instance AllBF Eq   f (SumRecW Covered) => Eq   (SumRecW Covered f)

instance AllBF Arbitrary f (SumRecW Covered) => Arbitrary (SumRecW Covered f) where
  arbitrary
    = oneof
        [ pure SumRecW_0
        , SumRecW_1 <$> arbitrary
        , SumRecW_2 <$> arbitrary <*> arbitrary
        ]

data InfRecW t f
  = InfRecW { irw_1 :: Wear t f Int, irw_2 :: InfRecW t f }
  deriving (Generic, Typeable)


instance FunctorB (InfRecW Bare)
instance FunctorB (InfRecW Covered)
instance TraversableB (InfRecW Covered)
instance ApplicativeB (InfRecW Covered)
instance ConstraintsB (InfRecW Bare)
instance ConstraintsB (InfRecW Covered)
instance BareB InfRecW

deriving instance AllB  Show   (InfRecW Bare)    => Show (InfRecW Bare f)
deriving instance AllB  Eq     (InfRecW Bare)    => Eq   (InfRecW Bare f)
deriving instance AllBF Show f (InfRecW Covered) => Show (InfRecW Covered f)
deriving instance AllBF Eq   f (InfRecW Covered) => Eq   (InfRecW Covered f)

-----------------------------------------------------
-- Nested under functors
-----------------------------------------------------

data NestedFW t f
  = NestedFW
      { npfw_1 :: Wear t f Int
      , npfw_2 :: [Record3W t f]
      , npfw_4 :: Maybe (NestedFW t f)
      }
  deriving (Generic, Typeable)


instance FunctorB (NestedFW Bare)
instance FunctorB (NestedFW Covered)
instance TraversableB (NestedFW Bare)
instance TraversableB (NestedFW Covered)
instance ApplicativeB (NestedFW Covered)
instance BareB NestedFW

deriving instance Show (NestedFW Bare f)
deriving instance Eq   (NestedFW Bare f)
deriving instance (Show (f Int), Show (Record3W Covered f)) => Show (NestedFW Covered f)
deriving instance (Eq   (f Int), Eq   (Record3W Covered f)) => Eq   (NestedFW Covered f)

instance (Arbitrary (f Int), Arbitrary (f Bool), Arbitrary (f Char)) => Arbitrary (NestedFW Covered f) where
  arbitrary
    = scale (`div` 2) $
        NestedFW <$> arbitrary <*> scale (`div` 2) arbitrary <*> arbitrary


data Nested2FW t f
  = Nested2FW
    { np2fw_1 :: Wear t f Int
    , np2fw_2 :: [Maybe (Nested2FW t f)]
    }
  deriving (Generic, Typeable)

instance FunctorB (Nested2FW Bare)
instance FunctorB (Nested2FW Covered)
instance TraversableB (Nested2FW Bare)
instance TraversableB (Nested2FW Covered)
instance ApplicativeB (Nested2FW Covered)
instance BareB Nested2FW

deriving instance Show (Nested2FW Bare f)
deriving instance Eq (Nested2FW Bare f)
deriving instance Show (f Int) => Show (Nested2FW Covered f)
deriving instance Eq (f Int) => Eq (Nested2FW Covered f)

instance Arbitrary (f Int) => Arbitrary (Nested2FW Covered f) where
  arbitrary = scale (`div` 2) $ Nested2FW <$> arbitrary <*> scale (`div` 2) arbitrary


-----------------------------------------------------
-- Parametric barbies
-----------------------------------------------------

data ParBW b t (f :: * -> *)
  = ParBW (b t f)
  deriving (Generic, Typeable)

instance FunctorB (b t) => FunctorB (ParBW b t)
instance TraversableB (b t) => TraversableB (ParBW b t)
instance ApplicativeB (b t) => ApplicativeB (ParBW b t)
instance BareB b => BareB (ParBW b)

-- XXX GHC currently rejects deriving this one since it
-- gets stuck on the TagSelf type family and can't see this
-- is an "Other" case. It looks like a bug to me, since it
-- seems to have enough information to decide that it is the
-- `Other` case that should be picked (or in any case, I don't
-- quite see why this is not an issue when `b` doesn't have the
-- extra type parameter.
instance ConstraintsB (b t) => ConstraintsB (ParBW b t) where
  type AllB c (ParBW b t) = AllB c (b t)
  baddDicts (ParBW btf) = ParBW (baddDicts btf)


data ParBHW h b t (f :: * -> *)
  = ParBHW (h (b t f))
  deriving (Generic, Typeable)

instance (Functor h, FunctorB (b t)) => FunctorB (ParBHW h b t)
instance (Traversable h, TraversableB (b t)) => TraversableB (ParBHW h b t)
instance (Applicative h, ApplicativeB (b t)) => ApplicativeB (ParBHW h b t)
instance (Functor h, BareB b) => BareB (ParBHW h b)

data ParXW a t f
  = ParXW (Wear t f a)
  deriving (Generic, Typeable)

instance FunctorB (ParXW a Bare)
instance FunctorB (ParXW a Covered)
instance TraversableB (ParXW a Covered)
instance ApplicativeB (ParXW a Covered)
instance ConstraintsB (ParXW a Covered)
