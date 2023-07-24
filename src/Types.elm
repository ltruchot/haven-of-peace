module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import DesignSystem.CheckableList as CheckableList
import DesignSystem.Select as Select
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , message : String
    , playerNumberFewerIndex : Select.State
    , setupListCheckedIndexes : CheckableList.State
    , developmentListCheckedIndexes : CheckableList.State
    , activityListCheckedIndexes : CheckableList.State
    , monsterListCheckedIndexes : CheckableList.State
    , scoringListCheckedIndexes : CheckableList.State
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NewGameClicked
    | PlayerNumberChanged Select.State
    | SetupListChanged CheckableList.State
    | DevelopmentListChanged CheckableList.State
    | ActivityListChanged CheckableList.State
    | MonsterListChanged CheckableList.State
    | ScoringListChanged CheckableList.State
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
