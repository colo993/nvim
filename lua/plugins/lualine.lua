return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')

        local function get_venv()
            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
                local parts = vim.split(venv_path, "/")
                return "uv: " .. parts[#parts]
            else
                return ""
            end
        end

        lualine.setup({
            options = {
                theme = 'codedark'
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                {
                        function()
                            return vim.fn.FugitiveStatusline()
                        end,
                        cond = function()
                            return vim.fn.exists('*FugitiveStatusline') and vim.fn.FugitiveStatusline() ~= ''
                        end,
                        color = { fg = '#d7ba7d' },
                    },
                'diff',
                'diagnostics' },
                lualine_c = {
                    { 'filename', path = 1, color = { fg = '#d4d4d4' } }
                },
                lualine_x = {
                    { get_venv , color = { fg = '#c586c0' } },
                    'progress',
                    'searchcount'
                },
                lualine_y = { 'location' },
                lualine_z = { 'encoding', 'fileformat', 'filesize', lualine.component_space },
            },
            inactive_sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = {
                    {
                        function() return vim.fn.expand('%:t') end,
                        cond = function() return vim.fn.expand('%') ~= '' end
                    },
                    { 'filename', path = 1 }
                },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = { 'encoding', 'fileformat', 'filesize', lualine.component_space }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {'fugitive'}
        })
    end
}
