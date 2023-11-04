-- Called when PAC
function PLUGIN:PrePACConfigApply(player)
 if ( !Clockwork.player:HasFlags(player, "W") ) then
  Clockwork.player:Notify(player, "You are not Whitelisted to use PAC3, no one will see your outfit!");
  return false;
 end;
end;