module Evergreen.Migrate.V3 exposing (..)

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

import Evergreen.V1.Types
import Evergreen.V3.DesignSystem.CheckableList
import Evergreen.V3.Types
import Lamdera.Migrations exposing (..)


frontendModel : Evergreen.V1.Types.FrontendModel -> ModelMigration Evergreen.V3.Types.FrontendModel Evergreen.V3.Types.FrontendMsg
frontendModel old =
    ModelMigrated ( migrate_Types_FrontendModel old, Cmd.none )


backendModel : Evergreen.V1.Types.BackendModel -> ModelMigration Evergreen.V3.Types.BackendModel Evergreen.V3.Types.BackendMsg
backendModel old =
    ModelUnchanged


frontendMsg : Evergreen.V1.Types.FrontendMsg -> MsgMigration Evergreen.V3.Types.FrontendMsg Evergreen.V3.Types.FrontendMsg
frontendMsg old =
    MsgMigrated ( migrate_Types_FrontendMsg old, Cmd.none )


toBackend : Evergreen.V1.Types.ToBackend -> MsgMigration Evergreen.V3.Types.ToBackend Evergreen.V3.Types.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Evergreen.V1.Types.BackendMsg -> MsgMigration Evergreen.V3.Types.BackendMsg Evergreen.V3.Types.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Evergreen.V1.Types.ToFrontend -> MsgMigration Evergreen.V3.Types.ToFrontend Evergreen.V3.Types.FrontendMsg
toFrontend old =
    MsgUnchanged


listCheckedIndexesInit : Evergreen.V3.DesignSystem.CheckableList.State
listCheckedIndexesInit =
    Evergreen.V3.DesignSystem.CheckableList.State []


migrate_Types_FrontendModel : Evergreen.V1.Types.FrontendModel -> Evergreen.V3.Types.FrontendModel
migrate_Types_FrontendModel old =
    { key = old.key
    , message = old.message
    , setupListCheckedIndexes = (listCheckedIndexesInit {- Type `Evergreen.V3.DesignSystem.CheckableList.State` was added in V3. I need you to set a default value. -})
    , developmentListCheckedIndexes = (listCheckedIndexesInit {- Type `Evergreen.V3.DesignSystem.CheckableList.State` was added in V3. I need you to set a default value. -})
    , activityListCheckedIndexes = (listCheckedIndexesInit {- Type `Evergreen.V3.DesignSystem.CheckableList.State` was added in V3. I need you to set a default value. -})
    }


migrate_Types_FrontendMsg : Evergreen.V1.Types.FrontendMsg -> Evergreen.V3.Types.FrontendMsg
migrate_Types_FrontendMsg old =
    case old of
        Evergreen.V1.Types.UrlClicked p0 ->
            Evergreen.V3.Types.UrlClicked p0

        Evergreen.V1.Types.UrlChanged p0 ->
            Evergreen.V3.Types.UrlChanged p0

        Evergreen.V1.Types.NewGameClicked ->
            Evergreen.V3.Types.NewGameClicked

        Evergreen.V1.Types.NoOpFrontendMsg ->
            Evergreen.V3.Types.NoOpFrontendMsg
