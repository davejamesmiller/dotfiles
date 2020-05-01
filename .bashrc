#===============================================================================
# Setup
#===============================================================================

#---------------------------------------
# Safety checks
#---------------------------------------

# Only load this file once
[[ -n $BASHRC_SOURCED ]] && return
BASHRC_SOURCED=true

# Only load in interactive shells
[[ -z $PS1 ]] && return


#---------------------------------------
# Umask
#---------------------------------------

if [[ $(umask) = 0000 ]]; then
    if ~/.bin/is-root-user; then
        umask 022
    else
        umask 002
    fi
fi


#---------------------------------------
# Third party scripts
#---------------------------------------

# Auto-completion - seems to be loaded automatically on some servers but not on others
shopt -s extglob
[[ -f /etc/bash_completion ]] && source /etc/bash_completion

# fzf - fuzzy finder
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Google Cloud Shell
[[ -f /google/devshell/bashrc.google ]] && source /google/devshell/bashrc.google

# lesspipe
[[ -x /usr/bin/lesspipe ]] && eval "$(/usr/bin/lesspipe)"

# Python virtualenv
if [[ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]]; then
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# Ruby rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    rvm_project_rvmrc=0
    source "$HOME/.rvm/scripts/rvm"
fi

# The Fuck
command -v thefuck &>/dev/null && eval $(thefuck --alias)


#===============================================================================
# Settings
#===============================================================================

export EDITOR='vim'
export GEDITOR="$EDITOR"
export HISTIGNORE='&'
export LESS='FRX'
export LS_COLORS='rs=0:fi=01;37:di=01;33:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
export PAGER='less'
export PGDATABASE='postgres'
export QUOTING_STYLE='literal'
export VISUAL="$EDITOR"

if [ -z "$DISPLAY" ] && is-wsl; then
    export DISPLAY='localhost:0.0'
fi

if [ -z "$XAUTHORITY" ]; then
    export XAUTHORITY="$HOME/.Xauthority"
fi

set completion-ignore-case on

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend
shopt -s lithist
shopt -s histreedit
shopt -s histverify
shopt -s no_empty_cmd_completion

stty -ixon # Disable Ctrl-S
tabs -4


#---------------------------------------
# Path
#---------------------------------------

# Note: The ones lower down take precedence
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.rvm/bin:$PATH"
PATH="$HOME/.yarn/bin:$PATH"

PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.composer/vendor/bin:$PATH"
PATH="$HOME/.composer/packages/vendor/bin:$PATH"

PATH="$HOME/.bin:$PATH"

# For tab completion with sudo
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

export PATH


#---------------------------------------
# Prompt
#---------------------------------------

PROMPT_COMMAND='history -a'
PS1="\$(_prompt)"

prompt_color=''
prompt_command=''
prompt_default=''
prompt_message=''

if [[ -z $prompt_default ]] && is-root-user && ! is-docker; then
    prompt_color='bg-red'
    prompt_default='Logged in as ROOT!'
fi

if is-wsl; then
    prompt_hostname=$(hostname | tr '[:upper:]' '[:lower:]')
else
    prompt_hostname=$(hostname -f)
fi


#===============================================================================
# Aliases
#===============================================================================

alias a2disconf='maybe-sudo a2disconf'
alias a2dismod='maybe-sudo a2dismod'
alias a2dissite='maybe-sudo a2dissite'
alias a2enconf='maybe-sudo a2enconf'
alias a2enmod='maybe-sudo a2enmod'
alias a2ensite='maybe-sudo a2ensite'
alias acs='apt search'
alias acsh='apt show'
alias addgroup='maybe-sudo addgroup'
alias adduser='maybe-sudo adduser'
alias agi='maybe-sudo apt install'
alias agr='maybe-sudo apt remove'
alias agar='maybe-sudo apt autoremove'
alias agu='maybe-sudo apt update && maybe-sudo apt full-upgrade'
alias agupdate='maybe-sudo apt update'
alias agupgrade='maybe-sudo apt upgrade'
alias apt='maybe-sudo apt'
alias apt-add-repository='maybe-sudo apt-add-repository'

