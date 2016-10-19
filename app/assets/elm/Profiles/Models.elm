module Profiles.Models exposing (..)


type alias Skill =
    { name : String }


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


type alias Search =
    { searchQuery : String
    , searchPath : String
    , searchField : String
    , searchResults : List Profile
    }
