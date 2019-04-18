module Profiles.Messages exposing (..)

import Http
import Profiles.Models exposing (SearchResults)


type Msg
    = FetchFail Http.Error
    | FetchPage Int
    | FetchSucceed SearchResults
    | FetchGood String
    | GoScrape
    | GoSearch
    | NavToNewProfile
    | NavToSearch
    | SetSearchField String
    | UpdateSearchQuery String
    | UpdateScrapeUrl String
