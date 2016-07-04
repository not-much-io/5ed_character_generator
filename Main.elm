module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types
    exposing
        ( InitialCharacterData
        , CharacterClass
        , AbilityScores
        , Skill
        )
import CharacterClasses exposing (..)
import CharacterGeneration exposing (..)
import View exposing (..)
import String


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Types.Model, Cmd Types.Msg )
init =
    let
        init_char_data =
            Types.InitialCharacterData "charname"
                -- TODO: Initial value expected to be barbarian in classDropdown component
                barbarian
                (AbilityScores ( Types.Strength, 10 )
                    ( Types.Dexterity, 10 )
                    ( Types.Constitution, 10 )
                    ( Types.Intelligence, 10 )
                    ( Types.Wisdom, 10 )
                    ( Types.Charisma, 10 )
                )
                0
                []

        char_data =
            buildCharacter init_char_data

        init_model =
            Types.Model init_char_data
                char_data
    in
        ( init_model, Cmd.none )


update : Types.Msg -> Types.Model -> ( Types.Model, Cmd Types.Msg )
update msg model =
    let
        init_char_data =
            model.init_char_data

        updateCharData init_char_data =
            { model
                | init_char_data = init_char_data
                , char_data = buildCharacter init_char_data
            }
    in
        case msg of
            Types.UpdateName name ->
                let
                    new_model =
                        updateCharData { init_char_data | name = name }
                in
                    ( new_model, Cmd.none )

            Types.UpdateClass class ->
                let
                    new_model =
                        updateCharData { init_char_data | class = class }

                    -- TODO: When class gets updated
                    -- remove skill proficiencies that
                    -- are no longer valid
                in
                    ( new_model, Cmd.none )

            Types.UpdateAbilityScores ( ability, score ) ->
                let
                    curr_ability_scores =
                        init_char_data.ability_scores

                    new_ability_scores =
                        case ability of
                            Types.Strength ->
                                { curr_ability_scores | str = ( Types.Strength, score ) }

                            Types.Dexterity ->
                                { curr_ability_scores | dex = ( Types.Dexterity, score ) }

                            Types.Constitution ->
                                { curr_ability_scores | con = ( Types.Constitution, score ) }

                            Types.Intelligence ->
                                { curr_ability_scores | int = ( Types.Intelligence, score ) }

                            Types.Wisdom ->
                                { curr_ability_scores | wis = ( Types.Wisdom, score ) }

                            Types.Charisma ->
                                { curr_ability_scores | cha = ( Types.Charisma, score ) }

                    new_model =
                        updateCharData
                            { init_char_data
                                | ability_scores = new_ability_scores
                            }
                in
                    ( new_model, Cmd.none )

            Types.UpdateExperiencePoints xp ->
                let
                    new_model =
                        updateCharData
                            { init_char_data
                                | experience_points = xp
                            }
                in
                    ( new_model, Cmd.none )

            Types.UpdateSkillProficiencies skill add ->
                let
                    current_skills =
                        init_char_data.skill_profs

                    new_skills =
                        if add then
                            skill :: current_skills
                        else
                            List.filter (\s -> not (s == skill))
                                current_skills

                    new_model =
                        updateCharData
                            { init_char_data
                                | skill_profs = new_skills
                            }
                in
                    ( new_model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Types.Model -> Sub Types.Msg
subscriptions model =
    Sub.none



-- VIEW


view : Types.Model -> Html Types.Msg
view model =
    div []
        [ h1 [ style [ ( "text-align", "center" ) ] ]
            [ text "5ed DnD Character Generator" ]
        , div
            [ style
                [ ( "display", "flex" )
                , ( "justify-content", "center" )
                , ( "align-items", "center" )
                ]
            ]
            [ div [ style [ ( "width", "500px" ) ] ]
                [ characterCreationForm model ]
            , div [ style [ ( "width", "500px" ) ] ]
                [ characterSheet model.char_data ]
            ]
        ]
