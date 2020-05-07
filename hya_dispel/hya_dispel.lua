local locale = GetLocale()
local L = {
    dispel = { default = "dispel", zhTW = "驅散", zhCN = "驱散"}
}

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
frame:SetScript("OnEvent", function(self, event, ...)
    local _, subevent, _, _, sourceName, sourceFlag, _, _, destName, _, _, _, _, _, extraSpellID = CombatLogGetCurrentEventInfo()
    if (subevent ~= 'SPELL_DISPEL') then return end
    if (bit.band(sourceFlag, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0) then return end
    if (not sourceName) then return end
    local msg = format("%s -%s- %s", sourceName or "", L.dispel[locale] or L.dispel.default, GetSpellLink(extraSpellID))
    if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
        SendChatMessage(msg, "INSTANCE_CHAT")
    elseif (IsInRaid()) then
        SendChatMessage(msg, "RAID")
    elseif (IsInGroup()) then
        SendChatMessage(msg, "PARTY")
    end
end)
