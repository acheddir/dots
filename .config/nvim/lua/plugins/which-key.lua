return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({
            preset = "helix",
            icons = {
                rules = false,
            },
        })
        wk.add({
            {
                mode = { "n", "v" },
                { "<leader>a", group = "ai" },
                { "<leader><Tab>", group = "tabs" },
                { "<leader>b", group = "buffer" },
                { "<leader>c", group = "code" },
                { "<leader>d", group = "debug" },
                { "<leader>e", group = "explorer" },
                { "<leader>f", group = "file/find" },
                { "<leader>g", group = "git" },
                { "<leader>o", group = "obsidian" },
                { "<leader>r", group = "run" },
                { "<leader>rl", group = "lua" },
                { "<leader>rs", group = "shell" },
                { "<leader>s", group = "search" },
                { "<leader>t", group = "toggle" },
                { "<leader>v", group = "diff" },
                { "<leader>x", group = "diagnostics/quickfix" },
                { "<leader>z", group = "windows" },
            },
        })
    end,
}
