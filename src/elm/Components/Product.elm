module Components.Product exposing (Product, renderProductList)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Product =
    { id : Int
    , name : String
    , price : Float
    , score : Int
    , image : String
    }


{-| Renders a single Product as Html
-}
renderProduct : Product -> Html a
renderProduct model =
    div [ class "product-list__item" ]
        [ div [ class "image-container" ] [ img [ src model.image ] [] ]
        , div [ class "item__name" ] [ text model.name ]
        , div [ class "item__price" ] [ text (String.fromFloat model.price) ]
        ]


{-| Renders a list of Product as Html
-}
renderProductList : List Product -> Html a
renderProductList collection =
    div [ class "product-list" ] (List.map renderProduct collection)
