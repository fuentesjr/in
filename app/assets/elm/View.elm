module View exposing (..)

import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Profiles.ProfileView
import Profiles.NewProfileView
import Profiles.SearchView
import Profiles.ProfileView
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div [ class "text-center" ]
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        SearchRoute ->
            Html.map ProfilesMsg (Profiles.SearchView.view model.currentSearch)

        ProfileRoute pid ->
            Html.map ProfilesMsg (Profiles.ProfileView.view model.currentSearch pid)

        NewProfileRoute ->
            Html.map ProfilesMsg (Profiles.NewProfileView.view model.currentSearch.scrapeUrl)

        NotFoundRoute ->
            notFoundPage


notFoundPage : Html Msg
notFoundPage =
    div []
        [ text "Page Not found"
        ]
