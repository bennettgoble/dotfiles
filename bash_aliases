#!/usr/bin/env bash

if [[ $OSTYPE == 'linux-gnu' ]]; then
  alias ls='ls --color=auto'
elif [[ $OSTYPE == 'darwin' ]]; then
  alias ls='ls -G'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
