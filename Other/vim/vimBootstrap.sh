#BACK UP YOUR .VIM folder FIRST!
rm -r ~/.vim

#install pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#install vim-scala
cd ~/.vim/bundle && \
git clone git://github.com/derekwyatt/vim-scala.git
mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim; done

#install vim-node
mkdir -p ~/.vim/bundle/node
git clone https://github.com/moll/vim-node.git ~/.vim/bundle/node

#install vim-gradle
mkdir -p ~/.vim/bundle/vim-gradle
git clone https://github.com/tfnico/vim-gradle  ~/.vim/bundle/vim-gradle 
