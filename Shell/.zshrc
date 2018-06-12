#######################################################
#######      Anarchy ZSH configuration file     #######
#######################################################

#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my ZSH configurations and aliases
#
#  Sections:
#  1.  Environment Configuration
#  2.  Make Terminal Better (remapping defaults and adding functionality)
#  3.  Networking
#  4.  System Operations & Information
#  5.  Git
#  6.  Web Development
#  7.  Sources
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

    # Path to your oh-my-zsh installation.
    # ZSH=/usr/share/oh-my-zsh/

    # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
    # ZSH_THEME="mytheme"

    # Uncomment the following line to use case-sensitive completion.
    # CASE_SENSITIVE="true"

    # Uncomment the following line to disable bi-weekly auto-update checks.
    # DISABLE_AUTO_UPDATE="true"

    # Uncomment the following line to change how often to auto-update (in days).
    # export UPDATE_ZSH_DAYS=13

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Would you like to use another custom folder than $ZSH/custom?
    # ZSH_CUSTOM=/path/to/new-custom-folder

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    # plugins=(git zsh-syntax-highlighting)

    # Compilation flags
    # export ARCHFLAGS="-arch x86_64"

    # You may need to manually set your language environment
    export LANG=fr_FR.UTF-8

    # Set Paths (https://wiki.archlinux.org/index.php/Xhost)
    # xhost +local:
    # xhost +localhost

    # Composer
    export PATH="$HOME/.config/composer/vendor/bin:$PATH"

    # ELECTRON_TRASH=trash-cli atom
    # $HOME/.config/composer/vendor/bin

    # Mailcatcher
    # export PATH="$HOME/.gem/ruby/2.4.0/bin:$PATH"

    # Set Default Editor (change 'atom' to 'nano' if you want the default editor)
    export EDITOR="atom"

    # Grep colors to highlight matches
    # export GREP_OPTIONS='--color=auto'

    ### Set/unset ZSH options
    #########################
    # setopt NOHUP
    # setopt NOTIFY
    # setopt NO_FLOW_CONTROL
    setopt INC_APPEND_HISTORY SHARE_HISTORY
    setopt APPEND_HISTORY
    # setopt AUTO_LIST
    # setopt AUTO_REMOVE_SLASH
    # setopt AUTO_RESUME
    unsetopt BG_NICE
    setopt CORRECT
    setopt EXTENDED_HISTORY
    # setopt HASH_CMDS
    setopt MENUCOMPLETE
    setopt ALL_EXPORT

    ### Set/unset  shell options
    ############################
    setopt   notify globdots correct pushdtohome cdablevars autolist
    setopt   correctall autocd recexact longlistjobs
    setopt   autoresume histignoredups pushdsilent
    setopt   autopushd pushdminus extendedglob rcquotes mailwarning
    unsetopt bgnice autoparamslash

    ### Autoload zsh modules when they are referenced
    #################################################
    autoload -U history-search-end
    zmodload -a zsh/stat stat
    zmodload -a zsh/zpty zpty
    zmodload -a zsh/zprof zprof
    #zmodload -ap zsh/mapfile mapfile
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end

    ### Set variables
    #################
    PATH="/usr/local/bin:/usr/local/sbin/:$PATH"
    HISTFILE=$HOME/.zhistory
    HISTSIZE=1000
    SAVEHIST=1000
    HOSTNAME="`hostname`"
    LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

    ### Load colors
    ###############
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
    done

    ### Set prompt
    ##############
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
    PS1="[%(!.${PR_RED}%n.$PR_LIGHT_YELLOW%n)%(!.${PR_LIGHT_YELLOW}@.$PR_RED@)$PR_NO_COLOR%(!.${PR_LIGHT_RED}%U%m%u.${PR_LIGHT_GREEN}%U%m%u)$PR_NO_COLOR:%(!.${PR_RED}%2c.${PR_BLUE}%2c)$PR_NO_COLOR]%(?..[${PR_LIGHT_RED}%?$PR_NO_COLOR])%(!.${PR_LIGHT_RED}#.${PR_LIGHT_GREEN}$) "
    RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
    unsetopt ALL_EXPORT

    ### Set alias
    #############
    alias ll='ls -al'
    alias ls='ls --color=auto '

    ### Bind keys
    #############
    autoload -U compinit
    compinit
    bindkey "^?" backward-delete-char
    bindkey '^[OH' beginning-of-line
    bindkey '^[OF' end-of-line
    bindkey '^[[5~' up-line-or-history
    bindkey '^[[6~' down-line-or-history
    bindkey "^[[A" history-beginning-search-backward-end
    bindkey "^[[B" history-beginning-search-forward-end
    bindkey "^r" history-incremental-search-backward
    bindkey ' ' magic-space    # also do history expansion on space
    bindkey '^I' complete-word # complete on tab, leave expansion to _expand
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
    zstyle ':completion:*' menu select=1 _complete _ignored _approximate
    zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

    # Completion Styles

    # list of completers to use
    zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

    # allow one error for every three characters typed in approximate completer
    zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*' tag-order all-expansions

    # formatting and messages
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:messages' format '%d'
    zstyle ':completion:*:warnings' format 'No matches for: %d'
    zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
    zstyle ':completion:*' group-name ''

    # match uppercase from lowercase
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # command for process lists, the local web server details and host completion
    # on processes completion complete all user processes
    zstyle ':completion:*:processes' command 'ps -au$USER'

    ## add colors to processes for kill completion
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

    #zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
    #zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
    #
    #NEW completion:
    # 1. All /etc/hosts hostnames are in autocomplete
    # 2. If you have a comment in /etc/hosts like #%foobar.domain,
    #    then foobar.domain will show up in autocomplete!
    zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
    # Filename suffixes to ignore during completion (except after rm command)
    zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
    # the same for old style completion
    #fignore=(.o .c~ .old .pro)

    # ignore completion functions (until the _ignored completer)
    zstyle ':completion:*:functions' ignored-patterns '_*'
    zstyle ':completion:*:*:*:users' ignored-patterns \
      adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
      named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
      rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
      avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
      firebird gnats haldaemon hplip irc klog list man cupsys postfix\
      proxy syslog www-data mldonkey sys snort
    # SSH Completion
    zstyle ':completion:*:scp:*' tag-order \
    files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
    zstyle ':completion:*:scp:*' group-order \
    files all-files users hosts-domain hosts-host hosts-ipaddr
    zstyle ':completion:*:ssh:*' tag-order \
    users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
    zstyle ':completion:*:ssh:*' group-order \
    hosts-domain hosts-host users hosts-ipaddr
    zstyle '*' single-ignored show

