module Models exposing (..)

import Routing
import Profiles.Models exposing (Search)


type alias Model =
    { route : Routing.Route
    , currentSearch : Search
    }
