local mp = require 'mp'

local function escape_special_chars(str)
    return str:gsub("[][ `~!$^&*()=\\|;:'\",<>?{}]", "\\%1")
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

local function open_file_manager()
    local path = mp.get_property_osd("path")
    if not is_file(path) then
        return false 
    end
    mp.osd_message("Opening file manager...")
    os.execute("nautilus " .. escape_special_chars(path) .. " &>/dev/null &")
end

mp.add_key_binding("Ctrl+o", "open_file_manager", open_file_manager)
