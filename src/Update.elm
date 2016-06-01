module Update exposing (update, Msg(..))

import Model exposing (init, Model, Cell, clickToPosition)
import Time exposing (Time)
import List.Extra
import Mouse exposing (Position)


type Msg
    = Tick Time
    | Add Cell
    | Remove Cell
    | TogglePlaying
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        updatePopulation pop =
            { model
                | population = pop
            }
    in
        case msg of
            Tick _ ->
                let
                    newPopulation =
                        nextPopulation model.population
                in
                    updatePopulation newPopulation
                        ! [ Cmd.none ]

            Add position ->
                let
                    newCell =
                        clickToPosition position

                    newPopulation =
                        newCell :: model.population
                in
                    updatePopulation newPopulation
                        ! [ Cmd.none ]

            Remove cell ->
                let
                    newPopulation =
                        List.filter ((/=) cell) model.population
                in
                    updatePopulation newPopulation
                        ! [ Cmd.none ]

            TogglePlaying ->
                { model | started = not model.started }
                    ! [ Cmd.none ]

            Reset ->
                init ! [ Cmd.none ]


nextPopulation : List Cell -> List Cell
nextPopulation population =
    population
        |> neighbours
        |> neighboursCount
        |> List.Extra.dropDuplicates
        |> List.filterMap (deadOrAlive population)


deadOrAlive : List Cell -> ( Cell, Int ) -> Maybe Cell
deadOrAlive population ( cell, count ) =
    if List.member cell population && count == 2 || count == 3 then
        Just cell
    else
        Nothing


neighboursCount : List Cell -> List ( Cell, Int )
neighboursCount population =
    List.map (countAppearance population) population


countAppearance : List Cell -> Cell -> ( Cell, Int )
countAppearance population cell =
    population
        |> List.filter ((==) cell)
        |> List.length
        |> (,) cell


neighbours : List Cell -> List Cell
neighbours population =
    let
        cellNeighbours ( x, y ) =
            [ ( x - 1, y )
            , ( x + 1, y )
            , ( x, y - 1 )
            , ( x, y + 1 )
            , ( x - 1, y - 1 )
            , ( x + 1, y + 1 )
            , ( x - 1, y + 1 )
            , ( x + 1, y - 1 )
            ]
    in
        List.concatMap cellNeighbours population
