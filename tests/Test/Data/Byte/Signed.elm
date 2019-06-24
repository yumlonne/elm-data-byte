module Test.Data.Byte.Signed exposing(suite)

import Test exposing (..)
import Expect
import Data.Byte.Signed as SignedByte exposing(SignedByte)

suite : Test
suite =
    describe "The Data.Byte.Signed module"
        [ describe "fromInt"
            [ test "identity for -128~127" <|
                \_ ->
                    let
                        data = [-128, -127, -1, 0, 1, 126, 127]
                    in
                    data
                        |> List.map SignedByte.fromInt
                        |> List.map SignedByte.toInt
                        |> Expect.equal data
            ]
        ]
