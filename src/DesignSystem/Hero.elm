module DesignSystem.Hero exposing (hero)
import Css 
import Svg.Styled as Svg exposing (svg, path)
import Svg.Styled.Attributes as SvgAttr
import Html.Styled as Html exposing (div)
import Html.Styled.Attributes as Attr exposing (css)
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw
import Tailwind.Breakpoints as Bp


hero = div
        [ css
            [ Tw.absolute
            , Tw.inset_0
            , Css.property "inset" "0"
            , Tw.mx_0
            , Tw.max_w_none
            , Tw.overflow_hidden
            ]
        ]
        [ div
            [ css
                [ Tw.absolute
                , Tw.left_1over2
                , Tw.top_0
                , Css.property "margin-left" "-38rem"
                , Css.property "height" "25rem"
                , Css.property "width" "81.25rem"
                , Css.property "-mask-image" "linear-gradient(#fff,transparent)"
                ]
            ]
            [ div
                [ css
                    [ Tw.absolute
                    , Css.property "mask-image" "radial-gradient(farthest-side at top,#fff,transparent)"
                    , Css.property "--tw-gradient-from-position" " "
                    , Css.property "--tw-gradient-to-position" " "
                    , Css.property "--tw-gradient-from" "rgba(54,180,159,.3) var(--tw-gradient-from-position)"
                    , Css.property "--tw-gradient-to" "rgba(219,255,117,.3) var(--tw-gradient-to-position) var(--tw-gradient-from-position);"
                    , Css.property "--tw-gradient-stops" "var(--tw-gradient-from),var(--tw-gradient-to)"
                    , Css.property "background-image" "linear-gradient(var(--tw-gradient-stops))"
                    , Tw.opacity_100
                    , Css.property "inset" "0"
                  
                    ]
                ]
                [ svg
                    [ Attr.attribute "aria-hidden" "true"
                    , SvgAttr.css
                        [ Tw.absolute
                        , Css.property "top" "-50%"
                        , Css.property "bottom" "-50%"
                        , Css.property "height" "200%"
                        , Tw.w_full
                        , Css.property "transform" "translate(var(--tw-translate-x),var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(-18deg) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y))"

                        , Tw.mix_blend_overlay
                        , Css.property "stroke" "hsla(0,0%,100%,.05)"
                        , Css.property "fill" "hsla(0,0%,100%,.025)"
                        ]
                    ]
                    [ Svg.defs []
                        [ Svg.pattern
                            [ SvgAttr.id ":R11d6:"
                            , SvgAttr.width "72"
                            , SvgAttr.height "56"
                            , SvgAttr.patternUnits "userSpaceOnUse"
                            , SvgAttr.x "-12"
                            , SvgAttr.y "4"
                            ]
                            [ path
                                [ SvgAttr.d "M.5 56V.5H72"
                                , SvgAttr.fill "none"
                                ]
                                []
                            ]
                        ]
                    , Svg.rect
                        [ SvgAttr.width "100%"
                        , SvgAttr.height "100%"
                        , SvgAttr.strokeWidth "0"
                        , SvgAttr.fill "url(#:R11d6:)"
                        ]
                        []
                    , svg
                        [ SvgAttr.x "-12"
                        , SvgAttr.y "4"
                        , SvgAttr.css
                            [ Tw.overflow_visible
                            ]
                        ]
                        [ Svg.rect
                            [ SvgAttr.strokeWidth "0"
                            , SvgAttr.width "73"
                            , SvgAttr.height "57"
                            , SvgAttr.x "288"
                            , SvgAttr.y "168"
                            ]
                            []
                        , Svg.rect
                            [ SvgAttr.strokeWidth "0"
                            , SvgAttr.width "73"
                            , SvgAttr.height "57"
                            , SvgAttr.x "144"
                            , SvgAttr.y "56"
                            ]
                            []
                        , Svg.rect
                            [ SvgAttr.strokeWidth "0"
                            , SvgAttr.width "73"
                            , SvgAttr.height "57"
                            , SvgAttr.x "504"
                            , SvgAttr.y "168"
                            ]
                            []
                        , Svg.rect
                            [ SvgAttr.strokeWidth "0"
                            , SvgAttr.width "73"
                            , SvgAttr.height "57"
                            , SvgAttr.x "720"
                            , SvgAttr.y "336"
                            ]
                            []
                        ]
                    ]
                ]
            , svg
                [ SvgAttr.viewBox "0 0 1113 440"
                , Attr.attribute "aria-hidden" "true"
                , SvgAttr.css
                    [ Tw.absolute
                    , Tw.left_1over2
                    , Tw.top_0
                    -- , Tw.ml_[_19rem]
                    ,Css.property "margin-left" "-19rem"
                        
                    --, Tw.w_[69_dot_5625rem]
                    , Css.property "width" "69.5625rem"
                    , Tw.fill_color TwTheme.white
                    -- , Tw.blur_[26px]
                    , Css.property "filter" "blur(26px)"
                    , Tw.hidden
                        
                    ]
                ]
                [ path
                    [ SvgAttr.d "M.016 439.5s-9.5-300 434-300S882.516 20 882.516 20V0h230.004v439.5H.016Z"
                    ]
                    []
                ]
            ]
        ]
