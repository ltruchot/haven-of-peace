module DesignSystem.Header exposing (appHeader)

import Css
import Html.Styled as Html exposing (div, h1, header, img, text)
import Html.Styled.Attributes as Attr exposing (css, src)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw


appHeader =
    header
        [ css
            [ Tw.fixed
            , Tw.inset_x_0
            , Tw.top_0
            , Tw.z_50
            , Tw.flex
            , Tw.h_14
            , Tw.items_center
            , Tw.gap_2
            , Tw.px_4
            , Tw.transition
            , Tw.bg_color TwTheme.zinc_900
            , Tw.bg_opacity_20
            , Css.property "backdrop-filter" "blur(8px)"
            ]
        ]
        [ -- 1px line on bottom of header
          div
            [ css
                [ Tw.absolute
                , Tw.inset_x_0
                , Tw.top_full
                , Tw.h_px
                , Tw.transition
                , Tw.bg_color TwTheme.white
                , Tw.opacity_25
                ]
            ]
            []
        , img [ css [ Tw.h_10 ], src "/logo-hd2.png" ] []

        -- title near the logo
        , h1 [ css [ Tw.text_color TwTheme.white, Tw.text_lg, Tw.font_bold ] ] [ text "Heaven of Peace" ]
        ]
