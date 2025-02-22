local regex = require("blink.cmp.sources.path.regex")
local lib = require("blink.cmp.sources.path.lib")

lib.dirname = function(get_cwd, context)
  get_cwd = function(context)
    return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
  end
  if string.find(context.line, "@") then
    context.line = string.gsub(context.line, "'", "")
    context.line = string.gsub(context.line, '"', "")
    context.line = string.gsub(context.line, ".*@", "./src")
    get_cwd = function()
      return vim.fn.getcwd()
    end
  end

  local line_before_cursor = context.line:sub(1, context.bounds.start_col - (context.bounds.length == 0 and 1 or 0))
  local s = regex.PATH:match_str(line_before_cursor)
  if not s then
    return nil
  end

  local dirname = string.gsub(string.sub(line_before_cursor, s + 2), regex.NAME .. "*$", "") -- exclude '/'
  local prefix = string.sub(line_before_cursor, 1, s + 1) -- include '/'

  local buf_dirname = get_cwd(context)
  if vim.api.nvim_get_mode().mode == "c" then
    buf_dirname = vim.fn.getcwd()
  end
  if prefix:match("%.%./$") then
    return vim.fn.resolve(buf_dirname .. "/../" .. dirname)
  end
  if prefix:match("%./$") or prefix:match('"$') or prefix:match("'$") then
    return vim.fn.resolve(buf_dirname .. "/" .. dirname)
  end
  if prefix:match("~/$") then
    return vim.fn.resolve(vim.fn.expand("~") .. "/" .. dirname)
  end
  local env_var_name = prefix:match("%$([%a_]+)/$")
  if env_var_name then
    local env_var_value = vim.fn.getenv(env_var_name)
    if env_var_value ~= vim.NIL then
      return vim.fn.resolve(env_var_value .. "/" .. dirname)
    end
  end
  if prefix:match("/$") then
    local accept = true
    -- Ignore URL components
    accept = accept and not prefix:match("%a/$")
    -- Ignore URL scheme
    accept = accept and not prefix:match("%a+:/$") and not prefix:match("%a+://$")
    -- Ignore HTML closing tags
    accept = accept and not prefix:match("</$")
    -- Ignore math calculation
    accept = accept and not prefix:match("[%d%)]%s*/$")
    -- Ignore / comment
    accept = accept and (not prefix:match("^[%s/]*$") or not lib.is_slash_comment())
    if accept then
      return vim.fn.resolve("/" .. dirname)
    end
  end
  -- Windows drive letter (C:/)
  if prefix:match("(%a:)[/\\]$") then
    return vim.fn.resolve(prefix:match("(%a:)[/\\]$") .. "/" .. dirname)
  end
  return nil
end
