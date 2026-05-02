local M = {}

local function venv_bin_dir(venv_root)
  if vim.fn.has("win32") == 1 then
    return venv_root .. "\\Scripts"
  end

  return venv_root .. "/bin"
end

local function prepend_path(bin_dir)
  if vim.fn.has("win32") == 1 then
    if not vim.env.PATH:find(bin_dir, 1, true) then
      vim.env.PATH = bin_dir .. ";" .. vim.env.PATH
    end
  else
    if not vim.env.PATH:find(bin_dir, 1, true) then
      vim.env.PATH = bin_dir .. ":" .. vim.env.PATH
    end
  end
end

function M.find_venv(start_dir)
  local names = { ".venv", "venv" }
  for _, name in ipairs(names) do
    local match = vim.fs.find(name, { path = start_dir, upward = true, type = "directory" })[1]
    if match then
      return match
    end
  end
end

function M.apply_venv(start_dir)
  local venv_root = M.find_venv(start_dir)
  if not venv_root then
    return
  end

  local bin_dir = venv_bin_dir(venv_root)
  local python = bin_dir .. (vim.fn.has("win32") == 1 and "\\python.exe" or "/python")

  if vim.uv.fs_stat(python) then
    vim.g.python3_host_prog = python
  end

  prepend_path(bin_dir)

  vim.env.VIRTUAL_ENV = venv_root
end

M.apply_venv(vim.fn.getcwd())

return M
