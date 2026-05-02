return {
  {
    "neovim/nvim-lspconfig",
    ft = { "python" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config.python").apply_venv(vim.fn.getcwd())

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
        settings = {
          python = {
            pythonPath = vim.g.python3_host_prog,
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      vim.lsp.enable("pyright")
    end,
  },
}