#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

    alias sz='source ~/.zshrc'
    alias ez='atom ~/.zshrc'

    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation

    alias ls='pwd; ls --color'
    alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
    alias less='less -FSRXc'                    # Preferred 'less' implementation

    cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels

    alias edit='atom'                           # edit:         Opens any file in Atom editor
    alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
    alias ~="cd ~"                              # ~:            Go Home
    alias c='clear'                             # c:            Clear terminal display
    alias which='type -all'                     # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
    mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
    trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
    ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview


#   ---------------------------
#   3. NETWORKING
#   ---------------------------

    alias myip='curl ipecho.net/plain'                  # myip:         Public facing IP Address
    alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
    alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
    alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
    alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
    alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
    alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
    alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
    alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
    alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

    # ii:  display useful host related informaton
    ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
    }


#   ---------------------------------------
#   4. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

    alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user


#   ---------------------------------------
#   5. GIT
#   ---------------------------------------

    # Git Colors
    #git config --global color.ui true
    #git config --global color.diff auto
    #git config --global color.status auto
    #git config --global color.branch auto

    # Alias
    #alias git=hub


#   ---------------------------------------
#   6. WEB DEVELOPMENT
#   ---------------------------------------

    # Site
    alias site='cd /srv/http/eshop; composer update'

    # Apache
    alias apacheE='sudo atom /etc/httpd/conf/httpd.conf'
    alias apacheR='systemctl restart httpd'

    # PHP
    alias phpE='sudo atom /etc/php/php.ini'

    # MariaDB
    alias mariaR='systemctl restart mysqld'

    # Laravel
    alias art='php artisan'
    alias reset='mysql -u tigrou -p eshop;'
    alias spatie='art cache:forget spatie.permission.cache'
    alias artC='art cache:clear; art view:clear; art route:clear; art config:clear; art debugbar:clear'
    alias cleanL='sudo chmod -R 777 /srv/http/eshop; spatie; artC; composer dump-autoload -o'
    alias cleanLS='cleanL; art migrate:reset; art migrate:refresh --seed'

    # Hosts
    alias hostsE='sudo atom /etc/hosts'
    #alias vhostsE=''

    # Grabs headers from web page
    httpHeaders () { /usr/bin/curl -I -L $@ ; }

    # httpDebug:  Download a web page and show info on what took time
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

    # ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
    # if [[ ! -d $ZSH_CACHE_DIR ]]; then
    #     mkdir $ZSH_CACHE_DIR
    # fi


#   ---------------------------------------
#   7. SOURCES
#   ---------------------------------------

    # source $ZSH/oh-my-zsh.sh

    # source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
