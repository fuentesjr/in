module View exposing (..)

import Html exposing (Html, text, button, form, div, input, hr, label, a, p)
import Html.Attributes exposing (class, type', value, name, id, checked, style)
import Html.Events exposing (onClick, onInput)
import Messages exposing (..)
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ radio "By Fullname" (SetSearchField "fullname")
            , radio "By Skills" (SetSearchField "skills")
            ]
        , div [ class "form-search" ]
            [ input
                [ onInput UpdateSearchQuery
                , value model.searchQuery
                , type' "text"
                , class "input-medium search-query"
                ]
                []
            , button [ onClick Search, class "btn btn-info", style [ ( "margin", "0 2px" ) ] ] [ text "Search" ]
            , p
                [ style [ ( "margin-top", "15px" ) ] ]
                [ a [] [ text "Add New Profile" ] ]
            , hr [] []
            , div [ class "serach-results" ] (List.map renderProfile model.searchResults)
            ]
        ]


radio : String -> Msg -> Html Msg
radio value msg =
    label
        [ style [ ( "padding", "20px" ) ] ]
        [ input [ style [ ( "margin", "4px 6px" ) ], type' "radio", name "search-type", onClick msg ] []
        , text value
        ]


renderProfile : Models.Profile -> Html Msg
renderProfile profile =
    p []
        [ a [] [ text profile.fullname ]
        ]
