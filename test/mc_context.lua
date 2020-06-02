
 
local json = require 'dkjson'

-- local mc_context = require'mc_context'



local function mc_context(context, ...)
	-- repack table
	local mc_value
	local new = {}
	if type(context) == nil then
		if select('#', ...) == 0 then
			return {}
		else -- throw it out.
			return mc_context(...)
		end
	elseif type(context) ~= "table" then
		new.mc_value = context
		context = new
	else
		new.mc_value = context.mc_value
		new.mc_name = context.mc_name or "mc_name"
		new.mc_type = context.mc_type or "mc_type"
	end
	
	
	
	
	
	local mc_primitive  = true
	
	for name, value in pairs (context) do
		if (name == "mc_type" 
			or name == "mc_name" 
			or name = "mc_value") then
			
			mc_primitive = false
		end
		new[name] = value
	end
	
	
end

print(mc_context{mc_value = true, a = false})
print("hello, world!")
 