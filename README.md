# Project: in (DECLASSIFIED)

## Setup (Mac)

### Rails

1. install brew (http://brew.sh/)
2. `brew install rbenv`
3. `rbenv install`
4. `gem install bundler`
5. `git clone https://github.com/fuentesjr/in.git`
6. `cd in`

### Puma
7. sudo xcodebuild -license (accept license)
8. brew install openssl (install ssl libs)

That should get you up and running, to run your local server run `rails s` in your terminal, with default settings that will let you access your app at `localhost:3000`

## Mission Objective
This is a simple application that scrapes and parses LinkedIn profiles, stores results in a structured manner in a persistent layer and allows searching on the stored results.

### Backend service
Implements a RESTful API containing 3 endpoints:
* Adding a public LinkedIn profile
* Searching for people that were previously added
* Searching for skills and viewing associated people

The service extracts the following fields from the public profile:
* Name of the person
* Current title
* Current position
* List of skills

### UI
The UI allows users to:
* submit new profiles by passing in a LinkedIn profile URL
* submit searches (utilizing the service searching capabilities described above). Searches should either be by person name or by skill.

## Notes
The application is built with high-volume in mind:
* Several users will be adding profiles for parsing concurrently
* The persistence layer may eventually contain millions of results. Searching through the results still needs to be effective.

## Implementation details
* Uses Postgres as the primary persistence layer (aka database)
* Uses Bootstrap UI/CSS framework for styling
* Uses Elm and [The Elm Architecture](https://guide.elm-lang.org/architecture/) for the Front-End
* Uses JSON as the data exchange format between the client and the API service
* Uses Minitest for testing
