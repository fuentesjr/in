module Models exposing (..)

import Routing
import Profiles.Models exposing (Profile, Search)


type alias Model =
    { route : Routing.Route
    , currentSearch : Search
    , profiles : List Profile
    }
