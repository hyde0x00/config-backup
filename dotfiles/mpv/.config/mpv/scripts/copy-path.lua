require 'mp'
require 'mp.msg'

local function escape_special_chars(str)
    return str:gsub("[][ \"'`~!^&*(){}|;:=,<>?\\]", "\\%1")
end

local function file_exists(name)
    local file = io.open(name, "r")
    if file ~= nil then io.close(file) return true else return false end
end

local function have_cmd(cmd)
    local pipe = io.popen("type " .. cmd .. " &>/dev/null; echo \"$?\"", "r")
    local exists = pipe:read() == "0"
    pipe:close()
    return exists
end

local function get_clipboard_cmd()
    if have_cmd("xclip") then
        return "xclip -in -selection clipboard -silent"
    elseif have_cmd("xsel") then
        return "xsel --input --clipboard"
    else
        mp.msg.error("No supported clipboard command found")
        return false
    end
end

local function set_clipboard(text)
    if (clipboard_cmd) then
        local pipe = io.popen(clipboard_cmd, "w")
        pipe:write(text)
        pipe:close()
        return true
    else
        mp.msg.error("set_clipboard error")
        return false
    end
end

local function realpath(path)
    local pipe = io.popen("realpath " .. escape_special_chars(path) .. " 2>/dev/null", "r")
    local result = pipe:read()
    pipe:close()
    return result
end

local function copy_path()
    local path = mp.get_property("path")
    if file_exists(path) then
        path = escape_special_chars(realpath(path))
    end
    if set_clipboard(path) then
        mp.osd_message(string.format("Copied to clipboard: %s", path))
    end
end

clipboard_cmd = get_clipboard_cmd()

mp.add_key_binding("Y", "copy_path", copy_path)
