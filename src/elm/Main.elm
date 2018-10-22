module Main exposing (main, view)

import Html exposing (..)
import Html.Attributes exposing (..)


view model =
    div [ class "main" ]
        [ h1 [] [ text "Titulo" ]
        , p [] [ text "conteudo" ]
        ]


main =
    view "foo"