alias b='c -'

alias chmox='chmod'
alias com='composer'
alias cp='cp -i'

alias d='docker'
alias db='docker build'
alias dc='docker-compose'
alias dpkg-reconfigure='maybe-sudo dpkg-reconfigure'
alias dr='docker run'
alias dri='docker run -it'

alias g='git'
alias grep="$(command -v grep-less)" # command -v makes it work with sudo
alias groupadd='maybe-sudo groupadd'
alias groupdel='maybe-sudo groupdel'
alias groupmod='maybe-sudo groupmod'

alias history-time='HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] " history'
alias host='_domain-command host'

alias ide='t ide-helper'

alias l="ls -hFl --color=always --hide=*.pyc --hide=*.sublime-workspace"
alias la="ls -hFlA --color=always --hide=*.pyc --hide=*.sublime-workspace"
alias ls="ls -hF --color=always --hide=*.pyc --hide=*.sublime-workspace"
alias lsa="ls -hFA --color=always --hide=*.pyc --hide=*.sublime-workspace"

alias mfs='art migrate:fresh --seed'

alias nslookup='_domain-command nslookup'

alias php5dismod='maybe-sudo php5dismod'
alias php5enmod='maybe-sudo php5enmod'
alias phpdismod='maybe-sudo phpdismod'
alias phpenmod='maybe-sudo phpenmod'
alias poweroff='maybe-sudo poweroff'
alias pow='maybe-sudo poweroff'
alias pu='phpunit'

alias reboot='maybe-sudo reboot'
alias reload='exec bash -l'
alias rm='rm -i'

alias service='maybe-sudo service'
alias shutdown='maybe-sudo poweroff'
alias snap='maybe-sudo snap'
alias sshstop='ssh -O stop'
alias storm='phpstorm'
alias sudo='sudo ' # Expand aliases
alias s='s '

alias tree='tree -C'

alias u='c ..'
alias uu='c ../..'
alias uuu='c ../../..'
alias uuuu='c ../../../..'
alias uuuuu='c ../../../../..'
alias uuuuuu='c ../../../../../..'

alias ufw='maybe-sudo ufw'
alias updatedb='maybe-sudo updatedb'
alias useradd='maybe-sudo useradd'
alias userdel='maybe-sudo userdel'
alias usermod='maybe-sudo usermod'

alias v='vagrant'

alias watch='watch --color '
alias whois='_domain-command whois'

alias yum='maybe-sudo yum'


#---------------------------------------
# Windows-specific aliases
#---------------------------------------

if is-wsl; then
    alias multipass='multipass.exe'
    alias explorer='explorer.exe'
fi


#===============================================================================
# Functions
#===============================================================================

c() {
    # 'cd' and 'ls'
    if [[ $@ != . ]]; then
        cd "$@" >/dev/null || return
    fi
    _ls-current-directory
}

cd() {
    command cd "$@" && \
        _record-last-directory
}

cg() {
    # cd to git root

    # Look in parent directories
    path="$(git rev-parse --show-toplevel 2>/dev/null)"

    # Look in child directories
    if [[ -z $path ]]; then
        path="$(find . -mindepth 2 -maxdepth 2 -type d -name .git 2>/dev/null)"
        if [[ $(echo "$path" | wc -l) -gt 1 ]]; then
            echo "Multiple repositories found:" >&2
            echo "$path" | sed 's/^.\//  /g; s/.git$//g' >&2
            return 2
        else
            path="${path%/.git}"
        fi
    fi

    # Go to the directory, if found
    if [[ -z $path ]]; then
        echo "No Git repository found in parent directories or immediate children" >&2
        return 1
    fi

    c "$path"
}

composer() {
    if dir="$(findup -x scripts/composer.sh)"; then
        "$dir/scripts/composer.sh" "$@"
    else
        command composer "$@"
    fi
}

