module Routing exposing (..)

import String
import Navigation
import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = SearchRoute
    | NewProfileRoute
    | ProfileRoute Int
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map SearchRoute (s "")
        , map ProfileRoute (s "profiles" </> int)
        , map NewProfileRoute (s "newprofile")
        ]

parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route
    Nothing ->
      NotFoundRoute
