-- @author undefinist / www.undefinist.com
-- Structure of Script Measure:
---- IncFile=
---- Number=
---- SectionName=
---- OptionN=
---- ValueN=
---- where N is an ordered number from 0
-- Use %% to substitute it as the iteration number (which is specified by the Number option)
---- For example, if you specify 10, it will create 10 sections and replace the first section's %%
---- with 0, the second section's %% with 1, etc...
-- Wrap any formulas you want to parse in {} that otherwise RM would treat as a string
---- For example, [Measure{%%+1}] will have this script parse it for you

function Initialize()
	local num = SELF:GetNumberOption("Number")
	local key = SELF:GetOption("Key")
	local file = io.open(SKIN:MakePathAbsolute(SELF:GetOption("IncFile")), "w")
	local value = SELF:GetOption("Value")
	local pathAttributes = SELF:GetOption("PathAttributes")
	local t = {}

	for i = 0, num-1 do
		table.insert(t, "" .. doSub(key, i) .. " "  .. doSub(value, i) .. "|ClosePath 1")
		local j = 0

	end

	file:write("[MusicLine]", "\n", "Meter=Shape", "\n","Shape=Path MyPath|",pathAttributes,"\n","UpdateDivider=#FreezeVisualizerMeters#","\n","DynamicVariables=1","\n","MyPath=((#Radius#+([MeasureBand0]*#JumpHeight#))*cos(rad(#degree0#))+#CentreX#),((#Radius#+([MeasureBand0]*#JumpHeight#))*sin(rad(#degree0#))+#CentreY#)")
	file:write(table.concat(t))
	file:close()
end

-- does all the substitution!
function doSub(value, i)
	return value:gsub("%%%%", i):gsub("{.-}", parseFormula)
end

-- sub to remove {the curly braces}, then add (parentheses), then parse it
function parseFormula(formula)
	return SKIN:ParseFormula("(" .. formula:sub(2, -2) .. ")")
end
