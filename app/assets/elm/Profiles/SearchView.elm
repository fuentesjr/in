module Profiles.SearchView exposing (..)

import Html exposing (Html, text, button, form, div, input, hr, label, a, p, span)
import Html.Attributes exposing (class, type_, value, name, id, checked, style, href, disabled)
import Html.Events exposing (onClick, onInput)
import Profiles.Models exposing (Search, SearchResults, Profile, PageInfo)
import Profiles.Messages exposing (..)


view : Search -> Html Msg
view model =
    div []
        [ div []
            [ radio "By Fullname" (SetSearchField "fullname") (model.searchField == "fullname")
            , radio "By Skills" (SetSearchField "skills") (model.searchField == "skills")
            ]
        , div [ class "form-search" ]
            [ input
                [ onInput UpdateSearchQuery
                , value model.searchQuery
                , type_ "text"
                , class "input-medium search-query"
                ]
                []
            , button [ onClick GoSearch, class "btn btn-info", style [ ( "margin", "0 2px" ) ] ] [ text "Search" ]
            , p
                [ style [ ( "margin-top", "15px" ) ] ]
                [ a [ onClick NavToNewProfile ] [ text "Add New Profile" ] ]
            , hr [] []
            , div [ class "serach-results" ] [ renderResults model.searchResults ]
            ]
        ]


radio : String -> Msg -> Bool -> Html Msg
radio value msg check =
    label
        [ style [ ( "padding", "20px" ) ] ]
        [ input
            [ style [ ( "margin", "4px 6px" ) ]
            , type_ "radio"
            , onClick msg
            , checked check
            ]
            []
        , text value
        ]


renderResults : SearchResults -> Html Msg
renderResults results =
    if Debug.log "activated" results.pageInfo.activated then
        div []
            [ renderPager results.pageInfo
            , div [ style [ ( "margin-top", "30px" ) ] ]
                (List.map renderProfileName results.profiles)
            ]
    else
        div [] []


renderPager : PageInfo -> Html Msg
renderPager pageInfo =
    let
        toBool someInt =
            someInt < 1
    in
        div []
            [ button
                [ class "btn btn-info"
                , onClick (FetchPage pageInfo.prevPage)
                , disabled (toBool pageInfo.prevPage)
                ]
                [ text "Prev" ]
            , button
                [ class "btn btn-info"
                , onClick (FetchPage pageInfo.nextPage)
                , disabled (toBool pageInfo.nextPage)
                ]
                [ text "Next" ]
            ]


renderProfileName : Profile -> Html Msg
renderProfileName profile =
    let
        profilePath =
            "#profiles/" ++ toString profile.id
    in
        p [] [ a [ href profilePath ] [ text profile.fullname ] ]
