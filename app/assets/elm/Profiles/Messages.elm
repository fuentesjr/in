module Profiles.Messages exposing (..)

import Http
import Profiles.Models exposing (Profile)


type Msg
    = SetSearchField String
    | FetchSucceed (List Profile)
    | FetchFail Http.Error
    | Search
    | UpdateSearchQuery String
    | NavToNewProfile
    | NavToSearch
