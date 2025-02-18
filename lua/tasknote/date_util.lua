local M = {}
local wmap = { sunday = 1, monday = 2, tuesday = 3, wednesday = 4, thursday = 5, friday = 6, saturday = 7 }

function M.parse_date(input)
	if input:match("^%d%d%d%d%-%d%d%-%d%d$") then
		return input
	end
	local l = input:lower()
	local specials = { today = 0, tomorrow = 86400, yesterday = -86400 }
	if specials[l] then
		return os.date("%Y-%m-%d", os.time() + specials[l])
	end
	if wmap[l] then
		local t = os.date("*t") -- Get current date table
		local current_wday = t.wday -- Current weekday (1 = Sunday)
		local target_wday = wmap[l]
		local diff = target_wday - current_wday
		-- Always return the next occurrence (even if today matches)
		if diff <= 0 then
			diff = diff + 7
		end
		return os.date("%Y-%m-%d", os.time() + diff * 86400)
	end
	return nil
end
return M
