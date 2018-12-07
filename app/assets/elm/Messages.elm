module Messages exposing (..)

import Profiles.Messages
import Navigation exposing (Location)


type Msg
    = ProfilesMsg Profiles.Messages.Msg
    | OnLocationChange Location
