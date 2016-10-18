module Messages exposing (..)

import Http
import Models


type Msg
    = SetSearchField String
    | FetchSucceed (List Models.Profile)
    | FetchFail Http.Error
    | Search
    | UpdateSearchQuery String
