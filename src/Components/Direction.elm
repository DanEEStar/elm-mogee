module Components.Direction
    exposing
        ( Direction(..)
        , opposite
        , next
        )

import Random exposing (Generator)


type Direction
    = Left
    | Right
    | Top
    | Bottom


possibleDirections : List Direction
possibleDirections =
    [ Right
    , Top
    , Bottom
    ]


opposite : Direction -> Direction
opposite dir =
    case dir of
        Left ->
            Right

        Right ->
            Left

        Top ->
            Bottom

        Bottom ->
            Top


next : Direction -> Generator Direction
next direction =
    pickRandom
        (List.filter ((/=) (opposite direction)) possibleDirections)
        direction


{-| generate random element from the list
-}
pickRandom : List a -> a -> Random.Generator a
pickRandom list default =
    Random.map
        (\index -> Maybe.withDefault default (List.head (List.drop index list)))
        (Random.int 0 (List.length list - 1))
