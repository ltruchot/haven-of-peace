module DesignSystem.CheckableList exposing (State, checkableList, init, getValue)

import Css
import Html.Styled as Html exposing (div, fieldset, input, label, legend, li, ol, strong, text)
import Html.Styled.Attributes as Attr exposing (css, src)
import Html.Styled.Events as Evt
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw
import Html.Styled.Events.Extra exposing (onClickPreventDefaultAndStopPropagation)



type State
    = State (List Int)


type Msg
    = ItemClicked Int

getValue : State -> List Int
getValue (State value) =
    value


init : State
init =
    State []


update : Msg -> List Int -> List Int
update msg value =
    case msg of
        ItemClicked idx ->
            if List.member idx value then List.filter (\i -> i /= idx) value else List.concat [ value, [ idx ]]


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
        , onClickPreventDefaultAndStopPropagation (toMsg (State (update (ItemClicked idx)value)))
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
                , css
                    [ Tw.h_4
                    , Tw.w_4
                    , Tw.rounded
                    , Tw.border_color TwTheme.gray_300
                    , Tw.text_color TwTheme.indigo_600
                    , Css.focus
                        [ Tw.ring_color TwTheme.indigo_600
                        ]
                    ]
                ]
                []
            ]
        ]


checkableList : (State -> msg) -> State -> String -> List String -> Html.Html msg
checkableList toMsg (State value) title items =
    fieldset [ css [ Tw.mb_8 ] ]
        [ legend
            [ css
                [ Tw.text_base
                , Tw.font_semibold
                , Tw.leading_6
                , Tw.text_color TwTheme.gray_200
                ]
            ]
            [ text title ]
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
