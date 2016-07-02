module Types exposing (..)


type alias Model =
    { init_char_data : InitialCharacterData
    , char_data : CharacterData
    }


type Msg 
  = UpdateName String
  | UpdateClass CharacterClass
  | UpdateAbilityScores Ability Int
  | UpdateExperiencePoints String
  | UpdateSkillProficiencies Skill Bool


type Ability = 
    Strength
    | Dexterity
    | Constitution
    | Intelligence
    | Wisdom
    | Charisma


type Skill =
    Acrobatics
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
    { str : Int
    , dex : Int
    , con : Int
    , int : Int
    , wis : Int
    , cha : Int
    }


type alias AbilityModifiers =
    { str : Int
    , dex : Int
    , con : Int
    , int : Int
    , wis : Int
    , cha : Int
    }


type alias SavingThrows =
    { str : Int
    , dex : Int
    , con : Int
    , int : Int
    , wis : Int
    , cha : Int
    }


type alias SkillScores =
    { acrobatics : Int
    , animal_handling :Int
    , arcana : Int
    , athletics : Int
    , deception : Int
    , history : Int
    , insight : Int
    , intimidation : Int
    , investigation : Int
    , medicine : Int
    , nature : Int
    , perception : Int
    , performance : Int
    , persuasion : Int
    , religion : Int
    , sleight_of_hand : Int
    , stealth : Int
    , survivial : Int
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
    , ability_modifiers : AbilityModifiers
    , saving_throws : SavingThrows
    , skills : SkillScores
    }


type alias CharacterClass =
    { hit_die : Int
    , saving_throws : List Ability
    , skill_profs : Int  
    , skill_choices : List Skill
    }