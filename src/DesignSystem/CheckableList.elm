module DesignSystem.CheckableList exposing (State(..), checkableList, getValue, init)

import Css
import Html.Styled as Html exposing (details, div, fieldset, input, label, legend, li, ol, strong, summary, text)
import Html.Styled.Attributes as Attr exposing (css, src)
import Html.Styled.Events as Evt
import Html.Styled.Events.Extra exposing (onClickPreventDefaultAndStopPropagation, onClickStopPropagation)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw


type State
    = State (List Int)


type Msg
    = GlobalClicked (List String)
    | ItemClicked Int


getValue : State -> List Int
getValue (State value) =
    value


init : State
init =
    State []


update : Msg -> List Int -> List Int
update msg value =
    case msg of
        GlobalClicked items ->
            if List.length items == List.length value then
                []

            else
                List.range 0 (List.length items - 1)

        ItemClicked idx ->
            if List.member idx value then
                List.filter (\i -> i /= idx) value

            else
                List.concat [ value, [ idx ] ]


checkableList : (State -> msg) -> State -> String -> List String -> Html.Html msg
checkableList toMsg (State value) title items =
    let
        isGlobalChecked =
            List.length value == List.length items
    in
    details [ css [ Tw.mb_12 ] ]
        [ summary
            [ css
                [ Tw.text_xl
                , Tw.font_semibold
                , Tw.text_color TwTheme.white
                , Tw.w_full
                , Tw.relative
                , Tw.list_outside
                ]
            ]
            [ legend
                [ css
                    [ Tw.text_xl
                    , Tw.font_semibold
                    , Tw.text_color TwTheme.white
                    , Tw.inline_block
                    ]
                ]
                [ text title ]
            , input
                [ Attr.type_ "checkbox"
                , Attr.checked isGlobalChecked
                , Evt.onClick (toMsg (State (update (GlobalClicked items) value)))
                , css
                    [ Tw.h_5
                    , Tw.w_5
                    , Tw.inline_block
                    , Tw.ml_auto
                    , Tw.rounded
                    , Tw.border_color TwTheme.gray_300
                    , Tw.accent_color TwTheme.emerald_400
                    , Tw.absolute
                    , Tw.right_0
                    , Tw.top_1over2
                    , Tw.neg_translate_y_1over2
                    , Css.focus
                        [ Tw.ring_color TwTheme.emerald_400
                        ]
                    ]
                ]
                []
            ]
        , div
            [ css
                [ Tw.flex
                , Tw.justify_between
                , Tw.items_center
                , Tw.mb_4
                ]
            ]
            []
        , ol
            [ css
                [ Tw.mt_4
                , Tw.divide_y
                , Tw.divide_color TwTheme.gray_200
                , Tw.border_b
                , Tw.border_t
                , Tw.border_color TwTheme.gray_200
                ]
            ]
            (createCheckableListItems toMsg (State value) items)
        ]


createCheckableListItems : (State -> msg) -> State -> List String -> List (Html.Html msg)
createCheckableListItems toMsg (State value) items =
    List.indexedMap (\idx item -> checkableListItem toMsg (State value) idx item) items


checkableListItem : (State -> msg) -> State -> Int -> String -> Html.Html msg
checkableListItem toMsg (State value) idx item =
    let
        id =
            String.fromInt (idx + 1)

        isChecked =
            List.member idx value

        lineThroughClassList =
            if isChecked then
                [ Tw.line_through ]

            else
                []
    in
    li
        [ css
            [ Tw.relative
            , Tw.flex
            , Tw.items_start
            , Tw.py_4
            , Tw.text_lg
            ]
        , onClickPreventDefaultAndStopPropagation (toMsg (State (update (ItemClicked idx) value)))
        ]
        [ div
            [ css
                [ Tw.min_w_0
                , Tw.flex_1
                , Tw.text_sm
                , Tw.leading_6
                ]
            ]
            [ label
                [ Attr.for ("item-" ++ id)
                , css
                    (List.concat
                        [ [ Tw.select_none
                          , Tw.font_medium
                          , Tw.text_color TwTheme.gray_300
                          , Tw.text_lg
                          ]
                        , lineThroughClassList
                        ]
                    )
                ]
                [ strong [] [ text (id ++ ". ") ], text item ]
            ]
        , div
            [ css
                [ Tw.ml_3
                , Tw.flex
                , Tw.h_6
                , Tw.items_center
                ]
            ]
            [ input
                [ Attr.id ("item-" ++ id)
                , Attr.name ("item-" ++ id)
                , Attr.type_ "checkbox"
                , Attr.checked isChecked
                , onClickStopPropagation (toMsg (State (update (ItemClicked idx) value)))
                , css
                    [ Tw.h_4
                    , Tw.w_4
                    , Tw.rounded
                    , Tw.border_color TwTheme.gray_300
                    , Tw.accent_color TwTheme.emerald_400
                    , Css.focus
                        [ Tw.ring_color TwTheme.emerald_400
                        ]
                    ]
                ]
                []
            ]
        ]
