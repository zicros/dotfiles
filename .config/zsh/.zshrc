# oh-my-zsh, while nice, sets too much default stuff for me. So implement the bare minimum.
export EDITOR=/usr/bin/nvim
export LANG=en_US.UTF-8

SCRIPT_ROOT=${0%/*}

# Only add to path if it's not in the path already.
# https://unix.stackexchange.com/questions/124444/how-can-i-cleanly-add-to-path
add_to_path() {
    case ":${PATH:=$1}:" in
        *:"$1":*) ;;
        *) PATH="$1:$PATH" ;;
    esac;
}

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    add_to_path "$HOME/.bin"
fi

# Deprecating the above
if [ -d "$HOME/.local/bin" ] ; then
    add_to_path "$HOME/.local/bin"
fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq "1" ]; then
    echo "Starting display ${DISPLAY}, XDG_VTNR ${XDG_VTNR}"
    exec startx
fi

if [[ -z "${ZSH_CONFIG}" ]]; then
    echo "Could not find ZSH configs, bootstrapping"
    source $HOME/.config/zsh/init/00-bootstrap.zsh
fi

# ZSH history
export HISTFILE=${ZSH_CONFIG}/.histfile

# The number of commands that are loaded into memory from the history file
export HISTSIZE=9999

# The number of commands that are stored in the zsh history file
export SAVEHIST=9999

# Add timestamp to history
setopt extended_history

# Immediately append to history
#setopt inc_append_history # This cannot be set when share_history is set
setopt share_history

# Don't display duplicate commands
setopt hist_find_no_dups

setopt nomatch
unsetopt autocd beep extendedglob

bindkey -v

# Lets compinstall find where it has written out zstyle statements for you last
# time so it can update them.
zstyle :compinstall filename '${ZSH_CONFIG}/.zshrc'

# Enable completion
autoload -Uz compinit
#autoload -U compaudit compinit zrecompile

ZSH_CUSTOM=${ZSH_CONFIG}
ZSH_CUSTOM_INIT=${ZSH_CUSTOM}/init

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

compinit

# Load all of your custom configurations from custom/
for config_file ("$ZSH_CUSTOM_INIT"/*.zsh(N)); do
    source "$config_file"
done
unset config_file

#######################
# Final things to do
cd
