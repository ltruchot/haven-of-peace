module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import DesignSystem.CheckableList as CheckableList
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , message : String
    , setupListCheckedIndexes : CheckableList.State
    , developmentListCheckedIndexes : CheckableList.State
    , activityListCheckedIndexes : CheckableList.State
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NewGameClicked
    | SetupListChanged CheckableList.State
    | DevelopmentListChanged CheckableList.State
    | ActivityListChanged CheckableList.State
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
