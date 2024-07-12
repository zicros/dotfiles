######################
# Use gpg-agent instead of ssh agent
# Source: https://wiki.archlinux.org/title/GnuPG#SSH_agent

unset SSH_AGENT_PID
# The test involving the gnupg_SSH_AUTH_SOCK_by variable is for the case where
# the agent is started as gpg-agent --daemon /bin/sh, in which case the shell
# inherits the SSH_AUTH_SOCK variable from the parent
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

gpg-agent --homedir ${HOME}/.gnupg --daemon > /dev/null 2>&1

# We need SSH to update the TTY of gpg to that of the shell that is
# executing SSH. Checkout ~/.ssh/config for more information.

# Set the GPG_TTY and refresh the TTY in case user has switched into an X session as stated in gpg-agent(1).
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