cw() {
    # cd to web root
    if [[ -d /vagrant ]]; then
        c /vagrant
    elif [[ -d ~/repo ]]; then
        c ~/repo
    elif [[ -d /home/www ]]; then
        c /home/www
    elif is-root-user && [[ -d /home ]]; then
        c /home
    elif [[ -d /var/www ]]; then
        c /var/www
    elif is-wsl; then
        c "$(wsl-mydocs-path)"
    else
        c ~
    fi
}

cwc() {
    # cd to wp-content/
    wp_content=$(_find-wp-content) || return
    c $wp_content
}

cwp() {
    # cd to WordPress plugins
    wp_content=$(_find-wp-content) || return
    if [ -d $wp_content/plugins ]; then
        c $wp_content/plugins
    else
        echo "Cannot find wp-content/plugins/ directory" >&2
        return 1
    fi
}

cwt() {
    # cd to WordPress theme
    wp_content=$(_find-wp-content) || return
    if [ -d $wp_content/themes ]; then
        wp_theme=$(find $wp_content/themes -mindepth 1 -maxdepth 1 -type d -not -name twentyten -not -name twentyeleven)
        if [ $(echo "$wp_theme" | wc -l) -eq 1 ]; then
            # Only 1 non-default theme found - assume we want that
            c $wp_theme
        else
            # 0 or 2+ themes found - go to the main directory
            c $wp_content/themes
        fi
    else
        echo "Cannot find wp-content/themes/ directory" >&2
        return 1
    fi
}

dump-path() {
    echo -e "${PATH//:/\\n}"
}

git() {
    if [[ $# -gt 0 ]]; then
        command git "$@"
    else
        command git status
    fi
}

gs() {
    if [[ $# -eq 0 ]]; then
        # 'gs' typo -> 'g s'
        g s
    else
        command gs "$@"
    fi
}

hacked() {
    # Switch a Composer package to dist mode
    # Has to be a function because it deletes & recreates the working directory
    if [ "$(basename "$(dirname "$(dirname "$PWD")")")" != "vendor" ]; then
        echo "Not in a Composer vendor directory" >&2
        return 1
    fi

    if [ ! -e .git ]; then
        echo "Not in development mode" >&2
        return 1
    fi

    if [ -n "$(git status --porcelain)" ]; then
        echo "There are uncommitted changes" >&2
        return 1
    fi

    ask "Delete this directory and reinstall in production mode?" Y || return

    local package="$(basename "$(dirname "$PWD")")/$(basename "$PWD")"
    local oldpwd="${OLDPWD:-}"
    local pwd="$PWD"

    # Delete the dev version
    cd ../../..
    rm -rf "$pwd"

    # Install the dist version
    composer update --prefer-dist "$package"

    # Go back to that directory + restore "cd -" path
    cd "$pwd"
    OLDPWD="$oldpwd"
}

hackit() {
    # Switch a Composer package to dev (source) mode
    # Has to be a function because it deletes & recreates the working directory
    if [ "$(basename "$(dirname "$(dirname "$PWD")")")" != "vendor" ]; then
        echo "Not in a Composer vendor directory" >&2
        return 1
    fi

    if [ -e .git ]; then
        echo "Already in development mode" >&2
        return 1
    fi

    ask "Delete this directory and reinstall in development mode?" Y || return

    local package="$(basename "$(dirname "$PWD")")/$(basename "$PWD")"
    local oldpwd="${OLDPWD:-}"
    local pwd="$PWD"

    # Delete the dist version
    cd ../../..
    rm -rf "$pwd"

    # Install the dev version
    composer update --prefer-source "$package"

    # Go back to that directory + restore "cd -" path
    cd "$pwd"
    OLDPWD="$oldpwd"

    # Switch to the latest development version
    # TODO: Detect when 'master' is not the main branch?
    git checkout master
}

man() {
    # http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
        command man "$@"
}

mark() {
    mkdir -p $HOME/.marks
    local mark="${1:-$(basename "$PWD")}"

    if ! [[ $mark =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo "Invalid mark name"
        return 1
    fi

    ln -sn "$(pwd)" "$HOME/.marks/$mark" && \
        alias $mark="c -P '$mark'"
}

marks() {
    command ls -l --color=always --classify "$HOME/.marks" | \
        sed '1d;s/  / /g' | \
        cut -d' ' -f9-
}

md() {
    mkdir -p "$1" && cd "$1"
}

mv() {
    # 'mv' - interactive if only one filename is given
    # https://gist.github.com/premek/6e70446cfc913d3c929d7cdbfe896fef
    if [ "$#" -ne 1 ]; then
        command mv -i "$@"
    elif [ ! -f "$1" ]; then
        command file "$@"
    else
        read -p "Rename to: " -ei "$1" newfilename &&
            [ -n "$newfilename" ] &&
            mv -iv "$1" "$newfilename"
    fi
}

php() {
    if dir="$(findup -x scripts/php.sh)"; then
        "$dir/scripts/php.sh" "$@"
    else
        command php "$@"
    fi
}

phpstorm() {
    # Automatically launch the current project, if possible, and run in the background
    if [ $# -gt 0 ]; then
        command phpstorm "$@" &>> ~/.cache/phpstorm.log &
    elif [ -d .idea ]; then
        command phpstorm "$PWD" &>> ~/.cache/phpstorm.log &
    else
        command phpstorm &>> ~/.cache/phpstorm.log &
    fi
}

prompt() {
    prompt_color=''

    while [[ -n $1 ]]; do
        case "$1" in
            # Stop parsing parameters
            --)         shift; break ;;

            # Presets
            -l|--live)     prompt_color='bg-red' ;;
            -s|--staging)  prompt_color='bg-yellow black' ;;
            -d|--dev)      prompt_color='bg-green black' ;;
            -x|--special)  prompt_color='bg-blue' ;;

            # Other colours/styles (see ~/.bash/color.bash)
            --*)        prompt_color="$prompt_color ${1:2}" ;;

            # Finished parsing parameters
            *)          break ;;
        esac

        shift
    done

    prompt_message="$@"
}

