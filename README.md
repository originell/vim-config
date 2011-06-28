My VIM Adventure
================

This is my VIM adventure. Here I will document what my vim config looks like,
what is different and where my inspirations come from.

Hopefully I will stay strong :-)

CommandT
========

This 'vimrc' contains the famous CommandT utility, mimicking TextMate's `Go To File` functionality. In order to use it you need to compile the included C extension...

    cd bundle/command-t/ruby/command-t/
    ruby extconf.rb
    make

That's it :-)

vim on OSX Note
===============

On OSX 10.6 you get vim 7.2 but without ruby and python support which, to be
perfectly honest, sucks. The most common and obvious way is to compile vim
yourself. However that did throw me errors with ruby not having a x86_64 
extensions even when I had the x86_64 version installed via `rvm`. Anyways
I then found an article by Chris Moyer about [using MacVIM´s vim 
as _cli_ vim](http://blog.coredumped.org/2010/01/osx-vim-and-python.html).

If you are one of the lucky gals who  are using
[homebrew](https://github.com/mxcl/homebrew) you can just do a simple

    brew install MacVim

which takes care of everything mentioned in the above blogpost. You can even
go so far as to use `--override-system-vim`. _Awesome_!

