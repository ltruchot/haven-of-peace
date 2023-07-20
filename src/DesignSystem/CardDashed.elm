module DesignSystem.CardDashed exposing (cardDashed)

import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw
import Types exposing (FrontendMsg)


cardDashed : List (Html.Attribute FrontendMsg) -> List (Html.Html FrontendMsg) -> Html.Html FrontendMsg
cardDashed attrs =
    Html.div (List.concat [ [ Attr.css twCss ], attrs ])


twCss =
    [ Tw.border_4
    , Tw.border_dashed
    , Tw.border_color TwTheme.white
    , Tw.rounded_lg
    , Tw.border_opacity_50
    , Tw.p_4
    , Tw.text_center
    , Tw.text_color TwTheme.gray_300
    , Tw.flex
    , Tw.items_center
    , Tw.flex_col
    ]
