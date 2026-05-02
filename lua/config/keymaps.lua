local map = vim.keymap.set
local shortcuts_file = vim.fn.stdpath("config") .. "/shortcuts.md"

local function open_split(title, lines)
  vim.cmd("botright split")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
end

local function open_output_split(title, cmd)
  local output = { title, string.rep("-", #title) }

  if cmd == nil then
    table.insert(output, "(empty)")
  elseif vim.system then
    local result = vim.system(cmd, { text = true }):wait()
    local stdout = result.stdout or ""
    local stderr = result.stderr or ""

    if stdout ~= "" then
      vim.list_extend(output, vim.split(stdout, "\n", { plain = true, trimempty = true }))
    end

    if stderr ~= "" then
      table.insert(output, "")
      vim.list_extend(output, vim.split(stderr, "\n", { plain = true, trimempty = true }))
    end

    if stdout == "" and stderr == "" then
      table.insert(output, "(no output)")
    end
  else
    local result = vim.fn.systemlist(cmd)
    if #result > 0 then
      vim.list_extend(output, result)
    else
      table.insert(output, "(no output)")
    end
  end

  open_split(title, output)
end

local function buffer_uses_input()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(lines, "\n")
  return text:find("input%(") ~= nil
end

local function open_shortcut_guide()
  vim.cmd("edit " .. vim.fn.fnameescape(shortcuts_file))
end

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to list" })
map("n", "<leader>ex", "<cmd>Ex<cr>", { desc = "Open file explorer" })

map("n", "<leader>tt", function()
  open_output_split("Terminal output")
end, { desc = "Terminal split" })

map("n", "<leader>sq", open_shortcut_guide, { desc = "Open shortcut guide" })

map("n", "<leader>ru", function()
  open_output_split("Uvicorn output", { "uvicorn", "app.main:app", "--reload" })
end, { desc = "Run uvicorn" })

map("n", "<leader>rs", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  if buffer_uses_input() then
    vim.cmd("botright split")
    vim.cmd("terminal python " .. vim.fn.shellescape(file))
    vim.cmd("startinsert")
    return
  end

  open_output_split("Python output", { "python", file })
end, { desc = "Run Python file" })

map("n", "<leader>rt", function()
  open_output_split("Pytest output", { "pytest" })
end, { desc = "Run tests" })

map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

map("i", "<C-h>", "<C-w>", { desc = "Delete previous word" })
map("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })

map("t", "<Esc><Esc>", [[<C-\\><C-n>]], { desc = "Terminal normal mode" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})
