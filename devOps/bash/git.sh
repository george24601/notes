#add Rack as remote ref in your own project
git remote add rack_remote git@github.com:schacon/rack.git
git fetch rack_remote
git checkout -b rack_branch rack_remote/master

#read-tree reads the root tree of one branch into staging arena and working directoring
#on master branch
git checkout master
git read-tree --prefix=rack/ -u rack_branch

#unstage
git reset HEAD <file>

#show history of commits
git log --oneline --decorate --graph --all

#show changes master doesn't have but the develop branch has
git log master..develop

#set up credential cache
git config --global credential.helper cache

#base my current branch on the the remote branch
git checkout -b {my branch} {remote/branch}
git checkout --track {remote/branch}

#set a local branch to remote branch
git branch -u origin/serverfix

#change remote to forked repository
git remote set-url origin $FORKED_URLt

#set up upstream repo
git remote add upstream $Repo_synced_with_the_fork

#port code into a new git repo. 1. clone into a temp local repo 2. push local repo to remote 3. now you can clone from remote again
git clone --bare
git add remote
git push --all
git push --tags

#find file by name in the repo
git ls-tree -r HEAD | grep parameterService

#revert change to a single file
git log -p path/to/file
git checkout <commit> path/to/file
git commit

#merge the last two commits
#amend: fix/replace the most recent commit
git reset --soft "HEAD^"
git commit --amend
