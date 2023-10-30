Clockwork.animation.convert["melee2"] = "blunt"
Clockwork.animation.convert["knife"] = "fist"
Clockwork.animation.convert["revolver"] = "pistol"

-- some of these animations might be the same in normal clockwork but i put them in here just for organisation sake
local fixtable = {
    -- lowered standing
    ["stand_blunt_idle"] = ACT_IDLE,
    ["stand_blunt_walk"] = ACT_WALK,
    ["stand_blunt_run"] = ACT_RUN,

    -- raised standing
    ["stand_blunt_aim_idle"] = ACT_IDLE_ANGRY_MELEE,
    ["stand_blunt_aim_walk"] = ACT_WALK_AIM_RIFLE,
    ["stand_blunt_aim_run"] = ACT_RUN,
    
    -- lowered crouching
    ["crouch_blunt_idle"] = ACT_COVER_LOW,
    ["crouch_blunt_walk"] = ACT_WALK_CROUCH,

    -- raised crouching
    ["crouch_blunt_aim_idle"] = ACT_COVER_LOW,
    ["crouch_blunt_aim_walk"] = ACT_WALK_CROUCH,
    
    -- atack
    ["blunt_attack"] = ACT_MELEE_ATTACK_SWING,
}

table.Merge(Clockwork.animation.stored.maleHuman, fixtable)
table.Merge(Clockwork.animation.stored.femaleHuman, fixtable)