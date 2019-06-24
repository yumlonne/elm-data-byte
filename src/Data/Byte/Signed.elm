module Data.Byte.Signed exposing(SignedByte, fromInt, toInt, apply)

{-| hoge -}
type SignedByte = SignedByte Int


{-| fuga -}
fromInt : Int -> SignedByte
fromInt x =
    let
        bit8 = modBy 256 x
        actualValue =
            if bit8 >= 128 then
                256 - bit8
            else
                bit8
    in
    SignedByte actualValue


{-| fuga -}
toInt : SignedByte -> Int
toInt (SignedByte x) = x


{-| fuga -}
apply : (Int -> Int -> Int) -> SignedByte -> SignedByte -> SignedByte
apply f (SignedByte x) (SignedByte y) =
    f x y
        |> fromInt

