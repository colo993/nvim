-- lua/lualine/components.lua

local function get_venv()
    local venv_path = os.getenv("VIRTUAL_ENV")
    if venv_path then
        local parts = vim.split(venv_path, "/")
        return "uv: " .. parts[#parts]
    else
        return ""
    end
end

return {
    get_venv = get_venv,
}
