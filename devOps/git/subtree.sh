#two projects, one of the projects maps to a subdirectory of the other, and then git figure out that one is subtree of the other

#add Rack as remote ref in your own project
git remote add rack_remote git@github.com:schacon/rack.git
git fetch rack_remote
git checkout -b rack_branch rack_remote/master

#read-tree reads the root tree of one branch into staging arena and working directoring
#on master branch
git checkout master
git read-tree --prefix=rack/ -u rack_branch

