module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (parseLocation)
import Profiles.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        ProfilesMsg subMsg ->
            let
                ( newSearch, cmd ) =
                    Profiles.Update.update subMsg model.currentSearch
            in
                ( { model | currentSearch = newSearch }, Cmd.map ProfilesMsg cmd )
