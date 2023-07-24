module DesignSystem.Select exposing (State, appSelect, getValue, init)

import Css
import Html.Styled as Html exposing (div, label, option, select, text)
import Html.Styled.Attributes as Attr exposing (css, src, value)
import Html.Styled.Events as Evt
import Html.Styled.Events.Extra exposing (onClickPreventDefaultAndStopPropagation, onClickStopPropagation)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw


type State
    = State Int


type Msg
    = ItemClicked Int


getValue : State -> Int
getValue (State val) =
    val


init : State
init =
    State 0


update : Msg -> Int -> Int
update msg val =
    case msg of
        ItemClicked idx ->
            idx


createSelectListItems : (State -> msg) -> State -> List String -> List (Html.Html msg)
createSelectListItems toMsg (State val) items =
    List.indexedMap (\idx item -> selectableListItem toMsg (State val) idx item) items


selectableListItem : (State -> msg) -> State -> Int -> String -> Html.Html msg
selectableListItem toMsg (State val) idx item =
    option [ 
        value (String.fromInt idx) 
        , Evt.onClick(toMsg (State (update (ItemClicked idx) val)))
        ]
        [ text item ]


appSelect : (State -> msg) -> State -> String -> List String -> Html.Html msg
appSelect toMsg (State val) title items =
    div []
        [ label
            [ Attr.for "location"
            , css
                [ Tw.block
                , Tw.text_sm
                , Tw.font_medium
                , Tw.leading_6
                , Tw.text_color TwTheme.gray_900
                ]
            ]
            [ text title ]
        , select
            [ Attr.id "location"
            , Attr.name "location"
            , css
                [ Tw.mt_2
                , Tw.block
                , Tw.w_full
                , Tw.rounded_md
                , Tw.border_0
                , Tw.py_1_dot_5
                , Tw.pl_3
                , Tw.pr_10
                , Tw.text_color TwTheme.gray_900
                , Tw.ring_1
                , Tw.ring_inset
                , Tw.ring_color TwTheme.gray_300
                , Css.focus
                    [ Tw.ring_2
                    , Tw.ring_color TwTheme.indigo_600
                    ]
                , Bp.sm
                    [ Tw.text_sm
                    , Tw.leading_6
                    ]
                ]
            ]
            (createSelectListItems toMsg (State val) items)
        ]