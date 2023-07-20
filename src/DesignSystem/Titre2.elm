module DesignSystem.Titre2 exposing (titre2)

import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Tailwind.Theme as TwTheme
import Tailwind.Utilities as Tw
import Types exposing (FrontendMsg)


titre2 : List (Html.Attribute FrontendMsg) -> List (Html.Html FrontendMsg) -> Html.Html FrontendMsg
titre2 attrs =
    Html.h2 (List.concat [ [ Attr.css twCss ], attrs ])


twCss =
    [ Tw.mb_16
    , Tw.text_xl
    , Tw.font_semibold
    , Tw.text_color TwTheme.white
    ]
