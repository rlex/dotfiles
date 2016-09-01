# Dotfiles
![ZSH](http://cl.ly/image/101i213S2c2P/Screen%20Shot%202012-10-13%20at%203.25.23%20PM.png)

So, here is my dotfiles. I use them on Mac OS X, Linux, FreeBSD and sometimes Solaris.
I'm keeping them as generic as possible, so there is no distribution-specific features

### Deploy script

1. Can deploy dotfiles for mac os x and linux
2. Can install homebrew, homebrew-cask and predefined brew packages
3. Can install pyenv/rbenv/nodenv and their plugins
4. And keep all of this up-to-date in one command! See ./deploy housekeeper

### Shells

There is configs for zsh and bash. Quick overview:

1. I keep only certain shell-specific features in .bashrc and .zshrc to keep them as small as possible.
2. All "generic" settings placed in sh.d folder - which is sourced from .bashrc/.zshrc.
3. Support for pyenv/rbenv/nodenv
4. Prompt color change based on previous quit signal
5. Some debugging stuff (strace, count ram usage, count FD usage, etc)
6. NSS management
7. Extractor/packer function for various types of archives
8. Some functions for easier searching
9. Folder tagging for faster navigation
10. Awk calculator (haha)

### Vim

![vim](http://cl.ly/image/412k3B0H0P3s/Screen%20Shot%202012-10-13%20at%203.28.28%20PM.png)

Honestly i can't remember all things i installed in vim, but here is some of them:

1. Addons management with vundle
2. Powerful autocompletion
3. Additional filetypes useful for sysadmins - nginx/nagios/interfaces/etc
4. Syntax checking
5. And generic stuff like statusbar, bindings, aliases, etc, etc, etc.

### Mutt

![Mutt](http://cl.ly/image/27283O0b0a0Z/Screen%20Shot%202012-10-13%20at%203.26.59%20PM.png)

Yeah, it's 2016 and i still use mutt. You will find:

1. 256-color theme (yay!)
2. Support for GPG
3. Support for encrypting passwords and profiles using GPG
4. Sourcing system with gitignored file. See .mutt/.localprofile.example
5. A lot of aliases and generic settings (as usual)

### Screen

![Screen](http://cl.ly/image/2Q472W2Y0y0C/Screen%20Shot%202012-10-13%20at%203.38.37%20PM.png)

Pretty generic screen config with compact statusbar and some hacks to avoid known bugs.

### Tmux

![tmux](http://i.imgur.com/tW1KBvp.png)

Same as screen - pretty simple config with 256 color scheme

### Git

Some additional aliases for better logs and graphs, more color and more minimalistic output.
Oh, and if you will use this config - **change name, mail and signing key to yours**

### X server settings

I use linux desktop for work. My main apps is yeahconsole, awesome WM, and rxvt terminal. So, in .Xdefaults you will find:

1. Soft colorscheme for xterm and urxvt
2. Terminus font for terminal - obviously, should be installed separately
3. Yeahconsole config - quake-style urxvt-backed terminal

### Awesome WM

(Notice: not working with awesome 3.5)

Awesome WM is, uh, awesome tiling window manager. Things you will find in my config:

1. Tiny menubar to maximize usable space. Supports sound, battery and load widgets, but you can add anything here with a bit of LUA code
2. Dynamic tiling - why keep tiles without any windows?
3. Fallback mode - if you will break your awesome config, WM will just load with default - so you can quickly fix your code.
4. Some pre-defined tiles and binds.

### Binaries

I keep some big pieces of code in .bin folder, for example:

1. ack. It's better than grep!
2. speedtest
... And so on.

This folder is added to $PATH, so all apps will be available in shell

### Small stuff

1. Colored top (linux only)
2. Simple openbox+tint2 config with numix gtk theme
3. More friendly htop
4. Gemrc for ruby.
5. Some settings for ack
6. Some settings for mc
7. Unfinished mailcap
8. Generic dircolors
9. Some things i can't remember
