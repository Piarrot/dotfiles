local opt = {
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 1,
    completeopt = {"menuone", "noselect"},
    conceallevel = 0,
    fileencoding = "utf-8",
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    showmode = false,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    termguicolors = true,
    undofile = true,
    updatetime = 300,
    writebackup = false,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    cursorline = true,
    number = true,
    relativenumber = false,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    scrolloff = 8,
    sidescrolloff = 8
}

for k, v in pairs(opt) do
    vim.opt[k] = v
end

