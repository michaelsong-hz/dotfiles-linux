#!/bin/bash

# Simple autostart file for i3-wm, executed from i3 config

# Sets DPI to 150%
xrandr --dpi 144
i3-msg "restart"
