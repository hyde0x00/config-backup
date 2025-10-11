local mp = require 'mp'

local function have_cmd(name)
    local handle = io.popen("type " .. name .. " &>/dev/null; echo $?", "r")
    local success = handle:read() == "0"
    handle:close()
    return success
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

local function copy_to_clipboard(text)
    if not (clipboard_cmd) then
        mp.msg.error("copy_to_clipboard error")
        return false
    end
    local handle = io.popen(clipboard_cmd, "w")
    handle:write(text)
    handle:close()
    mp.osd_message(string.format("Copied to clipboard: %s", text))
    return true
end

local function escape_special_chars(str)
    return str:gsub("[][ `~!$^&*()=\\|;:'\",<>?{}]", "\\%1")
end

local function realpath(path)
    local handle = io.popen("realpath " .. escape_special_chars(path) .. " 2>/dev/null", "r")
    local result = handle:read()
    handle:close()
    return result
end

local function is_url(path)
    return string.match(path, "^https?://*")
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

local function copy_path()
    local path = mp.get_property("path")
    if is_url(path) then
        copy_to_clipboard(path)
    elseif is_file(path) then
        copy_to_clipboard(realpath(path))
    end
end

local function copy_escaped_path()
    local path = mp.get_property("path")
    if is_url(path) then
        copy_to_clipboard(path)
    elseif is_file(path) then
        copy_to_clipboard(escape_special_chars(realpath(path)))
    end
end

clipboard_cmd = get_clipboard_cmd()

mp.add_key_binding("Ctrl+c", "copy_path", copy_path)
mp.add_key_binding("Ctrl+C", "copy_escaped_path", copy_escaped_path)
