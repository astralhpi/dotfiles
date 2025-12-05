# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.hostname = "dotfiles-test"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Sync dotfiles source for testing
  config.vm.synced_folder ".", "/home/vagrant/dotfiles-source"

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    set -e

    echo "==> Installing prerequisites..."
    sudo apt-get update
    sudo apt-get install -y zsh git curl build-essential

    echo "==> Installing 1Password CLI..."
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
      sudo tee /etc/apt/sources.list.d/1password.list
    sudo apt-get update
    sudo apt-get install -y 1password-cli

    echo "==> Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

    echo "==> Installing mise..."
    curl https://mise.run | sh

    echo "==> Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y

    echo "==> Installing atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

    echo "==> Installing other tools..."
    sudo apt-get install -y tmux neovim fzf ripgrep fd-find zoxide

    echo "==> Setting zsh as default shell..."
    sudo chsh -s $(which zsh) vagrant

    echo ""
    echo "=========================================="
    echo "Provisioning complete!"
    echo ""
    echo "To test chezmoi:"
    echo "  vagrant ssh"
    echo "  op signin  # Login to 1Password first"
    echo "  ~/.local/bin/chezmoi init --source ~/dotfiles-source --apply"
    echo "=========================================="
  SHELL
end
