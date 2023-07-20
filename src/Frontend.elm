module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Css.Global
import DesignSystem.BasicButton exposing (basicButton)
import DesignSystem.CardDashed exposing (cardDashed)
import DesignSystem.CheckableList as CheckableList
import DesignSystem.Header exposing (appHeader)
import DesignSystem.Hero exposing (hero)
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
      , setupListCheckedIndexes = CheckableList.init
      , developmentListCheckedIndexes = CheckableList.init
      , activityListCheckedIndexes = CheckableList.init
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
                    , Html.div [ Attr.css [ Tw.w_full ] ]
                        [ appHeader
                        , cardDashed [ Evt.onClick NewGameClicked, Attr.css [ Tw.mb_8, Tw.text_xl ] ] [ Html.text "Roll Player (version intégrale)", Html.img [ Attr.src "/roll-player-full.jpg" ] [] ]
                        , CheckableList.checkableList SetupListChanged
                            model.setupListCheckedIndexes
                            "Mise en place: 5 Joueurs (simplifiée)"
                            [ "Chaque Joueur lance un dé, le meilleur devient Joueur 1 (il reçoit le Pion Rouge J1), les autres sont 2, 3, 4, 5 dans le sens des aiguilles d'une montre. On respecte cet ordre pour les étapes suivantes"
                            , "Chaque Joueur pioche 2 Personnages, en choisi 1, rend l'autre"
                            , "Chaque Joueur pioche 2 Familiers, en choisi 1, rend l'autre"
                            , "Chaque Joueur pioche un Marqueur de classe, prend les 3 cartes Classe de ce Marqueur et le second Marqueur, choisi le recto ou verso d'1 carte, rends les autres"
                            , "Chaque Joueur reçoit 1 Antécédent + 1 Alignement; 1 Marqueur est placé sur l'Alignement, 1 Marqueur sur la Classe"
                            , "Chaque Joueur prend 5 PO"
                            , "Chaque Joueur reçoit 1 Aide de Jeu + 1 résumé des coûts"
                            , "Le Marché est est amputé de 30 cartes lvl 1, assemblé en pioche (lvl 1 avant 2), puis l'Appel de l'Aventure (AdA) est placé après la 38e carte"
                            , "Révéler les 7 premières cartes marché en ligne"
                            , "Placer 6 Initiatives en ligne"
                            , "Révéler 1 Monstre de la couleur du marqueur restant"
                            , "Piocher 3 Aventures L/O/A de ce monstres, les placer face cachée près du monstre"
                            , "Les Sbires sont amputés de 18 cartes lvl 1 et sont assemblés en pioche (lvl 1 avant 2) - le premier sbire est retourné"
                            , "Chaque joueur pioche 6 dés et les places"
                            , "Le joueur 1 démarre le 1er tour"
                            ]
                        , CheckableList.checkableList DevelopmentListChanged
                            model.developmentListCheckedIndexes
                            "Phase de développement"
                            [ 
                            "Joueur 1 (J-1) pioche démons et place pièces pour chaque Initiative concernée"
                            , "J-1 pioche 6/12 dés (selon AdA), les lancent, les répartis sur Initiatives, en choisissant la place des dés de même valeur"
                            , "J-1 peut à tout moment utiliser 1 ou + compétences si son alignement le permet (avec ou sans déclencher l'effet de la carte)"
                            , "J-1 peut à tout moment bannir un démon (1 charisme ou 5PO, garder et retourner la carte)"
                            , "J-1 choisi Initiative, place Marqueur dessus, dispose 1/2 dé(s) sur Personnage, déclenche ou non UNE SEULE action"
                            , "J-1 obtient pièce et/ou démon"
                            , "Joueur 2 démarre son tour, en sautant les étapes 1 et 2"
                            , "Ainsi de suite jusque Joueur 5"
                            ]
                        , CheckableList.checkableList ActivityListChanged
                            model.activityListCheckedIndexes
                            "Phase de marché"
                            ["Joueur ayant la plus basse Initiative (J-Init) joue en premier"
                            , "J-Init peut à tout moment utiliser 1 ou + compétences si son alignement le permet (avec ou sans déclencher l'effet de la carte)"
                            , "J-1 peut à tout moment bannir un démon (1 charisme ou 5PO, garder et retourner la carte)"
                            , "J-Init peut acheter 1 carte Marché OU revendre une carte Marché (défaussée contre 2PO) OU faire 1 traque"
                            , "En cas d'achat, l'argent est dépensé en appliquant charisme, compétences et/ou bonus/malus"
                            , "En cas de traque, J-Init peut renouveler autant de carte Sbires qu'il le souhaite, pour 3PO chacune"
                            , "En cas de traque, J-Init reçoit 1 dé de combat + tous ses dés bonus (cartes sbire, objets...) + x dés mercenaires pour 3XP ou 5PO chacun"
                            , "En cas de traque, J-Init peut relancer x dés au prix d'1XP par dé"
                            , "En cas de traque réussie, J-Init reçoit sa récompense: récompense gagnée et si trophée: la carte est gardée + jeton aventure choisi, sinon carte renouvelée"
                            , "Ainsi de suite jusque Joueur 5, par ordre d'Initiative"]
                        ]
                      
                    ]
                ]
    in
    { body = [ toUnstyled body ]
    , title = "Haven of peace"
    }
