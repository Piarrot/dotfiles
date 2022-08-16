local silent = { silent = true }

local keymap = require("utils.keymap")

keymap("","<Space>","<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<leader>e", ":Lex 20<cr>")

--Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Move text up and down
keymap("n", "<A-Down>", "<Esc>:m +1<CR>")
keymap("n", "<A-Up>", "<Esc>:m -2<CR>")

-- Stay in indent mode
keymap("v", "<S-Tab>", "<gv")
keymap("v", "<Tab>", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", '"_dP')

-- Move text up and down
keymap("x", "<S-Down>", ":move '>+1<CR>gv-gv")
keymap("x", "<S-Up>", ":move '<-2<CR>gv-gv")
keymap("x", "<A-Down>", ":move '>+1<CR>gvi-gv")
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv")

--Duplicate line
keymap("n","<C-S-d>",":t")

--Copy to the clipboard
keymap("v","<C-c>",'"+y')
keymap("n","<C-S-c>",'"+yg_')
keymap("n","<C-c>",'"+yy')

-- Copy from the clipboard
keymap("n","<C-v>",'"+p')
keymap("n","<C-S-v>",'"+P')
keymap("v","<C-v>",'"+p')
keymap("v","<C-S-v>",'"+P')

-- Cut to the clipboard
keymap("n","<C-x>",'"+dd')
keymap("v","<C-x>",'"+d')

-- Quit 
keymap("i","q",'<Esc>:q<CR>')
keymap("v","q",':q<CR>')
keymap("n","q",':q<CR>')
keymap("i","<S-q>",'<Esc>:q!<CR>')
keymap("v","<S-q>",':q!<CR>')
keymap("n","<S-q>",':q!<CR>')

-- Save
keymap("n","<C-s>",':update<CR>')
keymap("i","<C-s>",'<Esc>:update<CR>')
keymap("v","<C-s>",':update<CR>')