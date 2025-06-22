return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Função para mostrar LSP ativos
    local function lsp_name()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if next(clients) == nil then
        return " "
      end
      local names = {}
      for _, client in pairs(clients) do
        table.insert(names, client.name)
      end
      return " " .. table.concat(names, ", ")
    end

    -- Configuração do tema
    local theme = require('lualine.themes.auto')
    
    -- Ajustes de cores
    theme.normal.c.bg = '#1e1e2e'
    
    -- Cores consistentes para todos os modos
    local mode_colors = {
      a = { bg = '#be57bd', fg = '#1e1e2e', gui = 'bold' }
    }
    
    theme.normal.a = mode_colors.a
    theme.insert.a = mode_colors.a
    theme.visual.a = mode_colors.a
    theme.replace.a = mode_colors.a
    theme.command.a = mode_colors.a
    theme.normal.z = { bg = '#be57bd' }

    -- Configuração principal
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { "neo-tree", "alpha" },
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,  -- Aumentei o tempo de refresh
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          {
            'branch',
            icon = ''
          },
          'diff',
          'diagnostics' 
        },
        lualine_c = {'filename'},
        lualine_x = {lsp_name, 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {}
    })
  end,
}
