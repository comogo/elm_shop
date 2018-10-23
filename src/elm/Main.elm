module Main exposing (main)

import Browser
import Html exposing (..)

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


-- MODEL


type alias Model =
    String


init : () -> (Model, Cmd Msg)
init _ =
    ( "Titulo"
    , Cmd.none
    )


-- UPDATE


type Msg
    = NoOp



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


view model =
    h1 [] [ text model ]
