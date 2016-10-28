module Profiles.Update exposing (..)

import Navigation
import Http
import Task
import Json.Decode as Json exposing ((:=))
import Profiles.Messages exposing (..)
import Profiles.Models exposing (Profile, Search, SearchResults, PageInfo, Skill)


update : Msg -> Search -> ( Search, Cmd Msg )
update msg model =
    case msg of
        FetchFail _ ->
            ( model, Cmd.none )

        FetchPage pageNum ->
            ( model, execSearch (buildFullPath model pageNum) )

        FetchSucceed newResults ->
            ( { model | searchResults = newResults }, Cmd.none )

        GoSearch ->
            ( model, execSearch (buildFullPath model 1) )

        NavToNewProfile ->
            ( model, Navigation.newUrl "#newprofile" )

        NavToSearch ->
            ( model, Navigation.newUrl "#" )

        SetSearchField srchfld ->
            ( { model | searchField = srchfld }, Cmd.none )

        UpdateSearchQuery val ->
            ( { model | searchQuery = val }, Cmd.none )


buildFullPath : Search -> Int -> String
buildFullPath model page =
    let
        queryParams =
            [ ( "search_field", model.searchField )
            , ( "query", model.searchQuery )
            , ( "page", toString page )
            ]
    in
        Http.url model.searchPath queryParams


execSearch : String -> Cmd Msg
execSearch path =
    Task.perform FetchFail FetchSucceed (Http.get jsonDec path)



-- Our custom JSON Decoders


jsonDec : Json.Decoder SearchResults
jsonDec =
    "results" := searchResultsDec


searchResultsDec : Json.Decoder SearchResults
searchResultsDec =
    Json.object2 SearchResults
        ("profiles" := Json.list profileDec)
        ("pageInfo" := pageInfoDec)


pageInfoDec : Json.Decoder PageInfo
pageInfoDec =
    Json.object3 PageInfo
        ("prevPage" := Json.int)
        ("nextPage" := Json.int)
        ("activated" := Json.bool)


profileDec : Json.Decoder Profile
profileDec =
    Json.object8 Profile
        ("id" := Json.int)
        ("fullname" := Json.string)
        ("title" := Json.string)
        ("position" := Json.string)
        ("company" := Json.string)
        ("skills" := skillsDec)
        ("created_at" := Json.string)
        ("updated_at" := Json.string)


skillsDec : Json.Decoder (List Skill)
skillsDec =
    let
        skill =
            Json.object1 Skill
                ("name" := Json.string)
    in
        Json.list skill
