require 'mp'

local function escape_special_chars(str)
    return str:gsub("[][ \"'`~!^&*(){}|;:=,<>?\\]", "\\%1")
end

local function file_exists(name)
    local file = io.open(name, "r")
    if file ~= nil then io.close(file) return true else return false end
end

local function open_file_manager()
    local path = mp.get_property_osd("path")
    if file_exists(path) then
        mp.osd_message("Opening file manager...")
        os.execute("nautilus " .. escape_special_chars(path) .. " &>/dev/null &")
    else
        mp.osd_message(string.format("Not a file: %s", path))
    end
end

mp.add_key_binding("Alt+o", "open_file_manager", open_file_manager)
