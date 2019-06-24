module Test.Data.Byte.Unsigned exposing(suite)

import Test exposing (..)
import Expect
import Fuzz exposing (..)

import Data.Byte.Unsigned as UnsignedByte exposing(UnsignedByte)

suite : Test
suite =
    describe "The Data.Byte.Unsigned module"
        [ describe "fromInt"
            [ fuzz (intRange 0 255) "identity when 0~255" <|
                \int ->
                    int
                        |> UnsignedByte.fromInt
                        |> UnsignedByte.toInt
                        |> Expect.equal int
            , test "overflow when over 255" <|
                \_ ->
                    let
                        data = [256, 300, 512, 2049]
                        expect = [0, 44, 0, 1]
                    in
                    data
                        |> List.map UnsignedByte.fromInt
                        |> List.map UnsignedByte.toInt
                        |> Expect.equal expect
            , test "overflow when minus value" <|
                \_ ->
                    let
                        data = [-1, -5, -128, -255, -256, -257]
                        expect = [255, 251, 128, 1, 0, 255]
                    in
                    data
                        |> List.map UnsignedByte.fromInt
                        |> List.map UnsignedByte.toInt
                        |> Expect.equal expect

            ]
        , describe "apply"
            [ fuzz (tuple (intRange 0 127, intRange 0 127)) "it can apply (Int -> Int -> Int) function" <|
                \(x, y) ->
                    UnsignedByte.apply (+) (UnsignedByte.fromInt x) (UnsignedByte.fromInt y)
                        |> UnsignedByte.toInt
                        |> Expect.equal (x + y)
            , test "overflow case" <|
                \_ ->
                    let
                        data = [(255, 1), (128, 200), (-128, -127)]
                        expect = [0, 72, 1]
                    in
                    data
                        |> List.map (\(x, y) -> UnsignedByte.apply (+) (UnsignedByte.fromInt x) (UnsignedByte.fromInt y))
                        |> List.map UnsignedByte.toInt
                        |> Expect.equal expect

            ]
        ]
