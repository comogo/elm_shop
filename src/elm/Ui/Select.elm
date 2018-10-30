module Ui.Select exposing (Model, Msg(..), addOption, init, update, view, select)

import Html exposing (..)
import Html.Events exposing (onClick, onMouseLeave)
import Html.Attributes exposing (class)

type alias Item =
    { label : String
    , value : String
    }


type alias Model =
    { closed : Bool
    , selected : Maybe Item
    , items : List Item
    }


type Msg
    = NoOp
    | Focus
    | Close
    | Select Item


init : () -> Model
init _ =
    { closed = True
    , selected = Nothing
    , items = []
    }


addOption : Item -> Model -> Model
addOption item model =
    { model | items = item :: model.items }


select : String -> Model -> Model
select value model =
    let
        selected =
            List.filter (\i -> i.value == value) model.items
                |> List.head

    in
        { model | selected = selected }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )

        Close ->
            ( { model | closed = True }
            , Cmd.none
            )

        Focus ->
            ( { model | closed = False }
            , Cmd.none
            )

        Select item ->
            ( { model | selected = Just item, closed = True }
            , Cmd.none
            )



-- VIEW


viewClosed : Model -> Html Msg
viewClosed model =
    let
        selectedText : String
        selectedText =
            case model.selected of
                Nothing ->
                    ""

                Just item ->
                    item.label
    in
    div [ class "select-sort", onMouseLeave Close ]
        [ div
            [ class "select-sort__selected"
            , onClick Focus
            ]
            [ div [] [ text selectedText ]
            , div [ class "select-sort__icon" ] []
            ]
        ]


viewItem : Item -> Html Msg
viewItem item =
    div
        [ class "select-sort__item"
        , onClick (Select item)
        ]
        [ text item.label ]


viewOpened : Model -> Html Msg
viewOpened model =
    let
        selectedText : String
        selectedText =
            case model.selected of
                Nothing ->
                    ""

                Just item ->
                    item.label
    in
    div [ class "select-sort", onMouseLeave Close ]
        [ div
            [ class "select-sort__selected select-sort__selected--opened"
            , onClick Focus
            ]
            [ div [] [ text selectedText ]
            , div [ class "select-sort__icon" ] []
            ]
        , div [ class "select-sort__list" ]
            (List.map
                viewItem
                model.items
            )
        ]


view : Model -> Html Msg
view model =
    if model.closed then
        viewClosed model

    else
        viewOpened model
