# My `vim` Adventure

(…that has been going strong for 6 years now. Woot! I should probably do a
thourough clean up some time.)

I use `vim` for **everything** except for iOS Coding.

The config state always reflects my daily life. Currently the big features are:

* Lots of Python/Django Things
* Of course 100% `git` integration
* First class golang support (yep! :D)
* React/JSX Support
* Ansible Support
* Blade Support
* PHP7 Support

There are many more (legacy) things in the config (like PHP specific settings).
Just take a deep dive. Everything is documented in some way.


## `vim` on OSX Note

On OSX 10.6 (and later) you get `vim` 7.x (but 8.0+ is the freshest release)
without Ruby and Python support which, to be perfectly honest, sucks. 

Now most OSX users will install vim via Homebrew. Please don't. This `.vimrc`
includes `YouCompleteMe` for amazing autocompletes and IDE-like features across
several languages. Homebrew vim and macvim do crash with YCM sadly.

Simply install MacVim [from their official github
releases](https://github.com/macvim-dev/macvim/releases). Then add this to your
`.zshrc`/`.bashrc` to use MacVim provided binaries everywhere:

```sh
# Adds vim via MacVim
export PATH="/Applications/MacVim.app/Contents/bin/:$PATH"
```

## Python Linting in Virtualenvs

You will notice that linting will not work properly in a virtualenv
(complaining about libraries not being importable). That's a lie. To fix it,
simply install `pylint` in your virtualenv. The same applies to autoformatting,
which is done by `yapf`.
