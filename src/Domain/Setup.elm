module Domain.Setup exposing (getCallOfAdventurePlace, getDiceNumberToPick, getInitiatives, getMarketLayout, getMarketRiverNumber, getPlayerNumber, getStartGold)

import DesignSystem.Select as Select
import Types exposing (FrontendModel)
import Utils.Number exposing (increment)


getPlayerNumber : FrontendModel -> Int
getPlayerNumber model =
    (increment << Select.getValue) model.playerNumberFewerIndex


getStartGold : FrontendModel -> String
getStartGold model =
    case getPlayerNumber model of
        3 ->
            "J-1 et J-2 obtienne 3PO, J-3 obtient 4PO"

        4 ->
            "J-1 et J-2 obtienne 3PO, J-3 obtient 4PO, J-4 obtient 5PO"

        5 ->
            "5PO pour chaque joueur"

        _ ->
            "3PO pour chaque joueur"


getMarketLayout : FrontendModel -> String
getMarketLayout model =
    case getPlayerNumber model of
        4 ->
            "35"

        5 ->
            "30"

        _ ->
            "40"


getMarketRiverNumber : FrontendModel -> String
getMarketRiverNumber model =
    case getPlayerNumber model of
        3 ->
            "5"

        4 ->
            "6"

        5 ->
            "7"

        _ ->
            "4"


getCallOfAdventurePlace : FrontendModel -> String
getCallOfAdventurePlace model =
    case getPlayerNumber model of
        3 ->
            "23"

        4 ->
            "33"

        5 ->
            "38"

        _ ->
            "15"


getInitiatives : FrontendModel -> String
getInitiatives model =
    case getPlayerNumber model of
        3 ->
            "1, 2, 3 et flèches montantes"

        4 ->
            "1, 2, 3, 4 et flèches montantes"

        5 ->
            "1, 2, 3, 4, 5 et flèches montantes"

        _ ->
            "1, 2 et flèches montantes"


getDiceNumberToPick : FrontendModel -> String
getDiceNumberToPick model =
    case getPlayerNumber model of
        3 ->
            "8/4"

        4 ->
            "10/5"

        5 ->
            "12/6"

        _ ->
            "4/2"
