module Models exposing (..)


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
