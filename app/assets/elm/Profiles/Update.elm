module Profiles.Update exposing (..)

import Navigation
import Http
import Task
import Json.Decode as Json exposing ((:=))
import Profiles.Messages exposing (..)
import Profiles.Models exposing (Profile, Search, Skill)


update : Msg -> Search -> ( Search, Cmd Msg )
update msg model =
    case msg of
        SetSearchField srchfld ->
            ( { model | searchField = srchfld }, Cmd.none )

        UpdateSearchQuery val ->
            ( { model | searchQuery = val }, Cmd.none )

        NavToNewProfile ->
            ( model, Navigation.newUrl "#newprofile" )

        NavToSearch ->
            ( model, Navigation.newUrl "#" )

        Search ->
            ( model, execSearch (buildFullPath model) )

        FetchSucceed data ->
            ( { model | searchResults = data }, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )


buildFullPath model =
    model.searchPath
        ++ "?search_field="
        ++ model.searchField
        ++ "&query="
        ++ model.searchQuery


execSearch path =
    Task.perform FetchFail FetchSucceed (Http.get searchResultsDec path)


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


searchResultsDec : Json.Decoder (List Profile)
searchResultsDec =
    "results" := Json.list profileDec
