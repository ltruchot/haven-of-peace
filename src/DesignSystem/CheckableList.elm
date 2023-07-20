module DesignSystem.CheckableList exposing (checkableList)

import Css
import Html.Styled as Html exposing (div, fieldset, input, label, legend, text, ol, li, strong)
import Html.Styled.Attributes as Attr exposing (css, src)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw


createCheckableListItems : List String -> List (Html.Html msg)
createCheckableListItems items =
    List.indexedMap (\idx item -> checkableListItem (String.fromInt (idx + 1)) item) items


checkableListItem : String -> String -> Html.Html msg
checkableListItem id item =
    li
        [ css
            [ Tw.relative
            , Tw.flex
            , Tw.items_start
            , Tw.py_4
            ]
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
                    [ Tw.select_none
                    , Tw.font_medium
                    , Tw.text_color TwTheme.gray_300
                    ]
                ]
                [ strong [] [text (id ++ ". ")], text item ]
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


checkableList : String -> List String -> Html.Html msg
checkableList title items =
    fieldset [ css [Tw.mb_8]]
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
            (createCheckableListItems items)
        ]
