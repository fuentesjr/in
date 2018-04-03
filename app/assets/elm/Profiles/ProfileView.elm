module Profiles.ProfileView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style, class, href)
import Profiles.Models exposing (Search, SearchResults, Profile, Skill, blankProfile)
import Profiles.Messages exposing (Msg)


view : Search -> Int -> Html Msg
view model profileId =
    let
        profile =
            getProfile model.searchResults.profiles profileId
    in
        div [ class "container-fluid" ]
            [ h3 [ class "row" ]
                [ text profile.fullname ]
            , div [ class "row" ]
                [ label [ style [ ( "margin-right", "4px" ) ] ]
                    [ text "title: " ]
                , span []
                    [ text profile.title ]
                ]
            , h5 [ class "row" ]
                [ text "skills" ]
            , div [ class "row" ]
                [ renderSkills profile.skills ]
            , div [ style [ ( "margin-top", "10px" ) ] ]
                [ a [ href "#/" ] [ text "Go Back" ] ]
            ]


renderSkills : List Skill -> Html Msg
renderSkills skills =
    let
        pillCSS =
            [ class "btn-xs btn-info" ]

        renderSkill =
            \s -> div pillCSS [ text s.name ]
    in
        div [] (List.map renderSkill skills)


getProfile : List Profile -> Int -> Profile
getProfile results profileId =
    let
        findUser =
            List.filter (\p -> p.id == profileId) results
    in
        Maybe.withDefault blankProfile (List.head findUser)