status() {
    # Show the result of the last command
    local status=$?

    if [[ $status -eq 0 ]]; then
        color bg-lgreen black 'Success'
    else
        color bg-red lwhite "Failed with code $status"
    fi

    return $status
}

sudo() {
    # Add additional safety checks for cp, mv, rm
    if [ "$1" = "cp" -o "$1" = "mv" -o "$1" = "rm" ]; then
        exe="$1"
        shift
        command sudo "$exe" -i "$@"
    else
        command sudo "$@"
    fi
}

systemctl() {
    if [ "$1" = "list-units" ]; then
        # The 'list-units' subcommand is used by tab completion
        command systemctl "$@"
    else
        command maybe-sudo systemctl "$@"
    fi
}

unmark() {
    local mark="${1:-$(basename "$PWD")}"

    if [[ -L $HOME/.marks/$mark ]]; then
        rm -f "$HOME/.marks/$mark" && unalias $mark
    else
        echo "No such mark: $mark" >&2
    fi
}

yarn() {
    if [ "$1" = "update" ]; then
        # yarn run v1.19.1
        # error Command "update" not found.
        # info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
        shift
        command yarn upgrade "$@"
    else
        command yarn "$@"
    fi
}


#---------------------------------------
# Helper functions
#---------------------------------------

# These are in separate files because they are used by other scripts too
source $HOME/.bash/ask.sh
source $HOME/.bash/color.bash

_domain-command() {
    command="$1"
    shift

    # Accept URLs and convert to domain name only
    domain=$(echo "$1" | sed 's#https\?://\([^/]*\).*/#\1#')

    if [[ -n $domain ]]; then
        shift
        command $command "$domain" "$@"
    else
        command $command "$@"
    fi
}

_find-wp-content() {
    if dir=$(findup -d wp-content); then
        echo "$dir/wp-content"
    elif dir=$(findup -d www/wp-content); then
        echo "$dir/www/wp-content"
    else
        echo "Cannot find wp-content/ directory" >&2
        return 1
    fi
}

