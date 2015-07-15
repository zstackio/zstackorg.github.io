#!/bin/bash
#build zstack multiple languages website from source to web pages
# Before run this script, you need to checkout source branch to edit web site 
# and push all changes.

function exe_cmd() {
    echo $1
    eval $1
}

if [ $# -lt 1 ]; then
    echo "Usage: sh $0 [ master ]"
    exit
fi

branch=$1
if [ -z "$branch" ] || [ "$branch" != "master" ]; then
    branch='master'
fi

exe_cmd "jekyll build"
if [ ! -d '_site' ];then
    echo "not content to be published"
    exit
fi

exe_cmd "git checkout $branch"
error_code=$?
if [ $error_code != 0 ];then
    echo "Switch $branch fail."
    exit
else
    ls | grep -v _site|xargs rm -rf
    exe_cmd "/bin/cp -fr _site/* ."
    exe_cmd "rm -rf _site/"
    exe_cmd "touch .nojekyll"
fi

echo "You need to run 'git add -A', 'git commit -a' and 'git push --all origin'"