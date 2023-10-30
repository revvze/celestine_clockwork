local PLUGIN = PLUGIN;
local math = math;
 
local randomSounds = {
    "npc/combine_soldier/vo/gridsundown46.wav",
    "npc/combine_soldier/vo/block31mace.wav",
    "npc/combine_soldier/vo/block64jet.wav",
    "npc/combine_soldier/vo/ovewatchorders3ccstimboost.wav",
    "npc/combine_soldier/vo/prison_soldier_negativecontainment.wav",
    "npc/combine_soldier/vo/prison_soldier_leader9dead.wav",
    "npc/combine_soldier/vo/prison_soldier_prosecuteD7.wav",
    "npc/combine_soldier/vo/copythat.wav",
    "npc/combine_soldier/vo/copy.wav",
    "npc/combine_soldier/vo/hardenthatposition.wav",
    "npc/combine_soldier/vo/weaponsoffsafeprepforcontact.wav",
    "npc/combine_soldier/vo/stabilizationteamholding.wav",
    "npc/combine_soldier/vo/sectorissecurenovison.wav",
    "npc/combine_soldier/vo/prison_soldier_activatecentral.wav",
    "npc/combine_soldier/vo/prison_soldier_boomersinbound.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker3.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker1.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker2.wav",
    "npc/combine_soldier/vo/prison_soldier_fallback_b4.wav",
    "npc/combine_soldier/vo/prison_soldier_containD8.wav",
    "npc/combine_soldier/vo/prison_soldier_sundown3dead.wav",
    "npc/combine_soldier/vo/prison_soldier_prosecuteD7.wav",
    "npc/combine_soldier/vo/prison_soldier_freeman_antlions.wav",
    "npc/combine_soldier/vo/overwatchrequestwinder.wav",
    "npc/combine_soldier/vo/overwatchtargetcontained.wav",
    "npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav",
    "npc/combine_soldier/vo/isfinalteamunitbackup.wav",
    "npc/combine_soldier/vo/prison_soldier_visceratorsA5.wav",
    "npc/combine_soldier/vo/prison_soldier_tohighpoints.wav",
    "npc/combine_soldier/vo/prison_soldier_fullbioticoverrun.wav",
    "npc/combine_soldier/vo/prepforcontact.wav",
    "npc/combine_soldier/vo/sightlineisclear.wav",
    "npc/combine_soldier/vo/affirmative2.wav",
    "npc/combine_soldier/vo/sectionlockupdash4.wav",
    "npc/combine_soldier/vo/readyweapons.wav",
    "npc/combine_soldier/vo/isfieldpromoted.wav",
    "npc/combine_soldier/vo/affirmative.wav",
    "npc/combine_soldier/vo/reportingclear.wav",
    "npc/combine_soldier/vo/teamdeployedandscanning.wav"   
};
 
-- A function to emit a random sound
function PLUGIN:EmitRandomChatter(player)
    --[[
   
    -- Alternative sound emitter. Lowers the emitter's receiving sound but doesn't follow the player.
    for k,v in ipairs( _player.GetAll() ) do
        if (Schema:PlayerIsCombine(v)) then
            local pos = v:GetBonePosition(10)
            sound.Play( randomSounds[ math.random(1, #randomSounds) ], pos, 300, 100, 0.4 )
        end;
    end;
    ]]--
   
    local randomSound = randomSounds[math.random(1, #randomSounds)];
    player:EmitSound(randomSound, 65);
end;
 
function PLUGIN:PlayerThink(player, curTime)
    if ((player.nextChatterEmit or 0) < curTime) then
        if (player:GetFaction() == FACTION_MPF and !player:IsNoClipping() and player:Alive()) then
            player.nextChatterEmit = curTime + math.random(20, 90);
            PLUGIN:EmitRandomChatter(player);
        else
            player.nextChatterEmit = curTime + 90;
        end;
    end;
end;