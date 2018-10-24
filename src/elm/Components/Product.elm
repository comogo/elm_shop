module Components.Product exposing (Product, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Utils exposing (currency)


type alias Product =
    { id : Int
    , name : String
    , price : Float
    , score : Int
    , image : String
    }


{-| Renders a single Product as Html
-}
render : Product -> Html a
render model =
    div [ class "product" ]
        [ div [ class "image-container" ] [ img [ src model.image ] [] ]
        , div [ class "product__name" ] [ text model.name ]
        , div [ class "product__price" ] [ text (currency model.price) ]
        ]


{-| Renders a list of Product as Html
-}
view : List Product -> Html a
view collection =
    div [ class "container" ] (List.map render collection)
