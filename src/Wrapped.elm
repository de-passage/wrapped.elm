module Wrapped exposing
    ( Public
    , ReadOnly
    , Readable
    , WithToken
    , Wrapped
    , WrappedA
    , WrappedC
    , WrappedD
    , WrappedF
    , WrappedI
    , WrappedL
    , WrappedPublic
    , WrappedR
    , WrappedReadable
    , WrappedS
    , WrappedSet
    , WrappedWritable
    , Writable
    , WriteOnly
    , coerce
    , extract
    , lift
    , lift2
    , liftW
    , liftW2
    , map
    , wrap
    , wrapLift
    , wrapLift2
    , wrapLift3
    , pred
    , succ
    , mult
    , plus
    , minus
    , pow
    , divF
    , divI
    , append
    )

import Array exposing (Array)
import Dict exposing (Dict)
import Set exposing (Set)


type Compatible
    = Compatible


type alias Writable r =
    { r | write : Compatible }


type alias Readable r =
    { r | read : Compatible }


type alias Public =
    { write : Compatible
    , read : Compatible
    , token : Compatible
    }


type alias ReadOnly a =
    { read : Compatible
    , token : a
    }


type alias WriteOnly a =
    { write : Compatible
    , token : a
    }


type alias WithToken r a =
    { r | token : a }


type Wrapped a phantom access
    = Wrapped a

type alias TokenWrapped token a phantom access = Wrapped a phantom (WithToken access token)

type alias WrappedPublic a phantom =
    Wrapped a phantom Public


type alias WrappedI phantom =
    WrappedPublic Int phantom


type alias WrappedL a phantom =
    WrappedPublic (List a) phantom


type alias WrappedS phantom =
    WrappedPublic String phantom


type alias WrappedA a phantom =
    WrappedPublic (Array a) phantom


type alias WrappedF phantom =
    WrappedPublic Float phantom


type alias WrappedD a b phantom =
    WrappedPublic (Dict a b) phantom


type alias WrappedC phantom =
    WrappedPublic Char phantom


type alias WrappedSet a phantom =
    WrappedPublic (Set a) phantom


type alias WrappedR a b phantom =
    WrappedPublic (Result a b) phantom


type alias WrappedReadable a phantom access =
    Wrapped a phantom (Readable access)


type alias WrappedWritable a phantom access =
    Wrapped a phantom (Writable access)


extract : WrappedReadable a phantom access -> a
extract (Wrapped a) =
    a


wrap : a -> WrappedWritable a phantom access
wrap a =
    Wrapped a


lift : (a -> b) -> WrappedReadable a phantom access -> b
lift f (Wrapped w) =
    f w


lift2 : (a -> b -> c) -> WrappedReadable a phantom1 access1 -> WrappedReadable b phantom2 access2 -> c
lift2 f (Wrapped w) (Wrapped v) =
    f w v


liftW : (a -> b) -> WrappedReadable a phantom1 access1 -> WrappedWritable b phantom2 access2
liftW f (Wrapped w) =
    Wrapped (f w)


liftW2 : (a -> b -> c) -> WrappedReadable a phantom1 access2 -> WrappedReadable b phantom2 access2 -> WrappedWritable c phantom3 access3
liftW2 f (Wrapped w) (Wrapped v) =
    Wrapped (f w v)

wrapLift : (WrappedWritable x p a -> b) -> x -> b
wrapLift f x = f (Wrapped x)

wrapLift2 : (WrappedWritable x p1 a2 -> WrappedWritable y p2 a2 -> b) -> x -> y -> b
wrapLift2 f x y = f (Wrapped x) (Wrapped y)


wrapLift3 : (WrappedWritable x p1 a2 -> WrappedWritable y p2 a2 -> WrappedWritable z p3 a3 -> b) -> x -> y -> z -> b
wrapLift3 f x y z = f (Wrapped x) (Wrapped y) (Wrapped z)

map : (a -> b) -> WrappedReadable a phantom access -> WrappedWritable b phantom access
map f (Wrapped w) =
    Wrapped (f w)

coerce : TokenWrapped token a phantom2 access -> TokenWrapped token a phantom2 access
coerce (Wrapped a) = Wrapped a

pred : Wrapped number phantom access -> Wrapped number phantom access
pred (Wrapped a) = Wrapped (a - 1)

succ : Wrapped number phantom access -> Wrapped number phantom access
succ (Wrapped a) = Wrapped (a + 1)

mult : Wrapped number phantom access -> Wrapped number phantom access -> Wrapped number phantom access
mult (Wrapped a) (Wrapped b) = Wrapped (a * b)

plus : Wrapped number phantom access -> Wrapped number phantom access -> Wrapped number phantom access
plus (Wrapped a) (Wrapped b) = Wrapped (a + b)

minus : Wrapped number phantom access -> Wrapped number phantom access -> Wrapped number phantom access
minus (Wrapped a) (Wrapped b) = Wrapped (a - b)

pow : Wrapped number phantom access -> Wrapped number phantom access -> Wrapped number phantom access
pow (Wrapped a) (Wrapped b) = Wrapped (a ^ b)

divF : Wrapped Float phantom access -> Wrapped Float phantom access -> Wrapped Float phantom access
divF (Wrapped a) (Wrapped b) = Wrapped (a / b)

divI : Wrapped Int phantom access -> Wrapped Int phantom access -> Wrapped Int phantom access
divI (Wrapped a) (Wrapped b) = Wrapped (a // b)

append : Wrapped appendable phantom access -> Wrapped appendable phantom access -> Wrapped appendable phantom access
append (Wrapped a) (Wrapped b) = Wrapped (a ++ b)

lt : Wrapped comparable phantom access -> Wrapped comparable phantom access -> Bool
lt (Wrapped a) (Wrapped b) = a < b

gt : Wrapped comparable phantom access -> Wrapped comparable phantom access -> Bool
gt (Wrapped a) (Wrapped b) = a > b

lte : Wrapped comparable phantom access -> Wrapped comparable phantom access -> Bool
lte (Wrapped a) (Wrapped b) = a <= b

gte : Wrapped comparable phantom access -> Wrapped comparable phantom access -> Bool
gte (Wrapped a) (Wrapped b) = a >= b

eq : Wrapped comparable phantom access -> Wrapped comparable phantom access -> Bool
eq (Wrapped a) (Wrapped b) = a == b

ne : Wrapped comparable phantom access -> Wrapped comparable phantom access -> Bool
ne (Wrapped a) (Wrapped b) = a /= b