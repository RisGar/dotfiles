---@brief
---
--- https://github.com/ocaml/ocaml-lsp
---
--- `ocaml-lsp` can be installed as described in [installation guide](https://github.com/ocaml/ocaml-lsp#installation).
---
--- To install the lsp server in a particular opam switch:
--- ```sh
--- opam install ocaml-lsp-server
--- ```

local util = require("lspconfig.util")

local language_id_of = {
  menhir = "ocaml.menhir",
  ocaml = "ocaml",
  ocamlinterface = "ocaml.interface",
  ocamllex = "ocaml.ocamllex",
  reason = "reason",
  dune = "dune",
}

local get_language_id = function(_, ftype)
  return language_id_of[ftype]
end

local function switch_implementation_interface(bufnr, client)
  local method_name = "ocamllsp/switchImplIntf"

  ---@diagnostic disable-next-line:param-type-mismatch
  if not client or not client:supports_method(method_name) then
    return vim.notify(
      ("method %s is not supported by any servers active on the current buffer"):format(method_name)
    )
  end

  local params = vim.lsp.util.make_text_document_params(bufnr).uri

  ---@diagnostic disable-next-line:param-type-mismatch
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end

    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end

    print(vim.inspect(result))
    -- vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

---@type vim.lsp.Config
return {
  cmd = { "ocamllsp" },

  filetypes = { "ocaml", "menhir", "ocamlinterface", "ocamllex", "reason", "dune" },

  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace")(fname))
  end,

  get_language_id = get_language_id,

  settings = {
    extendedHover = { enable = true },
    standardHover = { enable = true },
    codelens = { enable = true },
    duneDiagnostics = { enable = true },
    inlayHints = { enable = true },
    syntaxDocumentation = { enable = true },
    merlinJumpCodeActions = { enable = true },
  },

  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspOcamlSwitchImplementationInterface", function()
      switch_implementation_interface(bufnr, client)
    end, { desc = "Switch between implementation/interface" })

    vim.keymap.set("n", "<leader>ch", "<cmd>LspOcamlSwitchImplementationInterface<cr>", {
      desc = "switch between implementation/interface",
    })
  end,
}
