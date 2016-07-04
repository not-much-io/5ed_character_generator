module View exposing (characterCreationForm, characterSheet)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import CharacterClasses exposing (..)
import Types exposing (..)
import Json.Decode as Json
import String


-- Character Creation Form


nameInput : String -> Html Types.Msg
nameInput currName =
    div []
        [ textarea
            [ placeholder "Name.."
            , rows 1
            , cols 20
            , onInput UpdateName
            , value currName
            ]
            []
        ]


classDropdown : CharacterClass -> Html Types.Msg
classDropdown currClass =
    let
        options =
            List.map
                (\cls ->
                    option [ value cls.as_string ]
                        [ text cls.as_string ]
                )
                character_classes

        updateClass : String -> Types.Msg
        updateClass str =
            UpdateClass (strToCharacterClass str currClass)
    in
        select [ onInput updateClass ]
            options


abilityScoreInput : AbilityScores -> Html Types.Msg
abilityScoreInput ability_scores =
    let
        scoreToInt : Ability -> String -> Int -> Int
        scoreToInt ability score_str curr_score =
            Result.withDefault curr_score (String.toInt score_str)

        abilityRangeScroller : ( Types.Ability, Int ) -> Html Msg
        abilityRangeScroller ( ability, score ) =
            let
                ability_str =
                    toString ability
            in
                div []
                    [ text ability_str
                    , br [] []
                    , input
                        [ type' "number"
                        , Html.Attributes.min "8"
                        , Html.Attributes.max "16"
                        , value (toString score)
                        , onInput
                            (\score_str ->
                                UpdateAbilityScores ( ability, (scoreToInt ability score_str score) )
                            )
                        ]
                        []
                    ]
    in
        div []
            (Types.mapToAbilities abilityRangeScroller ability_scores)


experiencePointsInput : Int -> Html Types.Msg
experiencePointsInput currXp =
    let
        xpToInt : String -> Int
        xpToInt xp_str =
            Result.withDefault currXp (String.toInt xp_str)
    in
        div []
            [ text "Experience Points:"
            , input
                [ type' "number"
                , Html.Attributes.min "0"
                , Html.Attributes.max "355000"
                , Html.Attributes.value (toString currXp)
                , onInput
                    (\xp_str ->
                        UpdateExperiencePoints (xpToInt xp_str)
                    )
                ]
                []
            ]


skillProfsInput : InitialCharacterData -> Html Types.Msg
skillProfsInput init_char_data =
    let
        skills =
            [ Acrobatics
            , AnimalHandling
            , Arcana
            , Athletics
            , Deception
            , History
            , Insight
            , Intimidation
            , Investigation
            , Medicine
            , Nature
            , Perception
            , Performance
            , Persuasion
            , Religion
            , SleightOfHand
            , Stealth
            , Survival
            ]

        { skill_profs, skill_choices } =
            init_char_data.class

        selected_skills =
            init_char_data.skill_profs

        spent_skill_profs =
            List.length init_char_data.skill_profs

        remaining_skill_profs =
            skill_profs - spent_skill_profs

        skillCheckbox skill =
            div []
                [ input
                    [ type' "checkbox"
                    , name "skill_prof"
                    , value (toString skill)
                    , onCheck
                        (\bool ->
                            UpdateSkillProficiencies skill bool
                        )
                    , disabled
                        ((remaining_skill_profs == 0)
                            && not (List.member skill selected_skills)
                        )
                    ]
                    []
                , text (toString skill)
                , br [] []
                ]

        skill_checkboxes =
            List.map skillCheckbox
                skill_choices

        lbl =
            text ("Skill proficiencies: " ++ (toString remaining_skill_profs))
    in
        div []
            (lbl :: skill_checkboxes)


characterCreationForm : Types.Model -> Html Msg
characterCreationForm { init_char_data } =
    let
        { name, class, ability_scores, experience_points } =
            init_char_data
    in
        div []
            [ h2 [] [ text "Initial Character Data Form" ]
            , nameInput name
            , br [] []
            , classDropdown class
            , br [] []
            , abilityScoreInput ability_scores
            , br [] []
            , experiencePointsInput experience_points
            , br [] []
            , skillProfsInput init_char_data
            ]



-- Character Sheet


nameBlock : String -> Html Types.Msg
nameBlock name =
    div []
        [ h4 [] [ text "Name" ]
        , text name
        ]


classBlock : CharacterClass -> Html Types.Msg
classBlock cls =
    let
        propBlock : String -> String -> Html Types.Msg
        propBlock name val =
            div []
                [ h5 [] [ text name ]
                , text val
                ]

        classInfoBlock : CharacterClass -> Html Types.Msg
        classInfoBlock cls =
            div []
                [ propBlock "Class HD" (toString cls.hit_die)
                , propBlock "Class Saving Throws" (toString cls.saving_throws)
                  -- propBlock "Skill Proficiencies" (toString cls.skill_profs)
                  -- propBlock "Skill Choices" (toString cls.skill_choices)
                ]
    in
        div []
            [ h4 [] [ text "Class" ]
            , text "{Class Name} -- TODO"
            , classInfoBlock cls
            ]


