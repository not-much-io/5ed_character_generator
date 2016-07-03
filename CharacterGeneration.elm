module CharacterGeneration exposing (buildCharacter)

import CharacterClasses exposing (..)
import Types exposing (..)


calcLevel : Int -> Int
calcLevel xp =
    let
        leveling_points =
            [ 0
            , 300
            , 900
            , 2700
            , 6500
            , 14000
            , 23000
            , 34000
            , 48000
            , 64000
            , 85000
            , 100000
            , 120000
            , 140000
            , 165000
            , 195000
            , 225000
            , 265000
            , 305000
            , 355000
            ]

        leveling_info =
            List.map
                (\lp ->
                    if xp >= lp then
                        1
                    else
                        0
                )
                leveling_points
    in
        List.sum leveling_info


calcProfBonus : Int -> Int
calcProfBonus level =
    let
        initial_proficiency =
            2

        prof_gaining_levels =
            [ 5, 9, 13, 17 ]

        prof_gaining_info =
            List.map
                (\pgl ->
                    if level >= pgl then
                        1
                    else
                        0
                )
                prof_gaining_levels
    in
        initial_proficiency + (List.sum prof_gaining_info)


calcAbilityModifiers : AbilityScores -> AbilityModifiers
calcAbilityModifiers { str, dex, con, int, wis, cha } =
    let
        calcMod : Int -> Int
        calcMod score =
            (score - 10) // 2
    in
        AbilityModifiers (calcMod str)
            (calcMod dex)
            (calcMod con)
            (calcMod int)
            (calcMod wis)
            (calcMod cha)


calcSavingThrows : AbilityModifiers -> CharacterClass -> Int -> SavingThrows
calcSavingThrows { str, dex, con, int, wis, cha } { saving_throws } prof_bonus =
    let
        calcSavingThrow : Int -> Ability -> Int
        calcSavingThrow ability_score ability =
            if (List.member ability saving_throws) then
                ability_score + prof_bonus
            else
                ability_score
    in
        SavingThrows (calcSavingThrow str Strength)
            (calcSavingThrow dex Dexterity)
            (calcSavingThrow con Constitution)
            (calcSavingThrow int Intelligence)
            (calcSavingThrow wis Wisdom)
            (calcSavingThrow cha Charisma)


calcSkills : AbilityModifiers -> List Skill -> Int -> SkillScores
calcSkills { str, dex, con, int, wis, cha } skill_profs prof_bonus =
    let
        calcSkill : Int -> Skill -> Int
        calcSkill ability skill =
            if (List.member skill skill_profs) then
                ability + prof_bonus
            else
                ability
    in
        SkillScores (calcSkill dex Acrobatics)
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
buildCharacter { name, experience_points, ability_scores, class, skill_profs } =
    let
        level =
            calcLevel experience_points

        prof_bonus =
            calcProfBonus level

        ability_modifiers =
            calcAbilityModifiers ability_scores

        saving_throws =
            calcSavingThrows ability_modifiers class prof_bonus

        skills =
            calcSkills ability_modifiers skill_profs prof_bonus
    in
        CharacterData name
            class
            ability_scores
            experience_points
            level
            prof_bonus
            ability_modifiers
            saving_throws
            skills
