module View exposing ( characterCreationForm, characterSheet )
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import CharacterClasses exposing (..)
import Types exposing (..)
import Json.Decode as Json
import String


abilities = 
    [ Strength
    , Dexterity
    , Constitution
    , Intelligence
    , Wisdom
    , Charisma
    ]


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


-- Character Creation Form


nameInput : Types.Model -> Html Types.Msg
nameInput model =
  textarea 
    [ placeholder "Name.."
    , rows 1
    , cols 20
    , onInput UpdateName
    ]
    []


classDropdown : Types.Model -> Html Types.Msg
classDropdown model =
    let
      nameToClass : String -> Types.CharacterClass
      nameToClass name =
        case name of
          "barbarian" -> barbarian            
          "bard" -> bard            
          "cleric" -> cleric            
          "druid" -> druid            
          "fighter" -> fighter            
          "monk" -> monk            
          "paladin" -> paladin            
          "ranger" -> ranger            
          "rogue" -> rogue            
          "sorcerer" -> sorcerer            
          "warlock" -> warlock            
          "wizard" -> wizard
          _ -> bard -- HACK: Do something better!
      options =
        List.map 
          (\cls -> option [value cls] [text cls])
          character_classes_names
    in
      select
        [ onInput (\cls_str -> UpdateClass (nameToClass cls_str)) ]
        options


abilityScoreInput : Types.Model -> Html Types.Msg
abilityScoreInput model =
  let
    abilityRangeScroller : Types.Ability -> Html Msg
    abilityRangeScroller ability =
      div
        []
        [ text (Basics.toString ability)
        , br [] []
        , input
          [ type' "number"
          , Html.Attributes.min "8"
          , Html.Attributes.max "16"
          , onInput (\score -> 
                        UpdateAbilityScores
                        ability 
                        (Result.withDefault -1 (String.toInt score)))
          ]
          []
        ]
  in
    div
      []
      (List.map abilityRangeScroller abilities)


experiencePointsInput : Types.Model -> Html Types.Msg
experiencePointsInput model =
  div
    []
    [ text "Experience Points:"
    , input
      [ type' "number" 
      , Html.Attributes.min "0"
      , Html.Attributes.max "355000"
      , onInput UpdateExperiencePoints
      ]
      []
    ]


skillProfsInput : Types.Model -> Html Types.Msg
skillProfsInput {init_char_data} =
  let
    {skill_profs, skill_choices} = init_char_data.class

    skillCheckbox skill =
      div
        []
        [ input
          [ type' "checkbox"
          , name "skill_prof"
          , value (toString skill)
          , onCheck (\bool-> UpdateSkillProficiencies skill bool)
          ] 
          []
        , text (toString skill)
        , br [] []
        ]

    skillCheckboxes =
      List.map
        skillCheckbox
        skill_choices
  in
    div
      []
      skillCheckboxes


characterCreationForm : Types.Model -> Html Msg
characterCreationForm model =
    div []
      [ h1 [] [ text "5ed Character Generator" ]
      , br [] []
      , nameInput model
      , br [] []
      , classDropdown model
      , br [] []
      , abilityScoreInput model
      , br [] []
      , experiencePointsInput model
      , br [] []
      , skillProfsInput model
      ]


-- Character Sheet
characterSheet : CharacterData -> Html Msg
characterSheet char =
  div
    []
    [ h4 [] [ text ("Name: " ++ char.name) ]
    , h4 [] [ text ("Class: " ++ 
              (toString char.class))
            ]
    , h4 [] [ text ("Abilities: " ++ 
              (toString char.ability_scores))
            ]
    , h4 [] [ text ("Experience points: " ++ 
              (toString char.experience_points))
            ]
    , h4 [] [ text ("Level: " ++ 
              (toString char.level))
            ]
    , h4 [] [ text ("Proficiency Bonus: " ++ 
              (toString char.proficiency_bonus))
            ]
    , h4 [] [ text ("Ability Modifiers: " ++ 
              (toString char.ability_modifiers))
            ]
    , h4 [] [ text ("Saving Throws: " ++ 
              (toString char.saving_throws))
            ]
    , h4 [] [ text ("Skills: " ++ 
              (toString char.skills))
            ]
    ]
