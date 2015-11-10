#fix/replace the most recent commit
git commit --amend

#unstage
git reset HEAD <file>

#discard changes in unstaged files
git checkout -- <file>.

#unstage delete, reset then checkout
git reset -- <file>.

#tag important revisions
git tag

#switch to branch, -b to create branch at the same time
git checkout testing

#remove branch, --merged, --no-merged opition to show branches that are
merged/not yet merged into your current branch
git branch -d testing

#show history of commits
git log --oneline --decorate --graph --all

#merge brnach
git merge branchName

#get data from remote project: update your local db and move (remote)/(branch)
pointer
git fetch [remote-name]

#push my branch to a certain remote
git push (remote) (branch)

#set up credential cache
git config --global credential.helper cache

#base my current branch on the the remote branch
git checkout -b {my branch} {remote/branch}
git checkout --track {remote/branch}

#set a local branch to remote branch
git branch -u origin/serverfix

#rebase local changes you’ve made but haven’t shared yet before you push them in order to clean up your story, but never rebase anything you’ve pushed somewhere

#change remote to forked repository
git remote set-url origin $FORKED_URLt

#set up upstream repo
git remote add upstream $Repo_synced_with_the_fork

#sync forked with upstream
git fetch upstream

#merge the synced content with master
git merge upstream/master

#show branch history
git log

#port code into a new git repo. 1. clone into a temp local repo 2. push local repo to remote 3. now you can clone from remote again
git clone --bare
git add remote
git push --all
git push --tags


##
git tag -a v1.4 -m 'my version 1.4'
git push origin [tagname]
git checkout -b version2 v2.0.0
