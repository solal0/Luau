if cloneref and type(cloneref) == "function" then
	return cloneref
else
	cloneref = function(...) return ... end
end

local utils = {}

return utils
