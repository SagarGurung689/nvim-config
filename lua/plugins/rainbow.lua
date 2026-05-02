return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = require("rainbow-delimiters.strategy.global"),
          vim = require("rainbow-delimiters.strategy.local"),
        },
        query = {
          [""] = "rainbow-delimiters",
        },
      }

      local highlights = {
        RainbowDelimiterRed = "#f7768e",
        RainbowDelimiterYellow = "#e0af68",
        RainbowDelimiterBlue = "#7aa2f7",
        RainbowDelimiterOrange = "#ff9e64",
        RainbowDelimiterGreen = "#9ece6a",
        RainbowDelimiterViolet = "#bb9af7",
        RainbowDelimiterCyan = "#7dcfff",
      }

      local function set_hl()
        for name, color in pairs(highlights) do
          vim.api.nvim_set_hl(0, name, { fg = color })
        end
      end

      set_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_hl,
      })
    end,
  },
}
