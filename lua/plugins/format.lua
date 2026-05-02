return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format", "black", stop_after_first = true },
        },
        format_on_save = function()
          return {
            lsp_fallback = true,
            timeout_ms = 2000,
          }
        end,
      })
    end,
  },
}
