#!/usr/bin/env nu

let border_color_focused = "0x83A598"
let border_color_unfocused = "0x3C3836"
let padding = 6

let terminal = "ghostty"
let browser = "liberwolf"
let editor = "emacsclient -c -a 'emacs'"
let touchpad = "pointer-1267-12548-ASUE1300:00_04F3:3104_Touchpad"
let fuzzelArgs = [
    "--border-radius 0"
    "--width 40"
    "--vertical-pad 4"
    "--horizontal-pad 8"
    "--no-icons"
] | str join " "

riverctl output-layout rivertile

riverctl map normal Super Return spawn $terminal
riverctl map normal Super E spawn $editor
riverctl map normal Super Q close

riverctl map normal Super J focus-view next
riverctl map normal Super K focus-view previous
riverctl map normal Super+Shift J swap next
riverctl map normal Super+Shift K swap previous

riverctl map normal Super Period focus-output next
riverctl map normal Super Comma focus-output previous

riverctl map normal Super+Shift Period send-to-output next
riverctl map normal Super+Shift Comma send-to-output previous

riverctl map normal Super+Shift Return zoom

riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

riverctl map normal Super+Alt H move left 100
riverctl map normal Super+Alt J move down 100
riverctl map normal Super+Alt K move up 100
riverctl map normal Super+Alt L move right 100

riverctl map normal Super+Alt+Control H snap left
riverctl map normal Super+Alt+Control J snap down
riverctl map normal Super+Alt+Control K snap up
riverctl map normal Super+Alt+Control L snap right

riverctl map normal Super+Alt+Shift H resize horizontal -100
riverctl map normal Super+Alt+Shift J resize vertical 100
riverctl map normal Super+Alt+Shift K resize vertical -100
riverctl map normal Super+Alt+Shift L resize horizontal 100
riverctl map normal Super P spawn fuzzel

riverctl map-pointer normal Super BTN_LEFT move-view
riverctl map-pointer normal Super BTN_RIGHT resize-view

riverctl map-pointer normal Super BTN_MIDDLE toggle-float

for $i in 1..9 {
	let tags = (1 | (bits shl $i --number-bytes 2));

	riverctl map normal Super $i set-focused-tags $tags
	riverctl map normal Super+Shift $i set-view-tags $tags
	riverctl map normal Super+Control $i toggle-focused-tags $tags
	riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
}

# Super+0 to focus all tags
# Super+Shift+0 to tag focused view with all tags
let all_tags = (1 | bits shl 32 --number-bytes 8) - 1
riverctl map normal Super 0 set-focused-tags $all_tags
riverctl map normal Super+Shift 0 set-view-tags $all_tags

riverctl map normal Super Space toggle-float
riverctl map normal Super F toggle-fullscreen

riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

riverctl map normal Super+Shift Slash spawn 'brightnessctl 5%+'
riverctl map normal Super Slash       spawn 'brightnessctl +5%'
riverctl map normal Super+Shift Comma spawn 'pamixer -d 5'
riverctl map normal Super Comma       spawn 'pamixer -i 5'

riverctl keyboard-layout -options "caps:super" "us"
riverctl input $touchpad natural-scroll enabled
riverctl input $touchpad tap enabled

# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough

# Super+F11 to enter passthrough mode
riverctl map normal Super F11 enter-mode passthrough

# Super+F11 to return to normal mode
riverctl map passthrough Super F11 enter-mode normal

let modes = [ "normal" "locked" ]

for $mode in $modes {
	riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
	riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
	riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

	riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
	riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
	riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
	riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

	riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
	riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
}

riverctl background-color 0x002b36
riverctl border-color-focused $border_color_focused
riverctl border-color-unfocused $border_color_unfocused 

riverctl set-repeat 45 450

riverctl rule-add -app-id 'float*' -title 'foo' float

riverctl rule-add -app-id "bar" csd

riverctl default-layout rivertile
rivertile -view-padding $padding -outer-padding $padding

riverctl spawn "emacs --daemon"
riverctl spawn "kwalletd6"
riverctl spawn "dunst"
riverctl spawn "xfce4-power-manager"
riverctl spawn "mpd"

# set correct frame rate for monitor when connected
let connected_displays = wlr-randr --json | from json | get name

if ($connected_displays | length) > 0 {
	riverctl spawn "wlr-randr --output 'HDMI-A-I' --mode 1920x1080@100"
}
