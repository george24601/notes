#BACK UP YOUR .VIM folder FIRST!
rm -r ~/.vim

#install pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#inside your ~/.vimrc, use
#execute pathogen#infect()
#syntax on
#filetype plugin indent on

#install vim-scala
cd ~/.vim/bundle && \
git clone git://github.com/derekwyatt/vim-scala.git
mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O ~/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim; done

