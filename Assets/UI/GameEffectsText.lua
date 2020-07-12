------------------------------------------------------------------------------
-- Basic text provider for GameEffects classes
--
-- LIMITATIONS:
-- This logic does not route through GameCore and thus cannot use
-- implementation-specific arguments or functions.
------------------------------------------------------------------------------

function GetModifierText(modifierId, context)

	if(GameEffects) then
		local key = GameEffects.GetModifierTextKey(modifierId, context);
		if(key) then
			return GameEffects.GetModifierText(modifierId, key);
		end
	else
		local key;
		for row in GameInfo.ModifierStrings() do
			if(row.ModifierId == modifierId and row.Context == context) then
				key = row.Text;
				break;
			end
		end

		if(key) then
			local args = {};
			for row in GameInfo.ModifierArguments() do
				if(row.ModifierId == modifierId) then
					local nValue = tonumber(row.Value);
					table.insert(args, {Name = row.Name, Value = nValue or row.Value});
				end
			end

			return Locale.Lookup(key, unpack(args));
		end
	end
end

function GetRequirementText(requirementId, context)
	if(GameEffects) then
		local key = GameEffects.GetRequirementTextKey(modifierId, context);
		if(key) then
			return GameEffects.GetRequirementText(modifierId, key);
		end
	else
		local key;
		for row in GameInfo.RequirementStrings() do
			if(row.RequirementId == requirementId and row.Context == context) then
				key = row.Text;
				break;
			end
		end

		if(key) then
			local args = {};
			for row in GameInfo.RequirementArguments() do
				if(row.RequirementId == requirementId) then
					local nValue = tonumber(row.Value);
					table.insert(args, {Name = row.Name, Value = nValue or row.Value});
				end
			end

			return Locale.Lookup(key, unpack(args));
		end
	end
end