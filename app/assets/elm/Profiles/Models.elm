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


type alias PageInfo =
    { prevPage : Int
    , nextPage : Int
    , activated : Bool
    }


type alias SearchResults =
    { profiles : List Profile
    , pageInfo : PageInfo
    }


type alias Search =
    { searchQuery : String
    , searchPath : String
    , searchField : String
    , searchResults : SearchResults
    , scrapeUrl : String
    }


blankProfile : Profile
blankProfile =
    { id = 0
    , fullname = ""
    , title = ""
    , position = ""
    , company = ""
    , skills = []
    , created_at = ""
    , updated_at = ""
    }
