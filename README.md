My VIM Adventure
================

This README contains information which I did not want to put into my vimrc. Mainly notes on usage and installation. For everything else, go ahead and undress my `vimrc` ;-)

CommandT
========

This 'vimrc' contains the famous CommandT utility, mimicking TextMate's `Go To File` functionality. In order to use it you need to compile the included C extension...

    cd bundle/command-t/Ruby/command-t/
    Ruby extconf.rb
    make

That's it :-)

`make` fails and segfaults
--------------------------

If CommandT makes your vim segfault, this is most likely to happen because your vim is compiled against a different Ruby version than CommandT. I recommend using [`rvm`](https://rvm.beginrescueend.com/) (_R_uby _V_ersion _M_anager) to install/switch to the version your vim is compiled against and recompile CommandT. Same applies for `make` failures.


pyflakes
========

Tells you about unused imports, missing colons when working with Python. The VIM script is already in the config, however, of course, requires the `pyflakes` library.
Personally I recommend using [kevinw's pyflakes fork](https://github.com/kevinw/pyflakes), since it is faster and retains column number information (more specific error locations).

    pip install git+https://github.com/kevinw/pyflakes


vim on OSX Note
===============

On OSX 10.6 you get vim 7.2 but without Ruby and Python support which, to be
perfectly honest, sucks. The most common and obvious way is to compile vim
yourself. However that did throw me errors with Ruby not having a x86\_64 
extensions even when I had the x86\_64 version installed via `rvm`.

Anyways I then found an article by Chris Moyer about [using MacVIM´s vim 
as _cli_ vim](http://blog.coredumped.org/2010/01/osx-vim-and-Python.html). Inspired by that, I marched on into my journey of recompiling vim. However, as an avid user of [homebrew](https://github.com/mxcl/homebrew) - which you should use too - I quickly glanced at the formula for MacVim, just to find out there are awesome build flags.

  def options
  [
    # Building custom icons fails for many users, so off by default.
    ["--custom-icons", "Try to generate custom document icons."],
    ["--with-cscope", "Build with Cscope support."],
    ["--with-envycoder", "Build with Envy Code R Bold font."],
    ["--override-system-vim", "Override system vim."],
    ["--enable-clipboard", "Enable System clipboard handling in the terminal."]
  ]
  end

So a simple...

    brew install MacVim --override-system-vim --enable-clipboard

takes care of everything mentioned in the above blogpost.
