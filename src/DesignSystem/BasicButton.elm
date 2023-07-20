module DesignSystem.BasicButton exposing (basicButton)

import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw
import Types exposing (FrontendMsg)


basicButton : List (Html.Attribute FrontendMsg) -> List (Html.Html FrontendMsg) -> Html.Html FrontendMsg
basicButton attrs =
    let
        twCss =
            [ Tw.bg_color TwTheme.teal_400, Tw.text_color TwTheme.white, Tw.p_2, Tw.rounded ]
    in
    Html.button (List.concat [ [ Attr.css twCss ], attrs ])
