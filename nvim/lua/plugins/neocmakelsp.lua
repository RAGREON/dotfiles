return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "cmake" },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "neocmakelsp",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("neocmakelsp", {})
      vim.lsp.enable("neocmakelsp")
    end,
  },
}
