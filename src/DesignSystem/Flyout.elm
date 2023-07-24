module DesignSystem.Flyout exposing (flyout)

import Css
import Html.Styled as Html exposing (button, div, text)
import Html.Styled.Attributes as Attr exposing (css)
import Html.Styled.Events as Evt
import Html.Styled.Events.Extra exposing (onClickPreventDefaultAndStopPropagation, onClickStopPropagation)
import Svg.Styled as Svg exposing (path, svg)
import Svg.Styled.Attributes as SvgAttr
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw


flyout =
    div
        [ css
            [ Tw.relative
            , Tw.isolate
            , Tw.z_50
            , Tw.shadow
            ]
        ]
        [ div
            [ css
                [ Tw.bg_color TwTheme.white
                , Tw.py_5
                ]
            ]
            [ div
                [ css
                    [ Tw.mx_auto
                    , Tw.max_w_7xl
                    , Tw.px_6
                    , Bp.lg
                        [ Tw.px_8
                        ]
                    ]
                ]
                [ button
                    [ Attr.type_ "button"
                    , css
                        [ Tw.inline_flex
                        , Tw.items_center
                        , Tw.gap_x_1
                        , Tw.text_sm
                        , Tw.font_semibold
                        , Tw.leading_6

                        --, Tw.text_color TwTheme.gray_900
                        ]
                    , Attr.attribute "aria-expanded" "false"
                    ]
                    [ text "Solutions"
                    , svg
                        [ SvgAttr.css
                            [ Tw.h_5
                            , Tw.w_5
                            ]
                        , SvgAttr.viewBox "0 0 20 20"
                        , SvgAttr.fill "currentColor"
                        , Attr.attribute "aria-hidden" "true"
                        ]
                        [ path
                            [ SvgAttr.fillRule "evenodd"
                            , SvgAttr.d "M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z"
                            , SvgAttr.clipRule "evenodd"
                            ]
                            []
                        ]
                    ]
                ]
            ]
        , {-
             'Product' flyout menu, show/hide based on flyout menu state.

             Entering: "transition ease-out duration-200"
               From: "opacity-0 -translate-y-1"
               To: "opacity-100 translate-y-0"
             Leaving: "transition ease-in duration-150"
               From: "opacity-100 translate-y-0"
               To: "opacity-0 -translate-y-1"
          -}
          div
            [ css
                [ Tw.absolute
                , Tw.inset_x_0
                , Tw.top_0
                , Tw.neg_z_10
                , Tw.bg_color TwTheme.white
                , Tw.pt_16
                , Tw.shadow_lg
                , Tw.ring_1

                -- , Tw.ring_color TwTheme.gray_900over5
                ]
            ]
            [ div
                [ css
                    [ Tw.mx_auto
                    , Tw.grid
                    , Tw.max_w_7xl
                    , Tw.grid_cols_1
                    , Tw.gap_2
                    , Tw.px_6
                    , Tw.py_6
                    , Bp.lg
                        [ Tw.grid_cols_4
                        , Tw.gap_4
                        , Tw.px_8
                        ]
                    , Bp.sm
                        [ Tw.grid_cols_2
                        , Tw.gap_x_6
                        , Tw.gap_y_0
                        , Tw.py_10
                        ]
                    , Bp.xl
                        [ Tw.gap_8
                        ]
                    ]
                ]
                [ text "toto" ]
            ]
        ]
