require("options")

if vim.g.vscode then
  return {}
end

require("keymaps")
require("plugin-loader")
