module Profiles.NewProfileView exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Profiles.Messages exposing (..)


view : Html Msg
view =
    div []
        [ h2 [] [ text "Add New Profile" ]
        , a [ onClick NavToSearch ] [ text "Back to Search" ]
        ]
