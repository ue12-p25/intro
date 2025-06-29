#!/bin/bash

# custom script to set up starship prompt for all students in a reasonable way

# only for windows for now
platform=

function for-windows-only() {
    case "$(uname -s)" in
        Linux*)
            if grep -q Microsoft /proc/version 2>/dev/null; then
                platform="wsl"
            else
                platform="linux"
            fi
            ;;
        Darwin*)
            platform="macos"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            platform="windows"
            ;;
    esac
    [[ "$platform" == "windows" ]] || {
        echo this script is for Windows only for now
        exit 1
    }
}

# this method does not work well, mintty uses some other font directory method...
# function download-font() {
#     local dir="$HOME/Downloads/Hack"
#     [[ -f "$dir/Hack.zip" ]] && {
#         echo "$dir/Hack.zip already here - destroy to force another download"
#         return
#     }
#     echo "Downloading Hack Nerd Font..."
#     mkdir -p "$dir"
#     cd "$dir"
#     curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
#     unzip Hack.zip
# }


# function install-font() {
#     local FONT_DIR="$HOME/AppData/Local/Microsoft/Windows/Fonts"
#     mkdir -p "$FONT_DIR"

#     declare -a FONTS=(
#         "HackNerdFontMono-Regular.ttf"
#         "HackNerdFontMono-Bold.ttf"
#     )

#     for font in "${FONTS[@]}"; do
#         cp "$HOME/Downloads/Hack/$font" "$FONT_DIR/"
#         powershell.exe -Command "New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts' -Name '$font (TrueType)' -PropertyType String -Value '$font'" 2>/dev/null
#     done

# }


# so let's use Courier New instead, which has the Nerd Font glyphs
function adopt-font-in-mintty() {
    echo "Adopting font in mintty..."
    local MINTTY_CONFIG="$HOME/.minttyrc"
    [[ -f "$MINTTY_CONFIG" ]] || touch "$MINTTY_CONFIG"
    echo "Font=Courier New" >> "$MINTTY_CONFIG"
    echo "FontHeight=16" >> "$MINTTY_CONFIG"

    echo "Installed Nerd Fonts locally."
}


function install-starship() {
    type starship >& /dev/null && { echo "Starship is already installed."; return; }
    echo "Installing starship..."
    conda install -y conda-forge::starship
}


function cat-starship-config() {
    cat << 'EOF'
format = """$directory\
$conda\
$python\
$git_branch\
$git_status\
\n\
$character\
"""


# we don't use pyenv but well, that's innocuous
[python]
symbol ="Py"
format = '[${symbol}${pyenv_prefix}(${version} )(\($virtualenv\) )]($style)'
# version_format = '${major}.${minor}'
version_format = '${raw}'

[conda]
symbol = '🅒'
format = '[$symbol$environment]($style) '
ignore_base = false

[git_branch]
symbol = '🌱'
format = '[$symbol$branch]($style) '

[git_status]
format = '🔄[\[$all_status$ahead_behind\]]($style) '
# ignore untracked files
untracked = ''
modified = "✎"
deleted = "🗑️"
staged = "+"

EOF
}


function configure-starship() {
    local config="$HOME/.config/starship.toml"
    [[ -f $config ]] && { echo "Starship configuration exists at $config - keeping it"; return; }
    local configdir=$(dirname "$config")
    [[ -d $configdir ]] || mkdir -p "$configdir"
    cat-starship-config > "$config"
}


function enable-starship-in-bash() {
    local bashrc="$HOME/.bashrc"
    if grep -q 'starship init bash' "$bashrc" 2> /dev/null; then
        echo "Starship prompt already enabled in bash."
        return
    fi
    [[ -f $bashrc ]] || touch "$bashrc"
    echo "Enabling Starship prompt in .bashrc"
    cat >> "$bashrc" << 'EOF'
##### begin by setup-starship.sh
# just in case we'd start from an odd place
cd
# add conda/bin to PATH
condabin="$(type -p conda 2>/dev/null | sed -e 's|scripts/conda|bin|i')"
export PATH="$PATH:$condabin"
# Enable Starship prompt
eval "$(starship init bash)"
##### end by setup-starship.sh
EOF
    # bash complains if there's only a .bashrc and no .bash_profile
    # and does create .bash_profile in that case
    # so we do the same to avoid the nasty alarming red message
    local profile="$HOME/.bash_profile"
    [[ -f $profile ]] || {
        echo "Creating $profile to avoid bash complaints..."
        cat > "$profile" << 'EOF'
[[ -f ~/.profile ]] && source ~/.profile
[[ -f ~/.bashrc ]] && source ~/.bashrc
EOF
    }
    echo "Starship prompt enabled in bash."
}


function restart-terminal() {
    echo "Restart your terminal to see the changes."
}


function main() {
    for-windows-only
    # download-font
    # install-font
    adopt-font-in-mintty
    install-starship
    configure-starship
    enable-starship-in-bash
    restart-terminal
}

# If no arguments, run main, otherwise run the provided command
[[ -z "$@" ]] && main || "$@"
