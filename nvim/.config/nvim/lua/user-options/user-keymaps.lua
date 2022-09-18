local keymap = require("utils.keymap")

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear after search
keymap("n", "<esc>", ":noh<cr>")

-- Telescope
keymap("n", "<leader>p", "<cmd>Telescope find_files hidden=true<cr>")
keymap("n", "<leader>b", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>f", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
keymap("n", "<F1>", "<cmd>Telescope help_tags<cr>")
keymap("n", "<leader>P", "<cmd>Telescope commands<cr>")

-- Terminal
keymap("n", "<leader>t", "<cmd>ToggleTerm<cr>")
keymap("n", "<leader>g", [[<cmd>TermExec cmd="lazygit"<cr>]])
keymap("v", "<leader>T", "<cmd>ToggleTermSendCurrentLine<cr>")

-- Navigation
keymap("n", "<C-Down>", "<C-w>j")
keymap("n", "<C-Up>", "<C-w>h")
keymap("n", "<C-Left>", "<C-w>k")
keymap("n", "<C-Right>", "<C-w>l")
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Resize with arrows
keymap("n", "<CS-Up>", ":resize -2<CR>")
keymap("n", "<CS-Down>", ":resize +2<CR>")
keymap("n", "<CS-Left>", ":vertical resize -2<CR>")
keymap("n", "<CS-Right>", ":vertical resize +2<CR>")

-- Stay in indent mode
keymap("v", "<S-Tab>", "<gv")
keymap("v", "<Tab>", ">gv")

-- Paste behaviour
keymap("v", "p", "\"_dP") -- Keep text after pasting, instead of replacing with removed text

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
keymap("n", "<c-d>", "yyp")
keymap("v", "<c-d>", "y'>p")

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
keymap("n", "<C-z>", ":u<CR>")
keymap("i", "<C-z>", "<esc>:u<CR>i")

-- Quit
keymap("v", "q", ":q<CR>")
keymap("n", "q", ":q<CR>")
keymap("v", "<S-q>", ":q!<CR>")
keymap("n", "<S-q>", ":q!<CR>")

-- Save
keymap("n", "<C-s>", ":update<CR>")
keymap("i", "<C-s>", "<Esc>:update<CR>")
keymap("v", "<C-s>", ":update<CR>")

keymap("n", "<leader>r", ":source $MYVIMRC<cr>", { silent = false })

-- Search and replace
keymap("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>")

return {
    on_lsp_attach = function()
        local lsp_buf = vim.lsp.buf
        local bufopts = { noremap = true, buffer = 0, silent = false }
        keymap("n", "K", lsp_buf.hover, bufopts)
        keymap("n", "gD", lsp_buf.declaration, bufopts)
        keymap("n", "gd", lsp_buf.definition, bufopts)
        keymap("n", "gi", lsp_buf.implementation, bufopts)
        keymap("n", "gt", lsp_buf.type_definition, bufopts)
        keymap("n", "<F2>", lsp_buf.rename, bufopts)
        keymap("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", bufopts)
        keymap("n", "<c-.>", lsp_buf.code_action, bufopts)
    end,
    on_term_attach = function()
        local bufopts = { noremap = true, buffer = 0, silent = true }
        keymap("t", "<leader><esc>", [[<C-\><C-n><cmd>q<cr>]], bufopts)
    end,
}
