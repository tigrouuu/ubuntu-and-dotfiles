# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

################################################################################
#                                    Perso                                     #
################################################################################

alias sb='source ~/.bash_profile'

alias c='clear'
alias ls='pwd; ls --color'

# Site
alias site='cd ./public_html; composer update'

# Laravel
alias art='php artisan'
alias reset='mysql -u DB_USERNAME -p DB_DATABASE;'
alias spatie='art cache:forget spatie.permission.cache'
alias artC='art cache:clear; art view:clear; art route:clear; art config:clear; art debugbar:clear'
alias cleanL='spatie; artC; composer dump-autoload -o'
alias cleanLS='cleanL; art migrate:reset; art migrate:refresh --seed'
