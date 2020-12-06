--	// FileName: ScamInterceptorLoader.lua
--	// Written by: PseudoPerson (Dec. 2020)
--	// Description: Sets up ScamInterceptor module script.



-- Services --
local Chat = game:GetService("Chat")
local ServerScriptService = game:GetService("ServerScriptService")

-- Instances --
local ChatModules = Chat:WaitForChild("ChatModules")
local ScamInterceptor = script.ScamInterceptor

-- Code --
if ScamInterceptor.Parent.Name ~= "ChatModules" then
	ScamInterceptor.Parent = ChatModules
end