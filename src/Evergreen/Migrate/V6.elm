module Evergreen.Migrate.V6 exposing (..)

{-| This migration file was automatically generated by the lamdera compiler.

It includes:

  - A migration for each of the 6 Lamdera core types that has changed
  - A function named `migrate_ModuleName_TypeName` for each changed/custom type

Expect to see:

  - `Unimplementеd` values as placeholders wherever I was unable to figure out a clear migration path for you
  - `@NOTICE` comments for things you should know about, i.e. new custom type constructors that won't get any
    value mappings from the old type by default

You can edit this file however you wish! It won't be generated again.

See <https://dashboard.lamdera.com/docs/evergreen> for more info.

-}

import Evergreen.V3.DesignSystem.CheckableList
import Evergreen.V3.Types
import Evergreen.V6.DesignSystem.CheckableList
import Evergreen.V6.DesignSystem.Select
import Evergreen.V6.Types
import Lamdera.Migrations exposing (..)


frontendModel : Evergreen.V3.Types.FrontendModel -> ModelMigration Evergreen.V6.Types.FrontendModel Evergreen.V6.Types.FrontendMsg
frontendModel old =
    ModelMigrated ( migrate_Types_FrontendModel old, Cmd.none )


backendModel : Evergreen.V3.Types.BackendModel -> ModelMigration Evergreen.V6.Types.BackendModel Evergreen.V6.Types.BackendMsg
backendModel old =
    ModelUnchanged


frontendMsg : Evergreen.V3.Types.FrontendMsg -> MsgMigration Evergreen.V6.Types.FrontendMsg Evergreen.V6.Types.FrontendMsg
frontendMsg old =
    MsgMigrated ( migrate_Types_FrontendMsg old, Cmd.none )


toBackend : Evergreen.V3.Types.ToBackend -> MsgMigration Evergreen.V6.Types.ToBackend Evergreen.V6.Types.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Evergreen.V3.Types.BackendMsg -> MsgMigration Evergreen.V6.Types.BackendMsg Evergreen.V6.Types.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Evergreen.V3.Types.ToFrontend -> MsgMigration Evergreen.V6.Types.ToFrontend Evergreen.V6.Types.FrontendMsg
toFrontend old =
    MsgUnchanged


listCheckedIndexesInit : Evergreen.V6.DesignSystem.CheckableList.State
listCheckedIndexesInit =
    Evergreen.V6.DesignSystem.CheckableList.State []


selectIndexInit : Evergreen.V6.DesignSystem.Select.State
selectIndexInit =
    Evergreen.V6.DesignSystem.Select.State 0


migrate_Types_FrontendModel : Evergreen.V3.Types.FrontendModel -> Evergreen.V6.Types.FrontendModel
migrate_Types_FrontendModel old =
    { key = old.key
    , message = old.message
    , playerNumberFewerIndex = selectIndexInit
    , setupListCheckedIndexes = old.setupListCheckedIndexes |> migrate_DesignSystem_CheckableList_State
    , developmentListCheckedIndexes = old.developmentListCheckedIndexes |> migrate_DesignSystem_CheckableList_State
    , activityListCheckedIndexes = old.activityListCheckedIndexes |> migrate_DesignSystem_CheckableList_State
    , monsterListCheckedIndexes = listCheckedIndexesInit
    , scoringListCheckedIndexes = listCheckedIndexesInit
    }


migrate_DesignSystem_CheckableList_State : Evergreen.V3.DesignSystem.CheckableList.State -> Evergreen.V6.DesignSystem.CheckableList.State
migrate_DesignSystem_CheckableList_State old =
    case old of
        Evergreen.V3.DesignSystem.CheckableList.State p0 ->
            Evergreen.V6.DesignSystem.CheckableList.State p0


migrate_Types_FrontendMsg : Evergreen.V3.Types.FrontendMsg -> Evergreen.V6.Types.FrontendMsg
migrate_Types_FrontendMsg old =
    case old of
        Evergreen.V3.Types.UrlClicked p0 ->
            Evergreen.V6.Types.UrlClicked p0

        Evergreen.V3.Types.UrlChanged p0 ->
            Evergreen.V6.Types.UrlChanged p0

        Evergreen.V3.Types.NewGameClicked ->
            Evergreen.V6.Types.NewGameClicked

        Evergreen.V3.Types.SetupListChanged p0 ->
            Evergreen.V6.Types.SetupListChanged (p0 |> migrate_DesignSystem_CheckableList_State)

        Evergreen.V3.Types.DevelopmentListChanged p0 ->
            Evergreen.V6.Types.DevelopmentListChanged (p0 |> migrate_DesignSystem_CheckableList_State)

        Evergreen.V3.Types.ActivityListChanged p0 ->
            Evergreen.V6.Types.ActivityListChanged (p0 |> migrate_DesignSystem_CheckableList_State)

        Evergreen.V3.Types.NoOpFrontendMsg ->
            Evergreen.V6.Types.NoOpFrontendMsg
