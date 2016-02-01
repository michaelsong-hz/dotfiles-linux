#!/bin/bash

# Simple autostart file for i3-wm, executed from i3 config

# Starts wicd-client on workspace 10
i3-msg "workspace 10; exec wicd-client"

# Starts FB messenger on workspace 2
i3-msg "workspace 2; exec messengerfordesktop"

# Switches back to workspace 1 after waiting for fb messenger to start
sleep 2
i3-msg "workspace 1"

exit 0
