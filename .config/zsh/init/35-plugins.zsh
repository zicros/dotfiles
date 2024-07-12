# Plugins are those that should be toggle-able depending on profile. Too lazy to implement that yet,
# so leaving as is.

# Allow override of plugins from specific profiles
if ! [[ -v plugins ]]; then
    # Default set of plugins
    plugins=()
fi

for plugin ($plugins); do
  source "$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh"
done
unset plugin

