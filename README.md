# Configuration for my Linux environment

These are the configuration files for my Linux environment which I use on my Surface Pro 3 and desktop computer.

## fish

I'm using the fish shell with the solarized dark theme.

## i3-wm-config

I use i3 as my window manager.

The "i3" directory contains the configuration files for i3 itself (hotkeys, startup tasks etc.), along with scripts for startup tasks (set_dpi.sh) and locking the screen (lock.sh). Look for the "config" file for the main configuration.

I'm using [lemonbar-xft](https://github.com/krypt-n/bar) as my status bar for this setup.
In the "lemonbar" directory, lbar.sh contains the main configuration files and scripts for lemonbar, and lbar_colours contains the colour codes used by lemonbar.

## termite

Font and colour configuration for termite

## .Xresources

Contains colour configuration for Rofi (application launcher)

## Screenshots

![picture](http://i.imgur.com/tgxxR5F.jpg)
![picture](http://i.imgur.com/Y9YsZkl.jpg)
![picture](http://i.imgur.com/uFyD7cU.jpg)

## Dependencies

* [fish](https://fishshell.com/)
* [i3-wm](https://i3wm.org/)
* [lemonbar-xft](https://github.com/krypt-n/bar)
* [lm-sensors](http://www.linuxfromscratch.org/blfs/view/svn/general/lm_sensors.html) (Required to get temperature info for lemonbar)
* [Font-Awesome](https://fortawesome.github.io/Font-Awesome/) (Used for icons in lemonbar)
* [Powerline fonts](https://github.com/powerline/fonts) (Powerline fish prompt)
* [termite](https://wiki.archlinux.org/index.php/Termite)
