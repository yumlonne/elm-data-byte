module Data.Byte.Unsigned exposing (UnsignedByte, fromInt, toInt, apply)

type UnsignedByte = UnsignedByte Int


fromInt : Int -> UnsignedByte
fromInt x =
    modBy 256 x
        |> UnsignedByte


toInt : UnsignedByte -> Int
toInt (UnsignedByte x) = x


apply : (Int -> Int -> Int) -> UnsignedByte -> UnsignedByte -> UnsignedByte
apply f (UnsignedByte x) (UnsignedByte y) =
    f x y
        |> fromInt
