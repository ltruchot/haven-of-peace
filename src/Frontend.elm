module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Css.Global
import DesignSystem.BasicButton exposing (basicButton)
import DesignSystem.CardDashed exposing (cardDashed)
import DesignSystem.CheckableList as CheckableList
import DesignSystem.Header exposing (appHeader)
import DesignSystem.Hero exposing (hero)
import DesignSystem.Select as Select
import Domain.Setup exposing (getCallOfAdventurePlace, getDiceNumberToPick, getInitiatives, getMarketLayout, getMarketRiverNumber, getPlayerNumber, getStartGold)
import Html.Styled as Html exposing (toUnstyled)
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Evt
import Lamdera
import Random
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw exposing (globalStyles)
import Types exposing (..)
import UUID exposing (UUID)
import Url
import Utils.Number exposing (increment)


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , message = "Hello world"
      , playerNumberFewerIndex = Select.init
      , setupListCheckedIndexes = CheckableList.init
      , developmentListCheckedIndexes = CheckableList.init
      , activityListCheckedIndexes = CheckableList.init
      , monsterListCheckedIndexes = CheckableList.init
      , scoringListCheckedIndexes = CheckableList.init
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( model, Cmd.none )

        NewGameClicked ->
            let
                uuid =
                    Random.step UUID.generator (Random.initialSeed 9100)
                        |> Tuple.first
            in
            ( { model | message = UUID.toString uuid }, Cmd.none )

        PlayerNumberChanged state ->
            ( { model | playerNumberFewerIndex = state }
            , Cmd.none
            )

        SetupListChanged state ->
            ( { model | setupListCheckedIndexes = state }
            , Cmd.none
            )

        DevelopmentListChanged state ->
            ( { model | developmentListCheckedIndexes = state }
            , Cmd.none
            )

        ActivityListChanged state ->
            ( { model | activityListCheckedIndexes = state }
            , Cmd.none
            )

        MonsterListChanged state ->
            ( { model | monsterListCheckedIndexes = state }
            , Cmd.none
            )

        ScoringListChanged state ->
            ( { model | scoringListCheckedIndexes = state }
            , Cmd.none
            )

        NoOpFrontendMsg ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    let
        body =
            Html.div []
                [ Css.Global.global globalStyles
                , Html.div
                    [ Attr.css
                        [ Tw.bg_color TwTheme.zinc_900
                        , Tw.h_full
                        , Tw.py_24
                        , Tw.px_8
                        , Tw.antialiased
                        , Tw.relative
                        ]
                    ]
                    [ hero
                    , Html.div [ Attr.css [ Tw.w_full, Tw.relative ] ]
                        [ appHeader
                        , cardDashed
                            [ Evt.onClick NewGameClicked
                            , Attr.css [ Tw.mb_8, Tw.text_xl, Tw.relative ]
                            ]
                            [ Html.div [ Attr.css [ Tw.mb_4 ] ] [ Html.text "Roll Player (version intégrale)" ]
                            , Html.img [ Attr.src "/roll-player-full.jpg", Attr.css [ Tw.w_64 ] ] []
                            , Select.appSelect PlayerNumberChanged
                                model.playerNumberFewerIndex
                                "Nombre de joueurs"
                                [ "1 joueur", "2 joueurs", "3 joueurs", "4 joueurs", "5 joueurs" ]
                            ]
                        , CheckableList.checkableList SetupListChanged
                            model.setupListCheckedIndexes
                            "Mise en place simplifiée"
                            [ "Chaque Joueur lance un dé, le meilleur devient Joueur 1 (il reçoit le Pion Rouge J-1), les autres suivront dans le sens des aiguilles d'une montre pour la suite"
                            , "Chaque Joueur pioche 2 Personnages, en choisi 1, rend l'autre"
                            , "Chaque Joueur pioche 2 Familiers, en choisi 1, rend l'autre"
                            , "Chaque Joueur pioche un Marqueur de classe, prend les 3 cartes Classe de ce Marqueur et le second Marqueur, choisi le recto ou verso d'une des cartes, rends les autres"
                            , "Chaque Joueur reçoit 1 Antécédent + 1 Alignement; 1 Marqueur est placé sur l'Alignement, 1 Marqueur sur la Classe"
                            , "Chaque Joueur prend de l'or: " ++ getStartGold model
                            , "Chaque Joueur reçoit 1 Aide de Jeu + 1 résumé des coûts"
                            , "Le Marché est amputé de " ++ getMarketLayout model ++ " cartes lvl 1, assemblé en pioche (lvl 1 avant 2), puis l'Appel de l'Aventure (AdA) est placé après la " ++ getCallOfAdventurePlace model ++ "e carte"
                            , "Révéler les " ++ getMarketRiverNumber model ++ " premières cartes marché en ligne"
                            , "Placer les Initiatives " ++ getInitiatives model ++ ", en ligne, par ordre croissant"
                            , "Révéler 1 Monstre de la couleur d'un marqueur restant tiré au hasard"
                            , "Piocher 3 Aventures L/O/A de ce monstres, les placer face cachée près du monstre"
                            , "Les Sbires sont amputés de 18 cartes lvl 1 et sont assemblés en pioche (lvl 1 avant 2) - le premier sbire est retourné"
                            , "Chaque joueur pioche 6 dés et les places"
                            , "J-1 démarre le 1er tour"
                            ]
                        , CheckableList.checkableList DevelopmentListChanged
                            model.developmentListCheckedIndexes
                            "Phase de développement"
                            [ "J-1 pioche démons et place pièces pour chaque Initiative concernée"
                            , "J-1 pioche " ++ getDiceNumberToPick model ++ " dés (selon AdA), les lancent, les répartis sur Initiatives, en choisissant la place des dés de même valeur"
                            , "J-1 peut à tout moment engager ses Compétences restaurées si son alignement le permet (avec ou sans déclencher l'effet de la carte) bannir un démon (1 charisme ou 5PO, garder et retourner la carte), soigner une blessure (2XP), réaliser une AdC (5XP)"
                            , "J-1 choisi Initiative, place Marqueur dessus, obtient 1/2 dés et/ou pièce et/ou démon"
                            , "J-1 dispose 1/2 dé(s) sur Personnage, déclenche (ou non) UNE SEULE AdC"
                            , "Si une ligne est complétée, J-1 gagne 2PO"
                            , "J-2 démarre son tour, en sautant les étapes 1 et 2, et ainsi de suite"
                            ]
                        , CheckableList.checkableList ActivityListChanged
                            model.activityListCheckedIndexes
                            "Phase d'activité"
                            [ "Joueur ayant la plus basse Initiative (J-Init-1) joue en premier"
                            , "J-Init-1 peut à tout moment engager ses Compétences restaurées si son alignement le permet (avec ou sans déclencher l'effet de la carte),  bannir un démon (1 charisme ou 5PO, garder et retourner la carte), soigner une blessure (2XP), réaliser une AdC bonus (5XP)"
                            , "J-Init-1 peut acheter 1 carte Marché OU revendre une carte Marché (défaussée contre 2PO) OU faire 1 traque"
                            , "En cas d'achat, l'argent est dépensé en appliquant charisme, compétences et/ou bonus/malus"
                            , "En cas de traque, J-Init-1 peut renouveler autant de carte Sbires qu'il le souhaite, pour 3PO chacune"
                            , "En cas de traque, J-Init-1 reçoit 1 dé de combat + tous ses dés bonus (cartes sbire, objets...) + x dés mercenaires pour 3XP ou 5PO chacun"
                            , "En cas de traque, J-Init-1 peut relancer x dés au prix d'1XP par dé"
                            , "En cas de traque réussie, J-Init-1 reçoit sa récompense: récompense gagnée et si trophée: la carte est gardée + jeton aventure choisi, sinon carte renouvelée"
                            , "J-Init-1 défausse ses Charismes inutilisés"
                            , "J-Init-1 restaure 1 Compétence"
                            , "J-Init-2 commence sa phase d'activité, et ainsi de suite"
                            , "Une nouvelle phase de développement démarre"
                            , "Lorsque les joueurs ont placés leurs 21 dés, la phase de monstre démarre"
                            ]
                        , CheckableList.checkableList MonsterListChanged
                            model.monsterListCheckedIndexes
                            "Phase de monstre"
                            [ "Chaque joueur peu UNE DERNIÈRE FOIS engager ses Compétences restaurées si son alignement le permet (avec ou sans déclencher l'effet de la carte), bannir un démon (1 charisme ou 5PO, garder et retourner la carte), soigner une blessure (2XP), réaliser une AdC bonus (5XP)"
                            , "Chaque joueur place devant lui sa piste de réputation"
                            , "Chaque joueur reçoit 1 dé de combat"
                            , "Chaque joueur reçoit ses bonus de jetons L/O/A"
                            , "Chaque joueur peut acheter x dés mercenaires pour 3XP ou 5PO chacun"
                            , "J-1 jette ses dés, dépenses ses XP de relance, fait le total"
                            , "J-1 ajoute son honneur et déduit ses blessures du total"
                            , "J-1 note son score de combat, et note sa réputation sa piste de réputation"
                            , "J-2 fait de même, et ainsi de suite"
                            , "Un ou plusieurs joueurs ayant le meilleurs score de combat reçoivent le bonus de réputation et le reporte sur leur fiche de score"
                            ]
                        , CheckableList.checkableList ScoringListChanged
                            model.scoringListCheckedIndexes
                            "Phase de score"
                            [ "Chaque joueur garde devant lui sa piste de réputation sur 55, en conservant sa réputation du combat de monstre. On énonce chaque domaine de réputation et chaque joueur avance dans sa piste du nombre de points gagné"
                            , "Caractéristiques: FOR, DEX, CON, INT, SAG, CHA"
                            , "Classes: 1pts par dé de la couleur de sa classe"
                            , "Alignements: -3 à +3pts"
                            , "Antécédents: 0 à 6pts"
                            , "Armures: valeur par nombre de pièces d'armure + 1 pt par armure de votre classe"
                            , "Traits: calcul de la valeur donnée par les cartes de traits"
                            , "Familier: Correspondance de force, 0 à 2pts pour antécédents"
                            , "En fonction du total, les joueurs obtiennent les titres suivants: 55 = Dieu vivant, 47+ = Pourfendeur de monstre, 43-46 = Véritable Héros, 38-42 = Chef de Clan, 34-37 = Sommité, 29-33 = Aventurier, 25-28 = Mercenaire, <= 24 = PNJ"
                            , "Les joueurs qui le souhaitent peuvent \"sauvegarder\" leur personnage sur papier"
                            ]
                        ]
                    ]
                ]
    in
    { body = [ toUnstyled body ]
    , title = "Haven of peace"
    }