_ls-current-directory() {
    echo
    echo -en "\033[4;1m"
    echo $PWD
    echo -en "\033[0m"
    ls -hF --color=always --hide=*.pyc --hide=*.sublime-workspace
}

_prompt() {
    # Update the window title (no output)
    _prompt-titlebar

    # Blank line
    echo

    # Message
    local message="${prompt_message:-$prompt_default}"
    if [[ -n $message ]]; then
        local spaces=$(printf '%*s\n' $(( $COLUMNS - ${#message} - 1 )) '')
        color lwhite bg-magenta $prompt_color -- " $message$spaces"
    fi

    # Information
    color -n lblack '['
    color -n lred "$USER"
    color -n lblack '@'
    color -n lgreen "$prompt_hostname"
    color -n lblack ':'
    _prompt-pwd-git
    color -n lblack ' at '
    color -n white "$(date +%H:%M:%S)"
    color -n lblack ']'
    echo

    # Prompt
    color -n lred '$'
    echo -n ' '
}

_prompt-pwd-git() {
    local root

    # Look for .git directory
    if ! root=$(findup -d .git); then
        # No .git found - just show the working directory
        color -n lyellow "$PWD"
        return
    fi

    # Display working directory & highlight the git root in a different colour
    local relative=${PWD#$root}
    if [[ $relative = $PWD ]]; then
        color -n lyellow "$PWD"
    else
        color -n lyellow "$root"
        color -n lcyan "$relative"
    fi

    # Branch/tag/commit
    local branch=$(command git branch --no-color 2>/dev/null | sed -nE 's/^\* (.*)$/\1/p')
    color -n lblack ' on '
    color -n lmagenta "$branch"

    # Status (only the most important one, to make it easy to understand)
    if [[ -f "$root/.git/MERGE_HEAD" ]]; then
        color -n lcyan ' (merging)'
    elif [[ -f "$root/.git/rebase-apply/applying" ]]; then
        color -n lcyan ' (applying)'
    elif [[ -d "$root/.git/rebase-merge" || -d "$root/.git/rebase-apply/rebase-apply" ]]; then
        color -n lcyan ' (rebasing)'
    elif [[ -f "$root/.git/CHERRY_PICK_HEAD" ]]; then
        color -n lcyan ' (cherry picking)'
    elif [[ -f "$root/.git/REVERT_HEAD" ]]; then
        color -n lcyan ' (reverting)'
    elif [[ -f "$root/.git/BISECT_LOG" ]]; then
        color -n lcyan ' (bisecting)'
    elif [[ -n $(git status --porcelain) ]]; then
        color -n lcyan ' (modified)'
    elif [[ -f "$root/.git/logs/refs/stash" ]]; then
        color -n lcyan ' (stashed)'
    else
        local gstatus=$(git status --porcelain=2 --branch)
        local ahead behind
        read -r ahead behind < <(echo "$gstatus" | sed -nE 's/^# branch\.ab \+([0-9]+) \-([0-9]+)$/\1\t\2/p')

        if [[ $ahead -gt 0 ]]; then
            if [[ $behind -gt 0 ]]; then
                color -n lcyan ' (diverged)'
            else
                color -n lcyan " ($ahead ahead)"
            fi
        else
            if [[ $behind -gt 0 ]]; then
                color -n lcyan " ($behind behind)"
            elif ! echo "$gstatus" | grep -qE '^# branch.upstream '; then
                color -n fg-245 ' (no upstream)'
            fi
        fi
    fi
}

_prompt-titlebar() {
    echo -ne "\001\e]2;"
    if [[ -n $prompt_message ]]; then
        echo -n "[$prompt_message] "
    fi
    echo -n "$USER@$prompt_hostname:$PWD"
    echo -ne "\a\002"
}

_record-last-directory() {
    pwd > ~/.bash_lastdirectory
}


#===============================================================================
# Configure Bash environment
#===============================================================================

#---------------------------------------
# SSH agent
#---------------------------------------

# wsl-ssh-pageant - https://github.com/benpye/wsl-ssh-pageant
if is-wsl; then
    temp=$(wsl-temp-path)
    if [ -f "$temp/wsl-ssh-pageant.sock" ]; then
        export SSH_AUTH_SOCK="$temp/wsl-ssh-pageant.sock"
    fi
fi

# Workaround for losing SSH agent connection when reconnecting tmux
# It doesn't work on WSL, but isn't necessary when using wsl-ssh-pageant
if ! is-wsl; then
    link="$HOME/.ssh/ssh_auth_sock"
    if [[ $SSH_AUTH_SOCK != $link ]] && [[ -S $SSH_AUTH_SOCK ]]; then
        ln -nsf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
    fi
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
fi


#---------------------------------------
# Bash completion
#---------------------------------------

if declare -f _completion_loader &>/dev/null; then

    _completion_loader_custom() {
        # Custom completions
        local dir="$HOME/.bash_completion.d"

        for file in "${1##*/}" _"${1##*/}"; do
            file="$dir/$file"
            source "$file" &>/dev/null && return 124
        done

        # Standard completions or file listing
        _completion_loader "$@"
    }

    complete -D -F _completion_loader_custom

else

    # Lazy-load not available
    for file in $HOME/.bash_completion.d/*; do
        source "$file"
    done

fi


#---------------------------------------
# fzf - fuzzy finder
#---------------------------------------

# https://github.com/junegunn/fzf
_fzf_compgen_path() {
    echo "$1"
    command find -L "$1" \
        -name .cache -prune -o \
        -name .git -prune -o \
        -name .hg -prune -o \
        -name .svn -prune -o \
        \( -type d -o -type f -o -type l \) \
        -not -path "$1" \
        -print \
        2>/dev/null \
    | sed 's#^\./##'
}

_fzf_compgen_dir() {
    command find -L "$1" \
        -name .cache -prune -o \
        -name .git -prune -o \
        -name .hg -prune -o \
        -name .svn -prune -o \
        -type d \
        -not -path "$1" \
        -print \
        2>/dev/null \
    | sed 's#^\./##'
}

export FZF_DEFAULT_COMMAND='
    find -L . \
        -name .cache -prune -o \
        -name .git -prune -o \
        -name .hg -prune -o \
        -name .svn -prune -o \
        \( -type d -o -type f -o -type l \) \
        -print \
        2>/dev/null \
    | sed "s#^./##"
'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_T_OPTS="
    --select-1
    --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'
"

export FZF_ALT_C_OPTS="
    --preview 'tree -C {} | head -200'
"

export FZF_COMPLETION_TRIGGER='#'

if declare -f _fzf_setup_completion &>/dev/null; then
    _fzf_setup_completion dir c
    _fzf_setup_completion dir l
    _fzf_setup_completion dir la
    _fzf_setup_completion dir ll
    _fzf_setup_completion dir ls
    _fzf_setup_completion path e
    _fzf_setup_completion path g
    _fzf_setup_completion path git
fi


#---------------------------------------
# Load marks
#---------------------------------------

if [ -d "$HOME/.marks" ]; then
    for mark in $HOME/.marks/*; do
        alias $mark="c -P $mark"
    done
fi


#===============================================================================
# Outputs
#===============================================================================

# Show the MOTD inside tmux, since it won't be shown if we load tmux
# immediately from ssh instead of Bash
if [[ -n $TMUX && -f /run/motd.dynamic ]]; then
    cat /run/motd.dynamic
    hr="$(printf "%${COLUMNS}s" | tr ' ' -)"
    echo -e "\033[30;1m$hr\033[0m"
fi

# Automatic updates
~/.dotfiles/auto-update

# Change to the last visited directory, unless we're already in a different directory
if [[ $PWD = $HOME ]]; then
    if [[ -f ~/.bash_lastdirectory ]]; then
        # Throw away errors about that directory not existing (any more)
        command cd "$(cat ~/.bash_lastdirectory)" 2>/dev/null
    else
        # If this is the first login, try going to the web root instead
        cw &>/dev/null
    fi
fi

# Load custom settings for this machine/account
[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local

# Finally, show the current directory name & contents
_ls-current-directory
