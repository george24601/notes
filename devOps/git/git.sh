#fix/replace the most recent commit
git commit --amend

#unstage
git reset HEAD <file>

#show history of commits
git log --oneline --decorate --graph --all

#show changes master doesn't have but the develop branch has
git log master..develop

#get data from remote project: update your local db and move (remote)/(branch) pointer
#sync forked with upstream
git fetch [remote-name]

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

#compare commit f7b5's parent with f7b5
git diff f7b5^ f7b5

#From the feature branch, push a single commit on top of the master with no merge commit
#on master
git merge --squash $FEATURE_BRANCH
git commit -m "$COMMIT_MESSAGE"
#pull master again to ensure there is no conflict between current master and your commit
git pull --rebase 
git push origin master
