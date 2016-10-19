module Profiles.SearchView exposing (..)

import Html exposing (Html, text, button, form, div, input, hr, label, a, p)
import Html.Attributes exposing (class, type', value, name, id, checked, style)
import Html.Events exposing (onClick, onInput)
import Profiles.Models exposing (Search)
import Profiles.Messages as Msgs
import Profiles.Messages exposing (Msg)


view : Search -> Html Msg
view model =
    div []
        [ div []
            [ radio "By Fullname" (Msgs.SetSearchField "fullname") (model.searchField == "fullname")
            , radio "By Skills" (Msgs.SetSearchField "skills") (model.searchField == "skills")
            ]
        , div [ class "form-search" ]
            [ input
                [ onInput Msgs.UpdateSearchQuery
                , value model.searchQuery
                , type' "text"
                , class "input-medium search-query"
                ]
                []
            , button [ onClick Msgs.Search, class "btn btn-info", style [ ( "margin", "0 2px" ) ] ] [ text "Search" ]
            , p
                [ style [ ( "margin-top", "15px" ) ] ]
                [ a [ onClick Msgs.NavToNewProfile ] [ text "Add New Profile" ] ]
            , hr [] []
            , div [ class "serach-results" ] (List.map renderProfile model.searchResults)
            ]
        ]


radio : String -> msg -> Bool -> Html msg
radio value msg check =
    label
        [ style [ ( "padding", "20px" ) ] ]
        [ input
            [ style [ ( "margin", "4px 6px" ) ]
            , type' "radio"
            , onClick msg
            , checked check
            ]
            []
        , text value
        ]


renderProfile profile =
    p []
        [ a [] [ text profile.fullname ]
        ]
