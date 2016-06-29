

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


type alias CharacterClass =
    { hit_die : Int
    , saving_throws : List Ability
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


barbarian = 
    CharacterClass 12 [ Strength, Constitution ]
bard = 
    CharacterClass 8 [ Dexterity, Charisma ]
cleric =
    CharacterClass 8 [ Wisdom, Charisma ]
druid =
    CharacterClass 8 [ Intelligence, Wisdom ]
fighter =
    CharacterClass 10 [ Strength, Constitution ]
monk =
    CharacterClass 8 [ Strength, Dexterity ]
paladin =
    CharacterClass 10 [ Wisdom, Charisma ]
ranger =
    CharacterClass 10 [ Strength, Dexterity ]
rogue =
    CharacterClass 8 [ Dexterity, Intelligence ]
sorcerer =
    CharacterClass 6 [ Constitution, Charisma ]
warlock =
    CharacterClass 8 [ Wisdom, Charisma ]
wizard =
    CharacterClass 6 [ Intelligence, Wisdom ]

initial_character_data = 
    let
        name = "Midnight"
        class = bard
        ability_scores =
            AbilityScores 10 10 10 10 10 10
        experience_points = 0
    in
        InitialCharacterData name class ability_scores experience_points


calcLevel : Int -> Int
calcLevel xp =
    let
        leveling_points = 
            [ 0, 300, 900, 2700, 6500
            , 14000, 23000, 34000, 48000, 64000
            , 85000, 100000, 120000, 140000, 165000
            , 195000, 225000, 265000, 305000, 355000
            ]
        leveling_info = 
            List.map (\lp -> if xp >= lp then 1 else 0) leveling_points
    in
        List.sum leveling_info


calcProfBonus : Int -> Int
calcProfBonus level =
    let
        initial_proficiency = 2
        prof_gaining_levels = [5, 9, 13, 17]
        prof_gaining_info =
            List.map (\pgl -> if level >= pgl then 1 else 0) prof_gaining_levels
    in
        initial_proficiency + (List.sum prof_gaining_info)


calcAbilityModifiers : AbilityScores -> AbilityModifiers
calcAbilityModifiers {str, dex, con, int, wis, cha} =
    let
        calcMod : Int -> Int
        calcMod score = 
            (score - 10) // 2
    in
        AbilityModifiers
            (calcMod str)
            (calcMod dex)
            (calcMod con)
            (calcMod int)
            (calcMod wis)
            (calcMod cha)


calcSavingThrows : AbilityModifiers -> CharacterClass -> Int -> SavingThrows
calcSavingThrows {str, dex, con, int, wis, cha} {saving_throws} prof_bonus =
    let
        calcSavingThrow : Int -> Ability -> Int
        calcSavingThrow ability_score ability =
            if (List.member ability saving_throws) then
                ability_score + prof_bonus
            else
                ability_score
    in
        SavingThrows
            (calcSavingThrow str Strength)
            (calcSavingThrow dex Dexterity)
            (calcSavingThrow con Constitution)
            (calcSavingThrow int Intelligence)
            (calcSavingThrow wis Wisdom)
            (calcSavingThrow cha Charisma)


calcSkills : AbilityModifiers -> List Skill -> Int -> SkillScores
calcSkills {str, dex, con, int, wis, cha} skill_profs prof_bonus =
    let
        calcSkill : Int -> Skill -> Int
        calcSkill ability skill =
            if (List.member skill skill_profs) then
                ability + prof_bonus
            else
                ability
    in
        SkillScores
            (calcSkill dex Acrobatics)
            (calcSkill wis AnimalHandling)
            (calcSkill int Arcana)
            (calcSkill str Athletics)
            (calcSkill cha Deception)
            (calcSkill int History)
            (calcSkill wis Insight)
            (calcSkill cha Intimidation)
            (calcSkill int Investigation)
            (calcSkill wis Medicine)
            (calcSkill int Nature)
            (calcSkill wis Perception)
            (calcSkill cha Performance)
            (calcSkill cha Persuasion)
            (calcSkill int Religion)
            (calcSkill dex SleightOfHand)
            (calcSkill dex Stealth)
            (calcSkill wis Survival)


buildCharacter : InitialCharacterData -> CharacterData
buildCharacter init_char_data =
    let
        level =
            calcLevel init_char_data.experience_points
        prof_bonus =
            calcProfBonus level
        ability_modifiers =
            calcAbilityModifiers init_char_data.ability_scores
        saving_throws =
            calcSavingThrows ability_modifiers init_char_data.class prof_bonus
        skills =
            calcSkills ability_modifiers init_char_data.skill_profs prof_bonus
    in
        CharacterData
            init_char_data.name
            init_char_data.class
            init_char_data.ability_scores
            init_char_data.experience_points
            level
            prof_bonus
            ability_modifiers
            saving_throws
            skills