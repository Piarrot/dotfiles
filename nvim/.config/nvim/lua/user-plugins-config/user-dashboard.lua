local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
"██╗   ██╗██╗     ████████╗██╗  ██╗ █████╗ ██████╗",
"██║   ██║██║     ╚══██╔══╝██║  ██║██╔══██╗██╔══██╗",
"██║   ██║██║        ██║   ███████║███████║██████╔╝",
"██║   ██║██║        ██║   ██╔══██║██╔══██║██╔══██╗",
"╚██████╔╝███████╗   ██║   ██║  ██║██║  ██║██║  ██║",
" ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝",
}

dashboard.section.buttons.val = {
    dashboard.button( "<leader>e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "<leader>w", "  > Workspace", ":Telescope workspaces<CR>"),
    dashboard.button( "<leader>s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "<leader>u", "  > Update Plugins" , ":PackerSync<CR>"),
    dashboard.button( "<leader>q", "  > Quit NVIM", ":qa<CR>"),
}

local function info()
  --local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  local datetime = os.date(" %d-%m-%Y   %H:%M")
  local platform = ""
  --return string.format(" %d   v%d.%d.%d %s  %s", plugins, v.major, v.minor, v.patch, platform, datetime)
  return string.format(" v%d.%d.%d %s  %s", v.major, v.minor, v.patch, platform, datetime)
end

dashboard.section.footer.val = info()

alpha.setup(dashboard.opts)


-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
