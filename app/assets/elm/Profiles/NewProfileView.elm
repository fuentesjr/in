module Profiles.NewProfileView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Profiles.Messages exposing (..)


view : String -> Html Msg
view model =
    div []
        [ h2 [] [ text "Scrape a Profile" ]
        , div [ class "form-search" ]
            [ input
                [ onInput UpdateScrapeUrl
                , value model
                , type_ "text"
                , class "input-medium search-query"
                ]
                []
            , button [ onClick GoScrape, class "btn btn-info", style [ ( "margin", "0 2px" ) ] ] [ text "Scrape" ]
            ]
        , a [ onClick NavToSearch ] [ text "Back to Search" ]
        ]
