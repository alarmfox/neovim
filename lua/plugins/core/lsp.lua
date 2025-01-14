return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    require("mason").setup({})

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then return end

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Jump to declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Jump to definition" })

        vim.keymap.set("n", "<leader>v", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
        end, { desc = "Toggle inlay hints" })

        if client.supports_method('textDocument/formatting', args.buf) then
          -- Format the current buffer on save
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
        if client.supports_method('textDocument/inlayHint', args.buf) then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf, id = client.id })
        end
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    require("mason-lspconfig").setup({
      automatic_installation = false,
      ensure_installed = {
        -- lsp
        "lua_ls",
        "clangd",
        "gopls",
        "rust_analyzer",
        "html",
        "bashls",
        "ts_ls",
      },

      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function(name)
          require("lspconfig")[name].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                telemetry = {
                  enable = false,
                },
              },
            },
          })
        end,

        ["clangd"] = function(name)
          require("lspconfig")[name].setup({
            capabilities = capabilities,
            on_attach = function(_, _)
              vim.keymap.set(
                "n",
                "<leader>ch",
                "<cmd>ClangdSwitchSourceHeader<cr>",
                { desc = "Switch Source/Header (C/C++)" }
              )
            end,
            cmd = {
              "clangd",
              "-j=4",
              "--background-index",
              "--clang-tidy",
              "--completion-style=detailed",
              "--header-insertion=never",
            },
            init_options = {
              completeUnimported = true,
              clangdFileStatus = true,
            },
          })
        end,
      },
    })
  end,
}