abilitiesBlock : AbilityScores -> AbilityScores -> Html Msg
abilitiesBlock ability_scores ability_modifiers =
    div []
        [ h4 [] [ text "Ability Scores" ]
        , text
            ("STR: "
                ++ (toString ability_scores.str)
                ++ " ("
                ++ (toString ability_modifiers.str)
                ++ ")"
            )
        , br [] []
        , text
            ("DEX: "
                ++ (toString ability_scores.dex)
                ++ " ("
                ++ (toString ability_modifiers.dex)
                ++ ")"
            )
        , br [] []
        , text
            ("CON: "
                ++ (toString ability_scores.con)
                ++ " ("
                ++ (toString ability_modifiers.con)
                ++ ")"
            )
        , br [] []
        , text
            ("INT: "
                ++ (toString ability_scores.int)
                ++ " ("
                ++ (toString ability_modifiers.int)
                ++ ")"
            )
        , br [] []
        , text
            ("WIS: "
                ++ (toString ability_scores.wis)
                ++ " ("
                ++ (toString ability_modifiers.wis)
                ++ ")"
            )
        , br [] []
        , text
            ("CHA: "
                ++ (toString ability_scores.cha)
                ++ " ("
                ++ (toString ability_modifiers.cha)
                ++ ")"
            )
        ]


savingThrowsBlock : AbilityScores -> Html Msg
savingThrowsBlock saving_throws =
    div []
        [ h4 [] [ text "Saving Throws" ]
        , text
            ("STR: "
                ++ (toString saving_throws.str)
            )
        , br [] []
        , text
            ("DEX: "
                ++ (toString saving_throws.dex)
            )
        , br [] []
        , text
            ("CON: "
                ++ (toString saving_throws.con)
            )
        , br [] []
        , text
            ("INT: "
                ++ (toString saving_throws.int)
            )
        , br [] []
        , text
            ("WIS: "
                ++ (toString saving_throws.wis)
            )
        , br [] []
        , text
            ("CHA: "
                ++ (toString saving_throws.cha)
            )
        ]


skillsBlock : SkillScores -> Html Msg
skillsBlock skill_scores =
    div []
        [ h4 [] [ text "Skills" ]
        , text
            ("Acrobatics: "
                ++ (toString skill_scores.acrobatics)
            )
        , br [] []
        , text
            ("Animal Handling: "
                ++ (toString skill_scores.animal_handling)
            )
        , br [] []
        , text
            ("Arcana: "
                ++ (toString skill_scores.arcana)
            )
        , br [] []
        , text
            ("Athletics: "
                ++ (toString skill_scores.athletics)
            )
        , br [] []
        , text
            ("Deception: "
                ++ (toString skill_scores.deception)
            )
        , br [] []
        , text
            ("History: "
                ++ (toString skill_scores.history)
            )
        , br [] []
        , text
            ("Insight: "
                ++ (toString skill_scores.insight)
            )
        , br [] []
        , text
            ("Intimidation: "
                ++ (toString skill_scores.intimidation)
            )
        , br [] []
        , text
            ("Investigation: "
                ++ (toString skill_scores.investigation)
            )
        , br [] []
        , text
            ("Medicine: "
                ++ (toString skill_scores.medicine)
            )
        , br [] []
        , text
            ("Nature: "
                ++ (toString skill_scores.nature)
            )
        , br [] []
        , text
            ("Perception: "
                ++ (toString skill_scores.perception)
            )
        , br [] []
        , text
            ("Performance: "
                ++ (toString skill_scores.performance)
            )
        , br [] []
        , text
            ("Persuasion: "
                ++ (toString skill_scores.persuasion)
            )
        , br [] []
        , text
            ("Religion: "
                ++ (toString skill_scores.religion)
            )
        , br [] []
        , text
            ("Sleight of Hand: "
                ++ (toString skill_scores.sleight_of_hand)
            )
        , br [] []
        , text
            ("Stealth: "
                ++ (toString skill_scores.stealth)
            )
        , br [] []
        , text
            ("Survival: "
                ++ (toString skill_scores.survival)
            )
        , br [] []
        ]


characterSheet : CharacterData -> Html Msg
characterSheet char =
    div []
        [ h2 [] [ text "Character Sheet" ]
        , div
            [ style
                [ ( "display", "flex" )
                , ( "justify-content", "center" )
                , ( "align-items", "center" )
                ]
            ]
            [ div [ style [ ( "margin", "20px" ) ] ]
                [ nameBlock char.name
                , classBlock char.class
                , abilitiesBlock char.ability_scores char.ability_modifiers
                ]
            , div [ style [ ( "margin", "20px" ) ] ]
                [ h4 []
                    [ text
                        ("Experience points: "
                            ++ (toString char.experience_points)
                        )
                    ]
                , h4 []
                    [ text
                        ("Level: "
                            ++ (toString char.level)
                        )
                    ]
                , h4 []
                    [ text
                        ("Proficiency Bonus: "
                            ++ (toString char.proficiency_bonus)
                        )
                    ]
                , savingThrowsBlock char.saving_throws
                ]
            , div [ style [ ( "margin", "20px" ) ] ]
                [ skillsBlock char.skills
                ]
            ]
        ]
