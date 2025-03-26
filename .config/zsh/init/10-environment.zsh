if [[ is_wsl ]]; then
    export WIN_HOME=$(grep -iPo "(?<=:)/mnt/[^:]+/users/[^/]+(?=/AppData/Local/)" <<< $PATH | head -n1)
fi
