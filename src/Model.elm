module Model exposing (Model, Cell, init, positionToString, clickToPosition)


type alias Cell =
    ( Int, Int )


type alias Model =
    { population : List Cell
    , started : Bool
    }


init : Model
init =
    { population =
        [ ( 29, 30 )
        , ( 30, 30 )
        , ( 31, 30 )
        ]
    , started = True
    }


positionToString : ( Int, Int ) -> ( String, String )
positionToString ( x, y ) =
    ( toString (x), toString (y) )


clickToPosition : ( Int, Int ) -> Cell
clickToPosition ( x, y ) =
    ( x // 10, y // 10 )
