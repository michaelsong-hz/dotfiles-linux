#!/bin/bash

# Simple autostart file for i3-wm, executed from i3 config

notify-send -t 4000 -u normal "Executing startup programs..."

# Starts wicd-client on workspace 10
sleep 1
i3-msg --no-startup-id "workspace 10; exec wicd-client"

# Starts Evolution mail client on workspace 3
i3-msg --no-startup-id "workspace 3; exec evolution"

# Switches back to workspace 1 after waiting for evolution to start
sleep 3
i3-msg --no-startup-id "workspace 1"

notify-send -t 4000 -u low "Desktop Ready"

# Quickly restarts i3 in place to halt the "waiting" i3 status
i3-msg "restart"

exit 0
