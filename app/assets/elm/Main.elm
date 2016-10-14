module Main exposing (..)

import Html.App as App
import Html exposing (Html, text, button, form, div, input, hr, label, a, p)
import Html.Attributes exposing (class, type', value, name, id, checked, style)
import Html.Events exposing (onClick, onInput)
import Http
import Task
import Json.Decode as Json exposing ((:=))


main =
    App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Profile =
    { id : Int
    , fullname : String
    , title : String
    , position : String
    , company : String
    , skills : List Skill
    , created_at : String
    , updated_at : String
    }


type alias Skill =
    { name : String }


type alias Model =
    { searchQuery : String
    , searchPath : String
    , searchField : String
    , searchResults : List Profile
    }


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )



-- UPDATE


type Msg
    = SetSearchField String
    | FetchSucceed (List Profile)
    | FetchFail Http.Error
    | Search
    | UpdateSearchQuery String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetSearchField srchfld ->
            ( { model | searchField = srchfld }, Cmd.none )

        UpdateSearchQuery val ->
            ( { model | searchQuery = val }, Cmd.none )

        Search ->
            ( model, execSearch (buildFullPath model) )

        FetchSucceed data ->
            ( { model | searchResults = (Debug.log "data" data) }, Cmd.none )

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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ radio "By Fullname" (SetSearchField "fullname")
            , radio "By Skills" (SetSearchField "skills")
            ]
        , div [ class "form-search" ]
            [ input
                [ onInput UpdateSearchQuery
                , value model.searchQuery
                , type' "text"
                , class "input-medium search-query"
                ]
                []
            , button [ onClick Search, class "btn btn-info", style [ ( "margin", "0 2px" ) ] ] [ text "Search" ]
            , p
                [ style [ ( "margin-top", "15px" ) ] ]
                [ a [] [ text "Add New Profile" ] ]
            , hr [] []
            , div [ class "serach-results" ] (List.map renderProfile model.searchResults)
            ]
        ]


radio : String -> msg -> Html msg
radio value msg =
    label
        [ style [ ( "padding", "20px" ) ] ]
        [ input [ style [ ( "margin", "4px 6px" ) ], type' "radio", name "search-type", onClick msg ] []
        , text value
        ]


renderProfile profile =
    p []
        [ a [] [ text profile.fullname ]
        ]
