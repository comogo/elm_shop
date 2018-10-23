module Components.Product exposing (Product, renderProductList)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (optional, required)


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


{-| Decodes JSON into a Product
-}
productDecoder : Decode.Decoder Product
productDecoder =
    Decode.succeed Product
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "price" Decode.float
        |> optional "score" Decode.int 1
        |> optional "image" Decode.string "/images/default-product.jpg"


{-| Decodes and JSON array into Products
-}
productListDecoder : Decode.Decoder (List Product)
productListDecoder =
    Decode.list productDecoder
