-- 언어와 무관한 UI 플러그인들
return {
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        version = "3.9.0",
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "whichkey")
            require("which-key").setup(opts)
        end,
    },
    -- nvim-tree: 파일 탐색기
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = require("configs.nvimtree")
    },
    -- flash.nvim: 빠르게 텍스트 이동하기 위한 플러그인
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            {
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        },
    },
    -- multicursors.nvim: 다중 커서 플러그인
    -- {
    --   "smoka7/multicursors.nvim",
    --   event = "VeryLazy",
    --   dependencies = {
    --     'smoka7/hydra.nvim',
    --   },
    --   opts = {},
    --   cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    --   keys = {
    --     {
    --       mode = { 'v', 'n' },
    --       '<Leader>m',
    --       '<cmd>MCstart<cr>',
    --       desc = 'Create a selection for selected text or word under the cursor',
    --     },
    --   },
    -- },
    -- telescope: 텍스트 검색 및 파일 탐색을 위한 플러그인
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "telescope-undo.nvim",
            "telescope-fzf-native.nvim",
            { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0", },
            "cbochs/grapple.nvim",
            "marskey/telescope-sg"
        },
        opts = require("configs.others").telescope(),
        config = function()
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("grapple")
            require('telescope').setup {
                extensions = {
                    ast_grep = {
                        command = {
                            "sg",
                            "--json=stream"
                        },
                        grep_open_files = false,
                        lang = nil,
                    }
                }
            }
        end,
    },

    -- telescope-fzf-native.nvim: telescope에서 fzf를 사용하기 위한 플러그인
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        module = "telescope._extensions.fzf",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },

    -- telescope-undo.nvim: telescope에서 undo 기록을 검색하기 위한 플러그인
    {
        "debugloop/telescope-undo.nvim",
        module = "telescope._extensions.undo",
    },
    -- smartcolumn.nvim: 컬러 컬럼을 필요할 때만 표시해주는 플러그인
    {
        "m4xshen/smartcolumn.nvim",
        event = "VeryLazy",
        opts = {
            disabled_filetypes = { "help", "text", "markdown", "nvdash" },
        }
    },
    -- nvim-spectre: find & replace 플러그인
    {
        "nvim-pack/nvim-spectre",
        cmd = { "Spectre" },
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- nvim-gomove: 블럭 단위로 이동시키기 위한 플러그인
    {
        "booperlv/nvim-gomove",
        keys = {
            { "<M-k>" },
            { "<M-j>" },
            { "<M-h>" },
            { "<M-l>" }
        },
        config = function()
            require("gomove").setup {
                map_default = true,
                reindent = true
            }
        end
    },
    -- grapple.nvim: 파일 단위 북마크 관리
    {
        "cbochs/grapple.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons", lazy = true }
        },
        opts = {
            scope = "git_branch",
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { ";",     "<cmd>Grapple toggle<cr>",          desc = "Grapple toggle tag" },
            { "<C-e>", "<cmd>Grapple toggle_tags<cr>",     desc = "Grapple open tags window" },
            { "H",     "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
            { "L",     "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
        },
    },
    -- portal.nvim: 빠른 이동 기능
    {
        "cbochs/portal.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "cbochs/grapple.nvim"
        },
    },
    -- marks.nvim: mark 강화
    {
        'chentoast/marks.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("marks").setup {
            }
        end
    }
}
