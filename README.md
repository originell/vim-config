# My `vim` Adventure

(…that has been going strong for 5 years now. Woot! I should probably do a
thourough clean up some time.)

I use `vim` for **everything** except for iOS Coding.

The config state always reflects my daily life. Currently the big features are:

* Lots of Python/Django Things
* Of course 100% `git` integration
* First class golang support (yep! :D)
* React/JSX Support
* Ansible Support

There are many more (legacy) things in the config (like PHP specific settings).
Just take a deep dive. Everything is documented in some way.

## `vim` on OSX Note

On OSX 10.6 (and later) you get `vim` 7.x (but 8.0+ is the freshest release)
without Ruby and Python support which, to be perfectly honest, sucks. The most
common and obvious way is to compile `vim` yourself. However that did throw me
errors with Ruby not having a x86\_64 extensions even when I had the x86\_64
version installed via `rvm`.

Anyways I then found an article by Chris Moyer about [using MacVim's `vim` 
as _cli_ `vim`](http://blog.coredumped.org/2010/01/osx-VIM-and-Python.html).
Inspired by that, I marched on into my journey of recompiling `vim`. However, as
an avid user of [homebrew](https://github.com/mxcl/homebrew) - which you should
use too - I quickly glanced at the formula for MacVim, just to find out there
are awesome build flags.

    option "with-override-system-vim", "Override system vim"

So a simple...

    brew install MacVim --with-override-system-vim

takes care of everything mentioned in the above blogpost.
