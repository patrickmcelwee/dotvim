Installation:

    git clone https://github.com/patrickmcelwee/dotvim.git ~/.vim

Create symlink:

    ln -s ~/.vim/vimrc ~/.vimrc

I use Vundle to manage vim plugins. See the documentation at https://github.com/gmarik/Vundle.vim. To setup:

    mkdir .vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Also, I use ~/.vim_backups for backup files. So you need to:

    mkdir ~/.vim_backups
