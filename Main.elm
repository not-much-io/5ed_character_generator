import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing ( InitialCharacterData
                      , CharacterClass
                      , AbilityScores
                      , Skill )
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


init : (Types.Model, Cmd Types.Msg)
init =
    let
      init_char_data =
        Types.InitialCharacterData
          "charname"
          bard
          (AbilityScores 10 16 12 11 12 14)
          0
          [ Types.Acrobatics, Types.Arcana ]

      char_data =
        buildCharacter init_char_data

      init_model =
        Types.Model
          init_char_data
          char_data
    in
      (init_model, Cmd.none)


update : Types.Msg -> Types.Model -> (Types.Model, Cmd Types.Msg)
update msg model =
    let
      init_char_data = model.init_char_data
      updateCharData init_char_data =
        { model | 
          init_char_data = init_char_data,
          char_data = buildCharacter init_char_data
        }
    in
      case msg of
          Types.UpdateName name ->
            let
              new_init_char_data =
                { init_char_data | name = name }
            in
              (updateCharData new_init_char_data, Cmd.none)
          
          Types.UpdateClass class ->
            let
              new_init_char_data =
                { init_char_data | class = class }
            in
              (updateCharData new_init_char_data, Cmd.none)
          
          Types.UpdateAbilityScores ability_score score ->
            let
              current_ability_score = init_char_data.ability_scores
              new_init_char_data =
                case ability_score of
                  Types.Strength ->
                    { init_char_data | ability_scores = { current_ability_score | str = score } }
                  Types.Dexterity ->
                    { init_char_data | ability_scores = { current_ability_score | dex = score } }
                  Types.Constitution ->
                    { init_char_data | ability_scores = { current_ability_score | con = score } }
                  Types.Intelligence ->
                    { init_char_data | ability_scores = { current_ability_score | int = score } }
                  Types.Wisdom ->
                    { init_char_data | ability_scores = { current_ability_score | wis = score } }
                  Types.Charisma ->
                    { init_char_data | ability_scores = { current_ability_score | cha = score } }
            in
              (updateCharData new_init_char_data, Cmd.none)
          
          Types.UpdateExperiencePoints xp ->
            let
              xp_int = Result.withDefault -1 (String.toInt xp)
              new_init_char_data =
                { init_char_data | experience_points = xp_int }
            in
              (updateCharData new_init_char_data, Cmd.none)
          
          Types.UpdateSkillProficiencies skill bool ->
            let
              current_skills = init_char_data.skill_profs
            in
              if bool then
                -- add
                let
                  new_skills = skill :: current_skills
                  new_init_char_data =
                    { init_char_data | skill_profs = new_skills }
                in
                  (updateCharData new_init_char_data, Cmd.none)
              else
                -- remove
                let
                  new_skills =
                    List.filter
                      (\s -> not (s == skill))
                      current_skills
                  new_init_char_data =
                    { init_char_data | skill_profs = new_skills }
                in
                  (updateCharData new_init_char_data, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Types.Model -> Sub Types.Msg
subscriptions model =
  Sub.none


-- VIEW
view : Types.Model -> Html Types.Msg
view model =
    div
      []
      [ characterCreationForm model
      , characterSheet model.char_data
      ]
