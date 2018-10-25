module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (..)
import Utils


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


productsMock : List Product
productsMock =
    [ Product 1 "Super Mario Odyssey" 197.88 100 "https://upload.wikimedia.org/wikipedia/pt/9/99/Super_Mario_Odyssey_Capa.png"
    , Product 2 "Super Mario Odyssey" 1970.88 100 "https://upload.wikimedia.org/wikipedia/pt/9/99/Super_Mario_Odyssey_Capa.png"
    , Product 3 "Super Mario Odyssey" 19.88 100 "https://upload.wikimedia.org/wikipedia/pt/9/99/Super_Mario_Odyssey_Capa.png"
    ]


type alias Product =
    { id : Int
    , name : String
    , price : Float
    , score : Int
    , image : String
    }



-- MODEL


type alias Model =
    List Product


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model productsMock
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


{-| Renders a single Product as Html
-}
viewProduct : Product -> Html Msg
viewProduct model =
    div [ class "product" ]
        [ div [ class "image-container" ] [ img [ src model.image ] [] ]
        , div [ class "product__name" ] [ text model.name ]
        , div [ class "product__price" ] [ text (Utils.currency model.price) ]
        ]


view : Model -> Html Msg
view model =
    div [ class "container" ] (List.map viewProduct model)
