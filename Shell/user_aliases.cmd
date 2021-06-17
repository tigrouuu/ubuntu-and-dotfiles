;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
gl=git log --oneline --all --graph --decorate  $*
ls=ls --show-control-chars -F --color $*
pwd=cd
clear=cls
unalias=alias /d $1
vi=vim $*
cmderr=cd /d "%CMDER_ROOT%"

;= composer aliases

cr=composer
cri=composer install
cdo=composer dump-autoload -o $*
cu=composer update"

;= Laravel artisan aliases

pa=php artisan $*
pamm=php artisan make:model $*
pamc=php artisan make:controller $*
pakg=php artisan key:generate $*
pamt=php artisan make:test $*
pamf=php artisan migrate:fresh $*
pami=php artisan migrate $*
pads=php artisan db:seed $*
pas=php artisan serve $*
tinker=php artisan tinker

;= npm aliases

ni=npm install
nid=npm install --save-dev 
nu=npm uninstall $*
ns=npm start
nd=npm run dev
ndev=npm run dev
nprod=npm run prod
nhot=npm run hot
nstart=npm run start
nprod=npm run prod
nhot=npm run hot

;= git aliases

gpom=git push origin main 2> /dev/null || git push origin main
xgpush=git push --set-upstream origin 
;= from https://ma.ttias.be/pretty-git-log-in-one-line/
gl=git logline
ga=git add -A
gc=git commit -m $*
gd=git diff
gca=git commit -a -m $*
xgamend=git commit --amend --no-edit
gs=git status
gpush=git push
gpushf=git push -f
gpull=git pull
gb=git branch
gcb=git checkout -b 
gco=git checkout --orphan
gupdatefork=git fetch upstream && git checkout main && git rebase upstream/main
xgundo=git reset --soft HEAD~
xgfetchb=git checkout --track origin/
xgpullsub=git pull --recurse-submodules
