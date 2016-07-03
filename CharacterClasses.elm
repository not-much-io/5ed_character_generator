module CharacterClasses exposing (..)

import Types exposing (..)


barbarian =
    CharacterClass 12
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
    CharacterClass 8
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
    CharacterClass 8
        [ Wisdom, Charisma ]
        2
        [ History
        , Insight
        , Medicine
        , Persuasion
        , Religion
        ]


druid =
    CharacterClass 8
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
    CharacterClass 10
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
    CharacterClass 8
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
    CharacterClass 10
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
    CharacterClass 10
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
    CharacterClass 8
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
    CharacterClass 6
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
    CharacterClass 8
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
    CharacterClass 6
        [ Intelligence, Wisdom ]
        2
        [ Arcana
        , History
        , Insight
        , Investigation
        , Medicine
        , Religion
        ]
