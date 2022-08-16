yay --noconfirm -S --needed neovim
stow nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'