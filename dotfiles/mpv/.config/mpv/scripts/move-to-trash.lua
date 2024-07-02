require 'mp'

local function escape_special_chars(str)
    return str:gsub("[][ \"'`~!^&*(){}|;:=,<>?\\]", "\\%1")
end

local function file_exists(name)
    local file = io.open(name, "r")
    if file ~= nil then io.close(file) return true else return false end
end

local function trash(file)
    local pipe = io.popen("gio trash " .. file .. " &>/dev/null; echo \"$?\"", "r")
    local success = pipe:read() == "0"
    pipe:close()
    return success
end

local function update_playlist()
    local curr = mp.get_property_number("playlist-pos", 0)
    local last = mp.get_property_number("playlist-count", 0) - 1
    if curr ~= last then
        mp.command("playlist-remove current")
    else
        mp.command("playlist-prev")
        mp.command("playlist-remove " .. last)
    end
end

local function move_to_trash()
    local path = mp.get_property_osd("path")
    if file_exists(path) then
        if trash(escape_special_chars(path)) then
            mp.osd_message(string.format("Moved to trash: %s", path))
            update_playlist()
        else
            mp.msg.error("gio trash error")
        end
    else
        mp.osd_message(string.format("Not a file: %s", mp.get_property_osd("path")))
    end
end

mp.add_key_binding("Shift+Del", "move_to_trash", move_to_trash)
