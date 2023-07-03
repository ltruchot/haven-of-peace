module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Css.Global
import DesignSystem.BasicButton exposing (basicButton)
import DesignSystem.CardDashed exposing (cardDashed)
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
                        , Tw.h_screen
                        , Tw.p_24
                        , Tw.antialiased
                        , Tw.relative
                        ]
                    ]
                    [ hero, Html.div [ Attr.css [Tw.h_96, Tw.w_full] ] [] {-, cardDashed [ Evt.onClick NewGameClicked ] [ Html.text "New Games" ], Html.div [ Attr.css [ Tw.h_64]] [] -}
                    ]
     
                ]
    in
    { body = [ toUnstyled body ]
    , title = "Haven of peace"
    }
