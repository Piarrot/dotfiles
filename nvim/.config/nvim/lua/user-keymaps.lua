local silent = {
    silent = true
}

local keymap = require("utils.keymap")

keymap("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear after search
keymap("n", "<esc>", ":noh<cr>", silent)

-- Telescope
keymap("n","<C-Space>","<cmd>Telescope find_files<cr>")
keymap("n","<leader>b","<cmd>Telescope buffers<cr>")

-- Navigation
keymap("n", "<C-Down>", "<C-w>j")
keymap("n", "<C-Up>", "<C-w>h")
keymap("n", "<C-Right>", "<C-w>k")
keymap("n", "<C-Left>", "<C-w>l")
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Resize with arrows
keymap("n", "<CS-Up>", ":resize -2<CR>")
keymap("n", "<CS-Down>", ":resize +2<CR>")
keymap("n", "<CS-Left>", ":vertical resize -2<CR>")
keymap("n", "<CS-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
keymap("v", "<S-Tab>", "<gv")
keymap("v", "<Tab>", ">gv")

-- Paste behaviour
keymap("v", "p", '"_dP') -- Keep text after pasting, instead of replacing with removed text

-- Move text up and down
keymap("i", "<A-Up", "<Esc>:m .-2<CR>==i")
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==i")

keymap("n", "<A-Up>", ":m .-2<CR>==")
keymap("n", "<A-Down>", ":m .+1<CR>==")

keymap("v", "<A-Down>", "<cmd>m '<-2<CR>gv")
keymap("v", "<A-Up>", "<cmd>m '>+1<CR>gv")

keymap("x", "<A-Up>", ":move '<-2<CR>==")
keymap("x", "<A-Down>", ":move '>+1<CR>==")

-- Duplicate line
keymap("n", "<C-D>", "<cmd>t+0<cr>")
keymap("v", "<C-D>", "<cmd>'<t+0<cr>")

-- Copy to the clipboard
keymap("v", "<C-c>", "\"+y")
keymap("n", "<C-c>", "\"+yy")

-- Copy from the clipboard
keymap("n", "<C-v>", "\"+p")
keymap("v", "<C-v>", "\"+p")
keymap("i", "<C-v>", "<esc>\"+pi")

-- Cut to the clipboard
keymap("n", "<C-x>", "\"+dd")
keymap("v", "<C-x>", "\"+d")

-- Undo/Redo
keymap("n","<C-z>",":u<CR>")
keymap("i","<C-z>","<esc>:u<CR>i")

-- Quit 
keymap("v", "q", ':q<CR>')
keymap("n", "q", ':q<CR>')
keymap("v", "<S-q>", ':q!<CR>')
keymap("n", "<S-q>", ':q!<CR>')

-- Save
keymap("n", "<C-s>", ':update<CR>')
keymap("i", "<C-s>", '<Esc>:update<CR>')
keymap("v", "<C-s>", ':update<CR>')

