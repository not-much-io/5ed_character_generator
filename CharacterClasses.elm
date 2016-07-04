module CharacterClasses exposing (..)

import Types exposing (..)


barbarian =
    CharacterClass "barbarian"
        12
        [ Strength, Constitution ]
        2
        [ AnimalHandling
        , Athletics
        , Intimidation
        , Nature
        , Perception
        , Survival
        ]


bard =
    CharacterClass "bard"
        8
        [ Dexterity, Charisma ]
        3
        -- All skills
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


cleric =
    CharacterClass "cleric"
        8
        [ Wisdom, Charisma ]
        2
        [ History
        , Insight
        , Medicine
        , Persuasion
        , Religion
        ]


druid =
    CharacterClass "druid"
        8
        [ Intelligence, Wisdom ]
        2
        [ Arcana
        , AnimalHandling
        , Insight
        , Medicine
        , Nature
        , Perception
        , Religion
        , Survival
        ]


fighter =
    CharacterClass "fighter"
        10
        [ Strength, Constitution ]
        2
        [ Acrobatics
        , AnimalHandling
        , Athletics
        , History
        , Insight
        , Intimidation
        , Perception
        , Survival
        ]


monk =
    CharacterClass "monk"
        8
        [ Strength, Dexterity ]
        2
        [ Acrobatics
        , Athletics
        , History
        , Insight
        , Religion
        , Stealth
        ]


paladin =
    CharacterClass "paladin"
        10
        [ Wisdom, Charisma ]
        2
        [ Athletics
        , Insight
        , Intimidation
        , Medicine
        , Persuasion
        , Religion
        ]


ranger =
    CharacterClass "ranger"
        10
        [ Strength, Dexterity ]
        3
        [ AnimalHandling
        , Athletics
        , Insight
        , Investigation
        , Nature
        , Perception
        , Stealth
        , Survival
        ]


rogue =
    CharacterClass "rogue"
        8
        [ Dexterity, Intelligence ]
        4
        [ Acrobatics
        , Athletics
        , Deception
        , Insight
        , Intimidation
        , Investigation
        , Perception
        , Performance
        , Persuasion
        , SleightOfHand
        , Stealth
        ]


sorcerer =
    CharacterClass "sorcerer"
        6
        [ Constitution, Charisma ]
        2
        [ Arcana
        , Deception
        , Insight
        , Intimidation
        , Persuasion
        , Religion
        ]


warlock =
    CharacterClass "warlock"
        8
        [ Wisdom, Charisma ]
        2
        [ Arcana
        , Deception
        , History
        , Intimidation
        , Investigation
        , Nature
        , Religion
        ]


wizard =
    CharacterClass "wizard"
        6
        [ Intelligence, Wisdom ]
        2
        [ Arcana
        , History
        , Insight
        , Investigation
        , Medicine
        , Religion
        ]


character_classes =
    [ barbarian
    , bard
    , cleric
    , druid
    , fighter
    , monk
    , paladin
    , ranger
    , rogue
    , sorcerer
    , warlock
    , wizard
    ]


strToCharacterClass : String -> CharacterClass -> CharacterClass
strToCharacterClass name currClass =
    case name of
        "barbarian" ->
            barbarian

        "bard" ->
            bard

        "cleric" ->
            cleric

        "druid" ->
            druid

        "fighter" ->
            fighter

        "monk" ->
            monk

        "paladin" ->
            paladin

        "ranger" ->
            ranger

        "rogue" ->
            rogue

        "sorcerer" ->
            sorcerer

        "warlock" ->
            warlock

        "wizard" ->
            wizard

        _ ->
            -- Cannot happen!
            --      - Every programmer ever
            --
            -- BUT if it does, set back to current
            -- TODO: Don't fail silently! Let the whole world know!
            currClass
