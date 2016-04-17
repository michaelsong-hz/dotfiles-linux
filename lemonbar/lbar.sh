#!/bin/bash

# Colours, Icons and Separators {{{
# Colours
. ~/.config/lemonbar/lbar_colours

# Icons
IUpTime=""
INet=""
IMem=""
ICpuTemp=""
ICpuLoad=""
IVolS=""
IVolM=""
IVolL=""
IBattery0=""
IBattery1=""
IBattery2=""
IBattery3=""
IBattery4=""
IDate=""
ITime=""
ILock=""
IBrightness=""

# Workspace Icons
IWorkspaceFocused=""
IWorkspaceUnfocused=""
IWorkspaceEmpty=""
IWorkspaceDivider="|"

# Separators
SEP=" "
SEP2="  "
SEP4="    "
SEP6="      "
# }}}

# Other stuff
refresh=0.5

# Create temp files
# mkdir -p /tmp/.lemonbarscripts
# echo "false" >/tmp/.lemonbarscripts/cputnotif
# echo "false" >/tmp/.lemonbarscripts/batterynotif

# Names of all the screen outputs being used
Screens=$(xrandr | grep -o "^.* connected" | sed "s/ connected//")

bar() {

    # Reading multiple files, many if statements and notifications. Needs work.
    Battery() {
        # If this system has a battery
        if [[ -d /sys/class/power_supply/BAT0 ]] || [[ -d /sys/class/power_supply/BAT1 ]]; then
            # Can be 'Full', 'Discharging', 'Unknown' or 'Charging'.
            STATUS=$(cat /sys/class/power_supply/BAT0/status || cat /sys/class/power_supply/BAT1/status)
            BATTERY=$(cat /sys/class/power_supply/BAT0/capacity || cat /sys/class/power_supply/BAT1/capacity) 
            if [[ $STATUS == "Unknown" ]] || [[ $STATUS == "Charging" ]] || [[ $STATUS == "Full" ]]; then
                stat=""
            else
                # Change icon and colour depending on battery status
                if [[ $BATTERY -lt 20 ]]; then stat=$IBattery0
                elif [[ $BATTERY -lt 40 ]]; then stat=$IBattery1
                elif [[ $BATTERY -lt 60 ]]; then stat=$IBattery2
                elif [[ $BATTERY -lt 80 ]]; then stat=$IBattery3
                else stat=$IBattery4
                fi

                if [ $BATTERY -lt 15 ]; then
                    BATbg="$red"
                elif [ $BATTERY -lt 30 ]; then
                    BATbg="$yellow"
                fi
            fi

            BATTERY+="%"
            # If our battery background has changed, print it with the changed background
            if [ -n "$BATbg" ]; then
                echo "%{F$white}%{B$BATbg} $stat$SEP$BATTERY %{B$bg}%{F-}"
            else
                echo %{F$gray}$stat$SEP$BATTERY%{F-}
            fi
        else echo ""; fi
    } 

    # Approved
    Brightness() {
        BRIGHTNESS=$(xbacklight -get | grep -o "[0-9]\+\.[0-9]\?")
        if [[ $BRIGHTNESS != "" ]]; then
            BRIGHTNESS+="%"
            echo %{F$gray}$IBrightness$SEP$BRIGHTNESS%{F-}
        else
            echo ""
        fi
    }

    CpuTemp() {
        # Get the the highest temp of any core
        CPUTEMP=$(sensors | grep "Physical id" | grep -o "[0-9]\+\.[0-9]\+" | head -n 1 | sed "s/\..*$//")

        # Icon turns red if above 65C
        if [[ $CPUTEMP -gt 65 ]]; then
            CPUTEMP+="C"
            echo "%{F$gray}%{B$red}$ICpuTemp$SEP$CPUTEMP%{B$bg}%{F-}"
        else
            CPUTEMP+="C"
            echo %{F$gray}$ICpuTemp$SEP$CPUTEMP%{F-}
        fi
    }

    # Approved
    Date() {
        DATE=$(date "+%A %m/%d/%Y")
        echo %{F$gray}$IDate$SEP$DATE%{F-}
    }

    # Approved
    Memory() {
        MEMUSED=$(free -m | awk 'NR==2 {print $3}')
        MEMUSED+="MB"
        echo %{F$gray}$IMem$SEP$MEMUSED%{F-}
    }

    # Ok
    NetUp() {	
        # Pings the default gateway. If it is successful then we are connected. Benefits
        # to pinging the default gateway rather than google.com, etc. is that this doesn't
        # rely on those websites being up and as such, will always be accurate
        defGate=$(ip r | grep default | cut -d ' ' -f 3)
        # 7 is the minimum length for a valid ip address (ex. 1.1.1.1)
        # Really just used to make sure we obtained a valid ip from 'ip r'
        if [[ ${#defGate} -ge 7 ]]; then
            NetUp=$(ping -q -w 1 -c 1 $defGate > /dev/null && echo c || echo u)
            # If some network interface is up
            if [[ $NetUp == "c" ]]; then
                echo %{F$gray}$INet%{F-}
            else
                echo "%{F$gray}%{B$red}$INet%{B$bg}%{F-}"
            fi
        else
            echo "%{F$gray}%{B$red}$INet%{B$bg}%{F-}"
        fi
    }

    # Approved
    Time() {
        TIME=$(date "+%H:%M %Z")
        echo %{F$gray}$ITime$SEP$TIME%{F-}
    }

    # Approved
    UpTime() {
        UPTIME=$(uptime -p)
        Min=$(echo $UPTIME | grep -o "[0-9]\+ min" | grep -o "[0-9]\+")
        Hour=$(echo $UPTIME | grep -o "[0-9]\+ hour" | grep -o "[0-9]\+")
        Day=$(echo $UPTIME | grep -o "[0-9]\+ day" | grep -o "[0-9]\+")

        # Format minutes so that it always occupies 2 characters
        while [[ ${#Min} -lt 2 ]]; do 
            Min="0$Min"
        done 
        # Same for hours but, so that it always occupies at least 1 character
        while [[ ${#Hour} -lt 1 ]]; do 
            Hour="0$Hour"
        done 
        if [[ ${#Day} -ge 1 ]]; then
            Day="$Day "
        fi

        out="$Day$Hour:$Min"

        echo %{F$gray}$IUpTime$SEP$out%{F-}
    }

    # Okay
    Volume() {
        # Crap I still have to work on >:/// {{{
        # OUT=$(amixer -c 0 | grep -o "Invalid card number.")
        # Card was found
        # if [[ $OUT == "" ]];
        # then
        # Check to see if card is being used

        # Card was not found
        # else

        # fi

        # This should maybe be changed so that it doesn't serach for Left but rather just a percent
        # exec amixer -D pulse get Master | grep Left: | grep -o "[0-9]*%" | grep -o "[0-9]*"
        # }}}
        VOL=$( (amixer -D pulse get Master | grep Left: | grep -o "[0-9]\+%" | grep -o "[0-9]\+") || echo "")
        if [[ $VOL -lt 33 ]]; then Icon=$IVolS
        elif [[ $VOL -le 66 ]]; then Icon=$IVolM
        else Icon=$IVolL; fi

        VOL+="%"

        # If we actually retrieved a valid volume value
        if [[ ${#VOL} -ge 1 ]]; then
            echo %{F$gray}%{A:urxvt -e "alsamixer -V all &":}$Icon$SEP$VOL%{A}%{F-}
        fi
    }

    # This is currently extremely inefficient, look to optimize this in the future
    Workspaces() {
        # This command returns all the workspaces in use in a JSON format
        WORKSPACES="$(i3-msg -t get_workspaces)"
        COUNTER=0
        OUTPUT=""

        # Loop through all the chars in the JSON object
        for((i=0; i<${#WORKSPACES}; i++))    
        do
            # The current char
            ch=${WORKSPACES:i:1}

            # Every 11 colons will contain our workspace number.
            # When we find it, simply append it to our output.
            if [ $ch == ":" ]; then
                COUNTER=$[$COUNTER +1]
                if [ $COUNTER -eq 1 ]; then
                    j=$[$i +1]
                    if [ -n "$CURRENTWS" ]; then
                        OUTPUT="$OUTPUT$IWorkspaceDivider$CURRENTWS"
                    fi

                    # Need to add two chars if the workspace is two digits
                    if [ ${WORKSPACES:i+2:1} != "," ]; then
                        CURRENTWS=" ${WORKSPACES:i+1:1}${WORKSPACES:i+2:1} "
                    else
                        CURRENTWS=" ${WORKSPACES:i+1:1} "
                    fi
                fi
                # Reset our counter when it hits 11
                if [ $COUNTER -eq 11 ]; then
                    COUNTER=0
                fi
                # Check if the current workspace is active in the JSON object
            elif [ $ch == "d" ] && [ ${WORKSPACES:i+3:1} == "t" ]; then
                # If so, mark it as active and change its background colour
                CURRENTWS="%{B#467986}$CURRENTWS%{B$bg}"
            fi
        done

        # TODO: Better way to explain this
        # If our current workspace still contains something
        if [ -n "$CURRENTWS" ]; then
            OUTPUT="$OUTPUT$IWorkspaceDivider$CURRENTWS"
        fi

        echo "%{F$gray}$OUTPUT$IWorkspaceDivider%{F-}"
    }

    barleft="$(Workspaces)"
    barcenter="$(Time)"
    barright="$(CpuTemp)$SEP2$(NetUp)$SEP2$(Volume)$SEP2$(Battery)$SEP2$(Date)$SEP2"

    #="%{S0}%{l}$barleft%{c}$barcenter%{r}$barright
    finalbarout=""

    tmp=0
    for screen in $(echo "$Screens"); do
        finalbarout+="%{S${tmp}}%{l}$barleft%{c}$barcenter%{r}$barright"
        let tmp=$tmp+1
    done

    #echo "%{S0}%{l}$barleft%{c}$barcenter%{r}$barright"
    #%{S1}%{l}$barleft%{c}$barcenter%{r}$barright"
    echo "${finalbarout}"
}


screennum=$(echo "$Screens" | wc -l)
if [[ $screenum -eq 1 ]]; then
    let OH=1
    let OF=-1
else
    let OH=2
    let OF=-2
fi

while true; do
    echo "$(bar)"
    sleep $refresh;
done | lemonbar -g x35 -a 22 -u 2 -o $OH -f "Roboto-13" -o $OF -f "FontAwesome-11" -B $bg -F $fg | bash &
