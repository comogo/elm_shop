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


type SortTypes
    = Price
    | Popularity
    | Alphabetic



-- MODEL


type alias Model =
    { products : List Product
    , hoveredProduct : Maybe Product
    , sortBy : SortTypes
    , openedSelectSort : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model productsMock Nothing Popularity False
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | MouseOverProduct Product
    | MouseOutProduct Product
    | ToggleSelectSort
    | CloseSelectorSort
    | SelectSortType SortTypes


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        MouseOverProduct product ->
            ( { model | hoveredProduct = Just product }
            , Cmd.none
            )

        MouseOutProduct _ ->
            ( { model | hoveredProduct = Nothing }
            , Cmd.none
            )

        ToggleSelectSort ->
            ( { model | openedSelectSort = not model.openedSelectSort }
            , Cmd.none
            )

        CloseSelectorSort ->
            ( { model | openedSelectSort = False }
            , Cmd.none
            )

        SelectSortType t ->
            ( { model | openedSelectSort = False, sortBy = t }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


{-| Renders a single Product as Html
-}
viewProduct : Product -> Maybe Product -> Html Msg
viewProduct model hovered =
    let
        image : Html Msg
        image =
            div [ class "image-container" ] [ img [ src model.image ] [] ]

        completeInfo : List (Html Msg)
        completeInfo =
            [ div [ class "product__name" ] [ text model.name ]
            , div
                [ class "product__price" ]
                [ text (Utils.currency model.price) ]
            ]

        addToCart : List (Html Msg)
        addToCart =
            [ div
                [ class "product__add-to-cart" ]
                [ text "adicionar ao carrinho" ]
            ]

        info : List (Html Msg)
        info =
            case hovered of
                Nothing ->
                    completeInfo

                Just p ->
                    if p.id == model.id then
                        addToCart

                    else
                        completeInfo
    in
    div
        [ class "product"
        , onMouseOver (MouseOverProduct model)
        , onMouseOut (MouseOutProduct model)
        ]
        (image :: info)


viewSelectSort : Model -> Html Msg
viewSelectSort model =
    let
        showItem : SortTypes -> Html Msg
        showItem a =
            div
                [ class "select-sort__item"
                , onClick (SelectSortType a)
                ]
                [ text (typeTranslation a) ]

        showList : Html Msg
        showList =
            if model.openedSelectSort then
                div
                    [ class "select-sort__list" ]
                    (List.map
                        showItem
                        [ Price, Popularity, Alphabetic ]
                    )

            else
                text ""

        selectClass : String
        selectClass =
            if model.openedSelectSort then
                "select-sort__selected select-sort__selected--opened"

            else
                "select-sort__selected"

        typeTranslation : SortTypes -> String
        typeTranslation a =
            case a of
                Price ->
                    "Preço"

                Popularity ->
                    "Popularidade"

                Alphabetic ->
                    "Alfabética"
    in
    div [ class "select-sort", onMouseLeave CloseSelectorSort ]
        [ div
            [ class selectClass
            , onClick ToggleSelectSort
            ]
            [ div [] [ text (typeTranslation model.sortBy) ]
            , div [ class "select-sort__icon" ] []
            ]
        , showList
        ]


viewEmptyCart : Html Msg
viewEmptyCart =
    div [ class "cart cart--empty" ]
        [ div [ class "cart__title" ] [ text "Carrinho" ]
        , div [ class "cart__icon" ] []
        , div [ class "cart__info" ]
            [ text "Até o momento,"
            , br [] []
            , text "seu carrinho está vazio"
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ div [ class "content" ]
            [ div [ class "header" ]
                [ h1 [] [ text "Games" ]
                , viewSelectSort model
                ]
            , div [ class "container" ]
                (List.map
                    (\p -> viewProduct p model.hoveredProduct)
                    model.products
                )
            ]
        , div [ class "aside" ] [ viewEmptyCart ]
        ]
