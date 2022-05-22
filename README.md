# ubuntu-20.04-config

## modules:

- zsh
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)
- [delta](https://github.com/dandavison/delta)
- [nautilus-terminal](https://github.com/flozz/nautilus-terminal)
- gnome-tweaks
- terminator
- tldr
- HTTPie
- rsync
- dconf-editor

```bash
sudo apt update && \
sudo apt install -y \
  gnome-tweaks \
  terminator \
  zsh \
  httpie \
  tldr \
  rsync \
  dconf-editor \
  fzf \
  bat 
```

# Font used for PyCharm & Terminator terminals:

- MesloLGS NF Regular

# Upgrade git to >2.35 to get `--force-if-includes` working

```bash
sudo add-apt-repository ppa:git-core/ppa -y && \
sudo apt-get update && \
sudo apt-get install git -y && \
git --version
```

# `powerlevel10k` customization

1. `POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION = '🏠'`

2. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

3. [zsh-suggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

# Open terminator here

https://askubuntu.com/a/1079882

# nautilus-terminal installation

```bash
sudo apt install python3-pip python3-nautilus python3-psutil && \
python3 -m pip install --user --upgrade nautilus_terminal && \
nautilus -q && \
nautilus-terminal --install-user
```

# exa installation

```bash
EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+') && \
curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip" && \
sudo unzip -q exa.zip bin/exa -d /usr/local && \
exa --version
```
