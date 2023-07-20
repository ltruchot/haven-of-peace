module Evergreen.V3.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V3.DesignSystem.CheckableList
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    , setupListCheckedIndexes : Evergreen.V3.DesignSystem.CheckableList.State
    , developmentListCheckedIndexes : Evergreen.V3.DesignSystem.CheckableList.State
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NewGameClicked
    | SetupListChanged Evergreen.V3.DesignSystem.CheckableList.State
    | DevelopmentListChanged Evergreen.V3.DesignSystem.CheckableList.State
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
