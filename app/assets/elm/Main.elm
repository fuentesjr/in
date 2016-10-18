module Main exposing (..)

import Html.App as App
import Models exposing (Model)
import Messages exposing (Msg)
import Update exposing (update)
import View exposing (view)


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
