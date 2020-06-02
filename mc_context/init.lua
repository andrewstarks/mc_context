-- # The Primitive mc_context object.



Assert = function(...) return ... end
local mc_primitive = { 
------------------- ## -2. API Constants for Contexts and primitives.

-- Constant primitives only in this context (implementations can count on this)
-- /self/mc_context/mc_context/mc_context
-- Provides application access to permissions for the primitive context
-- Defined by API, values in this context's values shall be...

	mc_hidden 	= 	Assert(true), 						-- always hidden, because constant.
															-- the values are already known
	mc_context  = 	Assert(false), 						-- the "lowest" context
														-- always `false` the access context. As a result...
														-- 	nothing in here may be filtered
														-- 	can't put within another context
														--	can only be accessed by enclosed contexts.
														-- 	cannot be "covered up" or overridden.
	mc_name		= 	Assert("mc_context"),
	-- ## REST access to the Context/Access values
	get			= 	Assert(true), 						-- access to this context is always available.
	post		= 	Assert(false),						-- cannot create a new context for this.
	put			= 	Assert(false),  					-- if put is false, then value cannot be covered up.
															-- `get` will `404` if a value attempts to 
															-- cover something that does not allow `put`.
	delete		= 	Assert(false),						-- mc_context can only be deleted by their instantiation,
															-- which holds an implementation reference to it.
															-- In this way, it is collected when the containing 
															-- instance is deleted.
	mc_value		= {
		
------------------- ## -1. Access Control Context	
-- /self/mc_context/mc_context

		mc_name			= 	"mc_context",			-- Always this name.
		mc_type 		= 	"mc_context/mc_context",	-- subcontexting grows the path from self and
														-- starts from the leaf context.
														-- mc_context is an anonymous name that does not appear
														-- the context name is always available as an attribute
	-- ### Default Access to Context Instance
		-- true shall mean at least some access is allowed, 
			-- but access is always forwarded to context object, which can further 
				-- filter and limit.
			-- When false, a context shall not grant access to primitives by covering 
				-- the value in /self/context  and shall error instead, if attempted.
		-- false fails immediately
		mc_methods = {
			-- this detail is left out. 
			-- We could break this out but too much detail. 
			-- It's only a simple nesting of a representation 
			-- of the resource's methods.
			post       		= true,   					-- false dissable encapsulation. 
															-- Root Context. only one in a system.
			get					= {
				mc_render	= true,						-- nil, requires true in request to render trigger render
														-- true, renders automatically or it's no-op (no latency only)
														-- false for no render function. literal validation and storage only.
															--sending true has no effect with states, even when false.
				mc_value 	= true, 					-- false for write only, attributes are independent.
			},
			get				= true,      				
			put        		= true,      				-- false for read only, ditto.
			delete     		= true,      				-- false implementation constants
			mc_value		= Assert(true),				-- constant, shall be true
		},
	
-------------------- ## 0. Generic Context 
-- /self/mc_context/

		mc_value = { 
													--  For control of encapsulation and context routing
			mc_name       = "mc_context",			-- Always this name.
													-- The path on instantiation is, "mc_name/mc_context"
-- # The REST API entry point...

-------------------- ## 1. Identity Context
-- /self

			mc_value = { 	
				mc_name = "mc_name",            		-- Instance Primitive Name

-------------------- ## 2. Type Context
-- /self/mc_type
				mc_value = { 
					mc_type = "mc_type",        		-- Instance Type Name				
					mc_value = { -- Will be optimized away to mc_value = tre
						
-------------------- ## nil. The Value Context
-- /self/mc_value
	-- we cannot land on a value, because the narrowest scope is type.mc_value, which means the value is the type. 
	-- The only value we can come to is type's value, which is actually pretty.
	-- So what we have by design is a type that we can sub-class and create instances of
	-- and a mechanism for validating types, a type validates values passed in, picking the most specific one.

						mc_name = "mc_value",
						mc_value = true,        		-- Type will be true
													-- mc_content == nil
													-- first sub-types will be primitives. 
													-- All primitives start out innocent and true.
					} --	nil. no value for a type.
				} -- 	 	  2. Type Value
			} -- 		 	  1. Idendity
		} -- 				  0. Context (main) 
	} -- 					 -1. Access 
} -- 						 -2. Constants

--]]

---[[ /mc_primitive :: shown as instantiated with full visibility

-- # The Primitive Type
	-- /mc_primitive/
	-- Always routes to "/self/mc_context" (constant)
	-- mc_value = nil, <any thing or concept of any representable value>
	
mc_primitive._simplified = {
-- ##	1. Identity Context
		-- /self/mc_name/mc_value ==  The name of the primitive. 
	mc_name       = "mc_primitive", -- The name of field and mc_name 
	
	-- mc_name and field name must always agree or error. 
	-- Leaving mc_name off from here on.
										
-- ##    0. The primitive's main context for routing and sub-typeing.
		-- /self/mc_context.mc_value = self <primitive> 
		-- self is sub-contexted with `self:post({<subcontext type>})`. 
			-- example: file-reader interface during real-time.
	mc_context = { 

-- ##  -1. The Primitive's context for controlling method access and sub-typing (post/put/get/delete).
		-- /self/mc_context/mc_context/mc_value = /self/mc_context 
		-- read only value
		mc_context = { 	
--[[## -2. The API Constants Context -- ALWAYS HIDDEN!
		-- /self/mc_context/mc_context/mc_context.mc_value = /self/mc_context/mc_context
		-- controls access to access parameters.
		-- reachable by /self/mc_context/mc_context/mc_context/[attribute name]
			mc_context = {				
				mc_hidden 		= assert(true), -- always hidden, because constant.
				mc_context  	= assert(false), 
				mc_name			= assert("mc_context"),
				get				= assert(true), 
				post			= assert(false),
				put				= assert(false),
				delete			= assert(false),
				mc_value		= "/self/mc_context/mc_context", -- always this value.
			},--]]

			mc_methods 			= {
				post       			= true,   					
				get					= {
					mc_render	= true,
					mc_value 	= true, -- get = true, or nil for default to not, false for none.
				},
				put        			= true,
				delete     			= true,
				mc_value			= true, --contant.
			},
			
			mc_value = "/self/mc_context", -- always this value, read only.
		},
		mc_value = "/self/",
	}, -- end of context.
		
-- ## 	2. The Type Context
		-- this spicific type. this is a type definition.
		-- this is the value for value of type. It's the root type.
		-- all primitives must derrive from this type.
		-- /mc_primitive/mc_type/mc_value = <const type definition> 
	mc_type = { 	
		mc_value = {
			--this is optimized away and becomes the type's value.
			mc_name = "mc_value",
			mc_value = true
		}
	},
-- ##  nil. The value of a type, used for creating new types and validation.
	mc_value = nil,
}

mc_primitive._presented = {
	mc_name     = "mc_primitive",	-- 1
	mc_type		= true,				-- 2
	mc_value 	= nil,				-- nil
}


return setmetatable(mc_primitive, { __index = mc_primitive })