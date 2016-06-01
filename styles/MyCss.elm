module MyCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)


type CssClasses
    = Canvas


css =
    (stylesheet << namespace "game-of-life")
        [ body
            [ height (pct 100)
            , backgroundColor (hex "bababa")
            ]
        , (.) Canvas
            [ backgroundColor (hex "fefefe")
            , border3 (px 1) solid (hex "bababa")
            , margin (px 5)
            ]
        , button
            [ height (em 2)
            , width (em 5)
            , backgroundColor (hex "bababa")
            , color (hex "efefef")
            , fontSize (em 1.5)
            , border (px 0)
            , margin (px 5)
            ]
        ]
