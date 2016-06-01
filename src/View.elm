module View exposing (view)

import Html exposing (Html, div, button)
import Html.Events as E
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Model exposing (Model, Cell, positionToString)
import Update exposing (Msg(..))
import Json.Decode exposing (andThen, succeed, object2, int, (:=))
import Html.CssHelpers
import MyCss


{ class } =
    Html.CssHelpers.withNamespace "game-of-life"
view : Model -> Html Msg
view model =
    let
        buttonText =
            if model.started then
                "stop"
            else
                "start"
    in
        div []
            [ div []
                [ button [ E.onClick Reset ] [ text "reset" ]
                , button [ E.onClick TogglePlaying ] [ text buttonText ]
                ]
            , div []
                [ world model.started <| List.map cell model.population
                ]
            ]


offsetPosition : Json.Decode.Decoder Cell
offsetPosition =
    object2 (,)
        ("offsetX" := int)
        ("offsetY" := int)


world : Bool -> List (Html Msg) -> Html Msg
world started population =
    let
        clickHandler =
            if started then
                []
            else
                [ E.on "click" <| offsetPosition `andThen` (Add >> succeed) ]
    in
        div [ class [ MyCss.Canvas ] ]
            [ svg
                (clickHandler
                    ++ [ viewBox "0 0 60 60"
                       , width "600px"
                       ]
                )
                population
            ]


cell : Cell -> Html Msg
cell model =
    let
        ( cellX, cellY ) =
            positionToString model
    in
        rect
            [ fill "black"
            , x cellX
            , y cellY
            , width "1"
            , height "1"
            , E.onWithOptions "click"
                { stopPropagation = True
                , preventDefault = True
                }
                <| succeed (Remove model)
            ]
            []
