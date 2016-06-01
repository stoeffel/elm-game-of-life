module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Time exposing (Time, second)
import Model exposing (Model, init)
import Update exposing (update, Msg(Tick))
import View exposing (view)


subscriptions : Model -> Sub Msg
subscriptions { started } =
    if started then
        Time.every (second / 2) Tick
    else
        Sub.none


main =
    App.program
        { init = ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
