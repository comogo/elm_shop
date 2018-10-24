module UtilsTest exposing (suite)

import Utils
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "The Utils module"
        [ describe "currency"
            [ test "format thousand" <|
                \_ ->
                    1000.776
                        |> Utils.currency
                        |> Expect.equal "R$ 1.000,78"
            , test "format hundred" <|
                \_ ->
                    100.0
                        |> Utils.currency
                        |> Expect.equal "R$ 100,00"
            ]
        ]
