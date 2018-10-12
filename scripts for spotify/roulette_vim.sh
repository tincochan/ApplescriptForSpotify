#!/bin/bash

[[ ! `which gshuf` ]] && echo "Install coreutils!" && exit 1
[[ ! `which jq` ]] && echo "Install jq!" && exit 1

vimrc=$HOME/.vimrc

if [ -f $vimrc ];then
	[ ! -f $vimrc"_orig" ] && cp $vimrc $vimrc"_orig"
fi

# function is_even() {
# # TODO: randomly pick between sorted options
# # sort by stars, forks, or updated
# if [ ! -z "$#" ]; then
# 	value=$(expr $1 % 2)
# 	(( $value == 0 )) && return 1 || return 0
# fi
# }

function is_stale() {
	! [ -z $(find $HOME -name '.vimrc_cache' -mtime +120s -maxdepth 1) ]
}

cache="$HOME/.vimrc_cache"
type="&sort=updated&order=desc"
link="https://api.github.com/search/repositories?q=dotfile+language:bash"

if [ ! -f $cache ] || is_stale; then
	rm $cache
	curl $link$type         \
	  | grep "clone_url"    \
	  | grep "dotfiles.git" \
	  | cut -d'"' -f4 >> $cache
fi

new_vim_url=$(gshuf -n1 $cache)
new_vim_user=$(echo $new_vim_url | cut -d"/" -f4)
new_vim_repo=$(echo $new_vim_url | cut -d"/" -f5)

curl -L https://api.github.com/repos/$new_vim_user/$new_vim_repo/vimrc
