#!/bin/bash

# Simple autostart file for i3-wm, executed from i3 config

notify-send -t 3000 -u normal "Executing startup programs..."

# Starts wicd-client on workspace 10
sleep 1
i3-msg --no-startup-id "workspace 10; exec wicd-client"

# Starts FB messenger on workspace 2
i3-msg --no-startup-id "workspace 2; exec messengerfordesktop"

# Switches back to workspace 1 after waiting for fb messenger to start
sleep 2
i3-msg --no-startup-id "workspace 1"

notify-send -t 3000 -u low "Desktop Ready"

# Quickly restarts i3 in place to halt the "waiting" i3 status
i3-msg "restart"

exit 0
