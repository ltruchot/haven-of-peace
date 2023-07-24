module Evergreen.V6.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V6.DesignSystem.CheckableList
import Evergreen.V6.DesignSystem.Select
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    , playerNumberFewerIndex : Evergreen.V6.DesignSystem.Select.State
    , setupListCheckedIndexes : Evergreen.V6.DesignSystem.CheckableList.State
    , developmentListCheckedIndexes : Evergreen.V6.DesignSystem.CheckableList.State
    , activityListCheckedIndexes : Evergreen.V6.DesignSystem.CheckableList.State
    , monsterListCheckedIndexes : Evergreen.V6.DesignSystem.CheckableList.State
    , scoringListCheckedIndexes : Evergreen.V6.DesignSystem.CheckableList.State
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NewGameClicked
    | PlayerNumberChanged Evergreen.V6.DesignSystem.Select.State
    | SetupListChanged Evergreen.V6.DesignSystem.CheckableList.State
    | DevelopmentListChanged Evergreen.V6.DesignSystem.CheckableList.State
    | ActivityListChanged Evergreen.V6.DesignSystem.CheckableList.State
    | MonsterListChanged Evergreen.V6.DesignSystem.CheckableList.State
    | ScoringListChanged Evergreen.V6.DesignSystem.CheckableList.State
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
