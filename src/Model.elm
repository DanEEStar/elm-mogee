port module Model
    exposing
        ( Model
        , initial
        , update
        , GameState(..)
        )

import Components.Keys as Keys exposing (Keys, codes)
import Time exposing (Time)
import WebGL.Texture exposing (Texture, Error)
import Messages exposing (Msg(..))
import Systems.Systems as Systems exposing (Systems)
import Components.Components as Components exposing (Components)
import Components.Menu as Menu exposing (Menu)
import PageVisibility exposing (Visibility(..))
import Slides.Engine as Engine exposing (Engine)
import Slides.Slides as Slides
import Window exposing (Size)


type GameState
    = Paused Menu
    | Playing
    | Dead
    | Initial Menu


type alias Model =
    { systems : Systems
    , components : Components
    , state : GameState
    , lives : Int
    , score : Int
    , size : Size
    , padding : Int
    , sound : Bool
    , texture : Maybe Texture
    , sprite : Maybe Texture
    , font : Maybe Texture
    , keys : Keys
    , slides : Engine
    }


initial : Model
initial =
    { components = Components.initial
    , systems = Systems.initial
    , lives = 0
    , score = 0
    , state = Initial Menu.start
    , size = Size 0 0
    , padding = 0
    , sound = True
    , texture = Nothing
    , font = Nothing
    , sprite = Nothing
    , keys = Keys.initial
    , slides = Slides.initial
    }


{-| port for turning audio on/off
-}
port sound : Bool -> Cmd msg


{-| port for sending audio to play
-}
port play : String -> Cmd msg


{-| port for sending audio to stop
-}
port stop : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Resize size ->
            ( { model | size = size }
            , Cmd.none
            )

        Animate elapsed ->
            model
                |> animate elapsed
                |> animateKeys elapsed

        KeyChange pressed keyCode ->
            ( { model
                | keys = Keys.keyChange pressed keyCode model.keys
                , padding =
                    -- resize the vieport with `-` and `=`
                    case ( pressed, keyCode ) of
                        ( True, 189 ) ->
                            model.padding + 1

                        ( True, 187 ) ->
                            max 0 (model.padding - 1)

                        _ ->
                            model.padding
              }
            , Cmd.none
            )

        TextureLoaded texture ->
            ( { model | texture = Result.toMaybe texture }
            , Cmd.none
            )

        SpriteLoaded sprite ->
            ( { model | sprite = Result.toMaybe sprite }
            , Cmd.none
            )

        FontLoaded font ->
            ( { model | font = Result.toMaybe font }
            , Cmd.none
            )

        VisibilityChange Visible ->
            ( model, Cmd.none )

        VisibilityChange Hidden ->
            ( { model
                | state =
                    if model.state == Playing then
                        Paused Menu.paused
                    else
                        model.state
              }
            , Cmd.none
            )


animate : Time -> Model -> ( Model, Cmd Msg )
animate elapsed model =
    case model.state of
        Initial menu ->
            updateMenu elapsed Initial menu model

        Paused menu ->
            updateMenu elapsed Paused menu model

        Playing ->
            let
                limitElapsed =
                    min elapsed 60

                ( newComponents, newSystems, sound ) =
                    Systems.run
                        limitElapsed
                        (Keys.directions model.keys)
                        model.components
                        model.systems

                state =
                    if Keys.pressed codes.escape model.keys || Keys.pressed codes.q model.keys then
                        Paused Menu.paused
                    else
                        model.state

                ( newState, cmd ) =
                    checkLives
                        { model
                            | components = newComponents
                            , systems = newSystems
                            , state = state
                        }
            in
                ( newState
                , case sound of
                    Just snd ->
                        Cmd.batch [ cmd, play snd ]

                    Nothing ->
                        cmd
                )

        Dead ->
            if Keys.pressed codes.enter model.keys then
                if model.lives == 0 then
                    ( { model | state = Initial Menu.start }, Cmd.none )
                else
                    continue model
            else
                ( model, Cmd.none )


animateKeys : Time -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
animateKeys elapsed ( model, cmd ) =
    ( { model | keys = Keys.animate elapsed model.keys }
    , cmd
    )


checkLives : Model -> ( Model, Cmd Msg )
checkLives model =
    if Components.isDead model.components then
        ( { model
            | lives = model.lives - 1
            , state = Dead
          }
        , Cmd.batch [ play "death", stop "theme" ]
        )
    else
        ( model, Cmd.none )


continue : Model -> ( Model, Cmd Msg )
continue model =
    ( { model
        | state = Playing
        , components = Components.initial
        , systems = Systems.initial
        , score = model.score + model.systems.currentScore
      }
    , Cmd.batch [ play "action", play "theme" ]
    )


start : Model -> ( Model, Cmd Msg )
start model =
    ( { model
        | state = Playing
        , components = Components.initial
        , systems = Systems.initial
        , lives = 3
        , score = 0
      }
    , Cmd.batch [ play "action", play "theme" ]
    )


updateMenu : Time -> (Menu -> GameState) -> Menu -> Model -> ( Model, Cmd Msg )
updateMenu elapsed menuState menu model =
    let
        ( newMenu, cmd ) =
            Menu.update elapsed model.sound model.keys menu

        newModel =
            if menu.section == Menu.SlidesSection then
                { model | slides = Engine.update elapsed model.keys model.slides }
            else
                model
    in
        case cmd of
            Menu.Start ->
                start { newModel | state = Initial newMenu }

            Menu.ToggleSound on ->
                ( { newModel | sound = on, state = Initial newMenu }
                , if on then
                    Cmd.batch [ sound on, play "action" ]
                  else
                    sound on
                )

            Menu.Resume ->
                ( { newModel | state = Playing }
                , play "action"
                )

            Menu.End ->
                ( { newModel | state = Initial Menu.start }
                , Cmd.batch [ stop "theme", play "action" ]
                )

            Menu.Action ->
                ( { newModel | state = menuState newMenu }
                , play "action"
                )

            Menu.Noop ->
                ( { newModel | state = menuState newMenu }
                , Cmd.none
                )
