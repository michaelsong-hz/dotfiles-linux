# Configuration files for the i3 window manager

These are the configuration files for the i3 window manager, along with lemonbar which I use on my Surface Pro 3.

## i3

The "i3" directory contains the configuration files for i3 itself (hotkeys, startup tasks etc.), along with scripts for startup tasks (set_dpi.sh) and locking the screen (lock.sh). Look for the "config" file for the main configuration.

## lemonbar

I'm using [lemonbar-xft](https://github.com/krypt-n/bar) as my status bar for this setup. The lemonbar directory contains configuration files for lemonbar written both by myself and my friend [JSpeedie](https://github.com/JSpeedie/dotfiles).

lbar.sh contains the main configuration files and scripts for lemonbar, and lbar_colours simply contains the colour codes of colours used by lemonbar.

## Screenshots

![picture](http://i.imgur.com/tgxxR5F.jpg)
![picture](http://i.imgur.com/Y9YsZkl.jpg)
![picture](http://i.imgur.com/uFyD7cU.jpg)

## Dependencies

* [i3-wm](https://i3wm.org/)
* [lemonbar-xft](https://github.com/krypt-n/bar)
* [Font-Awesome](https://fortawesome.github.io/Font-Awesome/) (Used for icons in lemonbar)
* [lm-sensors](http://www.linuxfromscratch.org/blfs/view/svn/general/lm_sensors.html) (Required to get temperature info for lemonbar)
