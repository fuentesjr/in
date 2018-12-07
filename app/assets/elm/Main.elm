module Main exposing (..)

import Navigation
import Routing
import Navigation exposing (Location)
import Models exposing (Model)
import View exposing (view)
import Messages exposing (..)
import Update exposing (update)
import Profiles.Models exposing (Search)


init : Search -> Location -> ( Model, Cmd Msg )
init initSearch location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( Model currentRoute initSearch, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Search Model Msg
main =
    Navigation.programWithFlags OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
