module Main exposing (..)

import Html.App as App
import Navigation
import Routing exposing (Route)
import Models exposing (Model)
import View exposing (view)
import Messages exposing (..)
import Update exposing (update)
import Profiles.Models exposing (Search)


init : Search -> Result String Route -> ( Model, Cmd Msg )
init initSearch result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( Model currentRoute initSearch [], Cmd.none )


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Navigation.programWithFlags Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
