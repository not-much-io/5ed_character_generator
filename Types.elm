module Types exposing (..)


type alias Model =
    { init_char_data : InitialCharacterData
    , char_data : CharacterData
    }


type Msg
    = UpdateName String
    | UpdateClass CharacterClass
    | UpdateAbilityScores ( Ability, Int )
    | UpdateExperiencePoints Int
    | UpdateSkillProficiencies Skill Bool


type Ability
    = Strength
    | Dexterity
    | Constitution
    | Intelligence
    | Wisdom
    | Charisma


type Skill
    = Acrobatics
    | AnimalHandling
    | Arcana
    | Athletics
    | Deception
    | History
    | Insight
    | Intimidation
    | Investigation
    | Medicine
    | Nature
    | Perception
    | Performance
    | Persuasion
    | Religion
    | SleightOfHand
    | Stealth
    | Survival


type alias AbilityScores =
    { str : ( Ability, Int )
    , dex : ( Ability, Int )
    , con : ( Ability, Int )
    , int : ( Ability, Int )
    , wis : ( Ability, Int )
    , cha : ( Ability, Int )
    }


type alias AbilityScoreValues =
    { str : Int
    , dex : Int
    , con : Int
    , int : Int
    , wis : Int
    , cha : Int
    }


getAbilityScoreValues : AbilityScores -> AbilityScoreValues
getAbilityScoreValues { str, dex, con, int, wis, cha } =
    let
        ( _, str_score ) =
            str

        ( _, dex_score ) =
            dex

        ( _, con_score ) =
            con

        ( _, int_score ) =
            int

        ( _, wis_score ) =
            wis

        ( _, cha_score ) =
            cha
    in
        AbilityScoreValues str_score
            dex_score
            con_score
            int_score
            wis_score
            cha_score


mapToAbilities : (( Ability, Int ) -> a) -> AbilityScores -> List a
mapToAbilities f ability_scores =
    [ (f ability_scores.str)
    , (f ability_scores.dex)
    , (f ability_scores.con)
    , (f ability_scores.int)
    , (f ability_scores.wis)
    , (f ability_scores.cha)
    ]


type alias SkillScores =
    { acrobatics :
        ( Skill, Int )
    , animal_handling :
        ( Skill, Int )
    , arcana :
        ( Skill, Int )
    , athletics :
        ( Skill, Int )
    , deception :
        ( Skill, Int )
    , history :
        ( Skill, Int )
    , insight :
        ( Skill, Int )
    , intimidation :
        ( Skill, Int )
    , investigation :
        ( Skill, Int )
    , medicine :
        ( Skill, Int )
    , nature :
        ( Skill, Int )
    , perception :
        ( Skill, Int )
    , performance :
        ( Skill, Int )
    , persuasion :
        ( Skill, Int )
    , religion :
        ( Skill, Int )
    , sleight_of_hand :
        ( Skill, Int )
    , stealth :
        ( Skill, Int )
    , survival :
        ( Skill, Int )
    }


type alias InitialCharacterData =
    { name : String
    , class : CharacterClass
    , ability_scores : AbilityScores
    , experience_points : Int
    , skill_profs : List Skill
    }


type alias CharacterData =
    { name : String
    , class : CharacterClass
    , ability_scores : AbilityScores
    , experience_points : Int
    , level : Int
    , proficiency_bonus : Int
    , ability_modifiers : AbilityScores
    , saving_throws : AbilityScores
    , skills : SkillScores
    }


type alias CharacterClass =
    { as_string : String
    , hit_die : Int
    , saving_throws : List Ability
    , skill_profs : Int
    , skill_choices : List Skill
    }
