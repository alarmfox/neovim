return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = function()
    require("mason").setup()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })
    return {
      ensure_installed = { "lua_ls", "clangd", "gopls", "rust_analyzer" },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["rust_analyzer"] = function()
          require("lspconfig").rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end,
          })
        end,
        ["gopls"] = function ()
          require("lspconfig").gopls.setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                usePlaceholders = true,
              }
            }
          })
        end
      },
    }
  end,
}
