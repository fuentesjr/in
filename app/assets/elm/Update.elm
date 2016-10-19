module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Profiles.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProfilesMsg subMsg ->
            let
                ( newSearch, cmd ) =
                    Profiles.Update.update subMsg model.currentSearch
            in
                ( { model | currentSearch = newSearch }, Cmd.map ProfilesMsg cmd )
