module Main exposing (main)

import Browser
import Components.Product exposing (Product, renderProductList)
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
    List Product


init : () -> ( Model, Cmd Msg )
init _ =
    ( [ Product 312 "Super Mario Odyssey" 197.88 100 "https://upload.wikimedia.org/wikipedia/pt/9/99/Super_Mario_Odyssey_Capa.png"
      , Product 312 "Super Mario Odyssey" 197.88 100 "https://upload.wikimedia.org/wikipedia/pt/9/99/Super_Mario_Odyssey_Capa.png"
      , Product 312 "Super Mario Odyssey" 197.88 100 "https://upload.wikimedia.org/wikipedia/pt/9/99/Super_Mario_Odyssey_Capa.png"
      ]
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
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
    renderProductList model
