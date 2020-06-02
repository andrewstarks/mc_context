
local select, type, pairs = select, type, pairs


local c = {}
function c.new(t)
	local new = {}
	if type(t) ~= "table" then
		new.mc_value = t
	else
		new.mc_value = t.mc_value
	end
	
	return setmetatable(new, c)
end

local MC_CONTEXT = {
	mc_value = true
}



function c.__index(table, key)
	return c[key] 
end

function c.__newindex( t, key, value)
	if MC_ATTRIBUTES[key] then
		t[key] = value
	else
		error("The attribute " .. tostring(key) .. " is not supported.", 2)
	end
end
function c.is_context(t)
	if type(t) ~= "table" then
		return false, "Value is a literal."
	end
	for name in pairs(t) do
		if not MC_CONTEXT[name] then
			return false, "The attribute '".. tostring(name) .. "' is not supported."
		end
	end
	return t
end

function c.is_named(self)
	if c.is_context(self) and  self.mc_name then
		return self
	else
		return false
	end
end

function c.is_typed(self)
	if c.is_context(self) and self.mc_type then
		return self
	else
		return false
	end
end

function c.is_primitive(self)
	if c.is_context(self) and self.mc_type and self.name then
		return self
	else
		return false
	end
end
	

-- nil == {} == {mc_value = nil}
local _nonliteral = {
	["table"] 		= true,
	["boolean" ]	= true,
	["nil"  ]		= true,
}

function c.is_literal (a)
	return not (_nonliteral[type(a)] or c.is_primitive(a))
end

function c.to_value(self)
	if c.is_primitive(self) then
		return self.mc_value
	else
		return self
	end
end

function c.to_contexts(self, ...)
	self = c.is_context(self) and self or {mc_value = self}
	if select('#', ...) == 0 then
		return self
	else
		return self, c.to_contexts(...)
	end
end

function c.to_context(self, ...)
	self = c.is_context(self) and self or {mc_value = self}
	if select('#', ...) == 0 then
		return self
	else
		return c.compare(self, c.to_contexts(...))
	end
end

do
	local select = select -- local access to only call
	--true if a, false if b
	local function _compare(a, b) 
		if a.mc_value == true then
			-- b is truthy? false and true == false
			-- b is falsy?  true and true  == true 
			return b.mc_value and b or a -- a replaces only non-truthy values.
		else -- not true or nil is always a
			--a is nil then be
			--a is not nil  is false and false == true.
			return a.mc_value == nil and b or a
		end
	end
	c.compare = function(a, b, ...)
--		a, b = to_contexts(a, b)
		local value = _compare(a, b)
			-- not a transparent value
		if 	value.mc_value ~= true and value.mc_value ~= nil	
			-- transparent true survived from over riding false, 
				-- which means we stop here and replace this,
				-- even though it's just true.
			or b.mc_value == false  
			or select('#', ...) == 0 						
		then
			return value
		else
			return c.compare(value, ...)
		end
	end
end
c.__tostring(t)
	if t.to_string then 
		return t.mc_string(t) 
	else
		return tostring(t.mc_value)
	end
end
	

print("compare", c.compare(c.to_contexts({mc_value = false},nil, true,  "d")).mc_value)

print("one compare", c.to_context({mc_value = false},nil, true,  "d"))

print("nil == {} == {mc_value = nil}", 
	c.to_contexts(nil).mc_value == 
	c.to_contexts({}).mc_value and c.to_contexts({}).mc_value == 
	c.to_contexts({mc_value = nil}).mc_value
)

local a = c.new(4)
print(a, a.mc_value)


	