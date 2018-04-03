module Profiles.Update exposing (..)

import Navigation
import Http exposing (..)
import Task
import Json.Decode as Json exposing (field)
import Profiles.Messages exposing (..)
import Profiles.Models exposing (Profile, Search, SearchResults, PageInfo, Skill)
import List
import String


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

        toQueryString params =
            String.join "&" (List.map (\t -> Tuple.first (t) ++ "=" ++ Tuple.second (t)) params)
    in
        model.searchPath ++ "?" ++ toQueryString (queryParams)


processSearch : Result Http.Error SearchResults -> Msg
processSearch result =
    case result of
        Ok newResults ->
            FetchSucceed newResults

        Err e ->
            FetchFail e


execSearch : String -> Cmd Msg
execSearch path =
    let
        request =
            Http.get path jsonDec
    in
        Task.attempt processSearch (Http.toTask request)



-- Our custom JSON Decoders


jsonDec : Json.Decoder SearchResults
jsonDec =
    field "results" searchResultsDec


searchResultsDec : Json.Decoder SearchResults
searchResultsDec =
    Json.map2 SearchResults
        (field "profiles" (Json.list profileDec))
        (field "pageInfo" pageInfoDec)


pageInfoDec : Json.Decoder PageInfo
pageInfoDec =
    Json.map3 PageInfo
        (field "prevPage" Json.int)
        (field "nextPage" Json.int)
        (field "activated" Json.bool)


profileDec : Json.Decoder Profile
profileDec =
    Json.map8 Profile
        (field "id" Json.int)
        (field "fullname" Json.string)
        (field "title" Json.string)
        (field "position" Json.string)
        (field "company" Json.string)
        (field "skills" (Json.list skillsDec))
        (field "created_at" Json.string)
        (field "updated_at" Json.string)


skillsDec : Json.Decoder Skill
skillsDec =
    Json.map Skill (field "name" Json.string)
