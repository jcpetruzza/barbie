{-# LANGUAGE ConstraintKinds         #-}
{-# LANGUAGE FlexibleInstances       #-}
{-# LANGUAGE GADTs                   #-}
{-# LANGUAGE KindSignatures          #-}
{-# LANGUAGE MultiParamTypeClasses   #-}
{-# LANGUAGE Rank2Types              #-}
{-# LANGUAGE TypeFamilies            #-}
{-# LANGUAGE UndecidableInstances    #-}
{-# LANGUAGE UndecidableSuperClasses #-}
module Data.Barbie.Internal.Dicts
  ( Dict(..)
  , requiringDict

  , ClassF
  )

where

import Data.Functor.Classes(Show1(..))


-- | @'Dict' c a@ is evidence that there exists an instance of @c a@.
--
--   It is essentially equivalent to @Dict (c a)@ from the
--   <http://hackage.haskell.org/package/constraints constraints> package,
--   but because of its kind, it allows us to define things like @'Dict' 'Show'@.
data Dict c a where
  Dict :: c a => Dict c a

instance Eq (Dict c a) where
  _ == _ = True

instance Show (Dict c a) where
  showsPrec _ Dict = showString "Dict"

instance Show1 (Dict c)  where
  liftShowsPrec _ _ = showsPrec


-- | 'ClassF' has one universal instance that makes @'ClassF' c f a@
--   equivalent to @c (f a)@. However, we have
--
-- @
-- 'ClassF c f :: * -> 'Constraint'
-- @
--
-- This is useful since it allows to define constraint-constructors like
-- @'ClassF' 'Monoid' 'Maybe'@
class c (f a) => ClassF c f a where
instance c (f a) => ClassF c f a

-- | Turn a constrained-function into an unconstrained one
--   that uses the packed instance dictionary instead.
requiringDict :: (c  a => r) -> (Dict c a -> r)
requiringDict r = \Dict -> r
