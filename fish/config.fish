set -gx LC_ALL "en_US.UTF-8"
set -gx BASH_SILENCE_DEPRECATION_WARNING 1

#define XDG paths
set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME || set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_CACHE_HOME || set -gx XDG_CACHE_HOME $HOME/.cache
set -q XDG_STATE_HOME || set -gx XDG_STATE_HOME $HOME/.local/state

# define fish config paths
set -g FISH_CONFIG_DIR $XDG_CONFIG_HOME/fish
set -g FISH_CONFIG $FISH_CONFIG_DIR/config.fish
set -g FISH_CACHE_DIR /tmp/fish-cache

# load user config (functions/ is auto-loaded by Fish)
for file in $FISH_CONFIG_DIR/config/*.fish
    source $file &
end

# general bin paths
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path /usr/local/opt/curl/bin

#brew
fish_add_path /opt/homebrew/bin

#nvm
set -gx NVM_DIR $HOME/.config/nvm

#node.js / npm / npx
fish_add_path $HOME/.local/share/nvm/v24.13.0/bin

# c / c++
# c++
# export CPPFLAGS=-I/opt/X11/include
# export LDFLAGS="$LDFLAGS -L/usr/local/opt/zlib/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib -L/usr/local/opt/binutils/lib -L/opt/homebrew/lib"
# export CFLAGS="-I/usr/local/opt/zlib/include -I$(xcrun --show-sdk-path) $CFLAGS"
# export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/zlib/include -I/usr/local/opt/readline/include -I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include -I$(xcrun --show-sdk-path) -I/usr/local/opt/binutils/include -I/opt/homebrew/include"
# export LDFLAGS="$LDFLAGS -L/usr/local/opt/openblas/lib -L/usr/local/opt/lapack/lib"
# export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openblas/include -I/usr/local/opt/lapack/include"
set -gx USE_CCACHE 1
set -gx CCACHE_DIR $HOME/.ccache

#go
set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin

#wezterm
fish_add_path /Applications/WezTerm.app/Contents/MacOS

# neovim
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx VISUAL nvim

# postgresql
set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include"
fish_add_path /opt/homebrew/opt/libpq/bin

if status is-interactive
# Commands to run in interactive sessions can go here
end
