local mp = require 'mp'

local function escape_special_chars(str)
    return str:gsub("[][ `~!$^&*()=\\|;:'\",<>?{}]", "\\%1")
end

local function realpath(path)
    local handle = io.popen("realpath " .. escape_special_chars(path) .. " 2>/dev/null", "r")
    local result = handle:read()
    handle:close()
    return result
end

local function is_file(path)
    local file = io.open(path, "r")
    if file then
        io.close(file) 
        return true
    end
    mp.osd_message(string.format("Not a file: %s", path))
    return false
end

local function trash(path)
    local handle = io.popen("gio trash " .. escape_special_chars(path) .. " 2>&1", "r")
    local err = handle:read()
    handle:close()
    if err then
        mp.msg.error(err) 
        local short_err = err:gsub(".*\: ", "")
        mp.osd_message(string.format("%s", short_err))
        return false
    end
    mp.osd_message(string.format("Moved to trash: %s", realpath(path)))
    return true
end

local function update_playlist()
    local curr = mp.get_property_number("playlist-pos", 0)
    local last = mp.get_property_number("playlist-count", 0) - 1
    if curr < last then
        mp.command("playlist-remove current")
    else
        mp.command("playlist-prev")
        mp.command("playlist-remove " .. last)
    end
end

local function move_to_trash()
    local path = mp.get_property_osd("path")
    if is_file(path) and trash(path) then
        update_playlist()
    end
end

mp.add_key_binding("Shift+Del", "move_to_trash", move_to_trash)
