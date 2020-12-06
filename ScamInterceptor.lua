--	// FileName: ScamInterceptor.lua
--	// Written by: PseudoPerson (Dec. 2020)
--	// Description: Filters messages based on sets of keywords.



-- Keywords are divied into sets. If a message reaches over 1.0 weight in any one set then it is filtered.
local keywordSets = {
	-- Example set for scamming
	["scamming"] = {
		-- Example set: 
		["blox%.page"] = 1;
		["blox%.army"] = 1;
		["robux"] = 0.6;
		--Each "word" is a Lua pattern. "%" is an escape character for some characters used for other things. (Ex: "." is used to represent ANY character)
		["r%$"] = 0.6;
		["blox"] = 0.2;
		["page"] = 0.2;
		["free"] = 0.6;
		["gamepasses"] = 0.2;
	};
	-- You can also make sets for things like bullying
}

local functionId = "ScamInterceptor"

-- Level 3 --
local function messageSus(message)
	--converts the message to lowercase
	local lowerMessage = string.lower(message)
	--loops through sets
	for setName, set in pairs(keywordSets) do
		--the weight a message has in each set
		local currentWeight = 0
		--loops through keywords in sets
		for filterString, weight in pairs(set) do
			--if the message has the keyword
			if string.match(lowerMessage, string.lower(filterString)) then
				--adds that message's weight to the total set weight
				currentWeight = currentWeight + weight
			end
		end
		--if the total weight the message has in the current set is greater than 1 it returns true, removing the message from the chat.
		if currentWeight >= 1 then
			return setName
		end
	end
	return false
end


-- Level 2 --
local function filter(speakerName, message)
	--gets the reason. reason will equal nil if there isn't one.
	local reason = messageSus(message)
	if reason then
		--Tells chat service the message is a cmd. This removes the message and runs code below (but above the "return true" line).
		
		--[OPTIONAL] ADD YOUR CODE HERE (code here will run if a player with Name speakerName says a message that fails your filter)
		print(speakerName.."'s message (\""..message.."\") was removed because it was classifed as "..reason.."!")
		
		return true
	end
	return false
end


-- Level 1 --
local function runChatModule(ChatService)
	ChatService:RegisterProcessCommandsFunction(functionId, filter)
end

return runChatModule