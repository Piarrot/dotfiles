function createCommand(command, action)
    vim.api.nvim_create_user_command(command, action, {})
end

return createCommand
