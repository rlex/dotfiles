# Dotfiles
![ZSH](http://cl.ly/image/101i213S2c2P/Screen%20Shot%202012-10-13%20at%203.25.23%20PM.png)

So, here is all of my dotfiles. I use them on Mac OS X, Linux, FreeBSD and sometimes Solaris. So i'm keeping them as generic as possible - no patched fonts (sorry, powerbar), no distribution-specific features (like heavily patched mutt in debian with loads of new features).

### Shells

There is configs for zsh and bash. Quick overview: 

1. I keep only certain shell-specific features in .bashrc and .zshrc to keep them as small as possible.
2. All "generic" settings placed in sh.d folder - which is sourced from .bashrc/.zshrc. If you interested you should take a look at this folder - because i have **a lot** of stuff here, for example:
3. Nice MOTD when you login!
4. Prompt color change based on previous quit signal
5. Dirty hack to pass alises via sudo 
6. Simple function to manage NSS
7. Extractor/packer function for various types of archives
8. Some functions for easier searching
9. Folder tagging for faster navigation
10. Awk calculator (haha)
11. Fast Toast installation, so you can quickly compile and install any software in your home dir. Well, almost any.

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

Yeah, i still use mutt. You will find:

1. 256-color theme (yay!)
2. Support for GPG
3. Sourcing system, so you can customize mutt on every machine. See .mutt/.localprofile.example - very easy to configure!
4. A lot of aliases and generic settings (as usual)

### Screen

![Screen](http://cl.ly/image/2Q472W2Y0y0C/Screen%20Shot%202012-10-13%20at%203.38.37%20PM.png)

Pretty generic screen config with compact but good statusbar and some hacks to avoid known bugs.

### Git

Some additional aliases for better logs and graphs, more color and more minimalistic output. Oh, and if you will use this config - **be sure to change name, mail and signing key to yours**

### X server settings

I use linux desktop for work. My main apps is yeahconsole, awesome WM, and rxvt terminal. So, in .Xdefaults you will find:

1. Soft colorscheme for xterm and urxvt
2. Terminus font for terminal - obviously, should be installed separately
3. Yeahconsole config - quake-style console which opened by pressing F12, going full-screen with F11, and using urxvt as terminal

### Awesome WM

Awesome WM is, uh, awesome tiling window manager. Things you will find in my config:

1. Tiny menubar to maximize usable space. Supports sound, battery and load widgets, but you can add anything here with a bit of LUA code 
2. Dynamic tiling - why keep tiles without any windows?
3. Fallback mode - if you will break your awesome config, WM will just load with default - so you can quickly fix your code. 
4. Some pre-defined tiles and binds.

### Deploy script

Simple bash script to symlink all dotfiles from ~/.rc to home directory. Compatible with any bash-like shell except sh - because it do not support arrays :( 

### Binaries

I keep some big pieces of code in .bin folder, for example:

1. ack. It's better than grep, just try!
2. Cron checker
3. git-sh

This folder is sourced in shells, so you can just drop any app here and it will be available.

### Small stuff

1. Colored top!
2. More friendly htop
3. Gemrc for ruby.
4. Some settings for ack
5. Some settings for mc 
6. Unfinished mailcap
7. Generic dircolors

### TODO:

It's constantly changing. Things i will do soon:

1. Cleanup. There is a lot of stuff i do not use anymore.
2. Support for encrypted password for mutt using GPG
3. Some way to share .ssh folder and encrypted passwords database
4. Fix bug with bash autocompletion sometimes do not work.
