module View exposing (..)

import Html exposing (Html, text, div)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Profiles.NewProfileView
import Profiles.SearchView
import Profiles.ProfileView
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        SearchRoute ->
            Html.App.map ProfilesMsg (Profiles.SearchView.view model.currentSearch)

        ProfileRoute pid ->
            Html.App.map ProfilesMsg (Profiles.ProfileView.view model.currentSearch pid)

        NewProfileRoute ->
            Html.App.map ProfilesMsg Profiles.NewProfileView.view

        NotFoundRoute ->
            notFoundPage


notFoundPage : Html Msg
notFoundPage =
    div []
        [ text "Page Not found"
        ]
