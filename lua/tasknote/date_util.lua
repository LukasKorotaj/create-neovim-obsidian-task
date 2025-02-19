local M = {}
local wmap = {
	sunday = 1,
	monday = 2,
	tuesday = 3,
	wednesday = 4,
	thursday = 5,
	friday = 6,
	saturday = 7,
	sun = 1,
	mon = 2,
	tue = 3,
	wed = 4,
	thu = 5,
	fri = 6,
	sat = 7,
}

function M.parse_date(input)
	-- Existing YYYY-MM-DD check remains
	if input:match("^%d%d%d%d%-%d%d%-%d%d$") then
		return input
	end

	local l = input:lower()
	local specials = { today = 0, now = 0, tomorrow = 86400, yesterday = -86400 }

	-- Handle special cases first
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

	-- Improved relative day pattern matching
	local sign, num_str = 1, nil

	-- Pattern for "X days ago" format
	num_str = l:match("^(%d+)%s*d%a*%s*ago$")
	if num_str then
		sign = -1
	else
		-- Pattern for "in X days" or "X days" format
		num_str = l:match("^in%s*(%d+)%s*d%a*$") or l:match("^(%d+)%s*d%a*$")
	end

	if num_str then
		local num = tonumber(num_str)
		if num then
			local offset = sign * num * 86400
			return os.date("%Y-%m-%d", os.time() + offset)
		end
	end

	-- Now add weeks support
	local week_sign, week_str = 1, nil

	-- Pattern for "X weeks ago" format
	week_str = l:match("^(%d+)%s*w%a*%s*ago$")
	if week_str then
		week_sign = -1
	else
		-- Pattern for "in X weeks" or "X weeks" format (also matches shorthand "2w")
		week_str = l:match("^in%s*(%d+)%s*w%a*$") or l:match("^(%d+)%s*w%a*$")
	end

	if week_str then
		local weeks = tonumber(week_str)
		if weeks then
			local offset = week_sign * weeks * 7 * 86400
			return os.date("%Y-%m-%d", os.time() + offset)
		end
	end

	-- Check for singular "a week" cases
	if l:match("^a%s*week%s*ago$") then
		return os.date("%Y-%m-%d", os.time() - 7 * 86400)
	elseif l:match("^in%s*a%s*week$") or l:match("^a%s*week$") then
		return os.date("%Y-%m-%d", os.time() + 7 * 86400)
	end

	return nil
end

return M
