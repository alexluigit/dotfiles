import os
import subprocess
import psutil
from typing import List  # noqa: F401
from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen, Rule
from libqtile.command import lazy
from libqtile.lazy import lazy

ALT="mod1"
HYP="mod3"
SUP="mod4"

terminal = "alacritty"
browser = "bravectl start"
launcher = "rofi -show drun -theme ~/.config/rofi/themes/launcher.rasi"
dmenu = "rofi -show run -theme ~/.config/rofi/themes/dmenu.rasi"
powermenu = "./.config/rofi/scripts/powermenu"
bin_path = os.path.expanduser("~/.local/bin/x/")

# Resize functions for bsp layout
def resize(qtile, direction):
    layout = qtile.current_layout
    child = layout.current
    parent = child.parent
    while parent:
        if child in parent.children:
            layout_all = False
            if (direction == "left" and parent.split_horizontal) or (
                direction == "up" and not parent.split_horizontal
            ):
                parent.split_ratio = max(5, parent.split_ratio - layout.grow_amount)
                layout_all = True
            elif (direction == "right" and parent.split_horizontal) or (
                direction == "down" and not parent.split_horizontal
            ):
                parent.split_ratio = min(95, parent.split_ratio + layout.grow_amount)
                layout_all = True
            if layout_all:
                layout.group.layout_all()
                break
        child = parent
        parent = child.parent

@lazy.function
def resize_left(qtile):
    resize(qtile, "left")

@lazy.function
def resize_right(qtile):
    resize(qtile, "right")

@lazy.function
def resize_up(qtile):
    resize(qtile, "up")

@lazy.function
def resize_down(qtile):
    resize(qtile, "down")

keys = [
    Key([SUP], "a", lazy.spawn(launcher), desc="Launch applications"),
    Key([SUP], "r", lazy.spawn(dmenu), desc="Spawn a command using a prompt widget"),
    Key([SUP], "b", lazy.spawn(browser), desc="Launch Browser"),
    Key([SUP], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([SUP], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([SUP], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([HYP], "space", lazy.group.next_window(), desc="Focus other local window"),
    Key([HYP], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([HYP], "i", lazy.layout.right(), desc="Move focus to right"),
    Key([HYP], "n", lazy.layout.down(), desc="Move focus down"),
    Key([HYP], "e", lazy.layout.up(), desc="Move focus up"),
    Key([HYP], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([HYP], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([HYP], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([HYP], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([SUP,HYP], "Left", resize_left, desc="Resize window to the left"),
    Key([SUP,HYP], "Right", resize_right, desc="Resize window to the right"),
    Key([SUP,HYP], "Down", resize_down, desc="Resize window down"),
    Key([SUP,HYP], "Up", resize_up, desc="Resize window up"),
    Key([SUP,HYP], "f", lazy.window.toggle_floating(), desc="Toggle floating on focused window"),
    Key([SUP,HYP], "t", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([SUP,HYP], "l", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([SUP,HYP], "s", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    KeyChord([SUP], "o", [
        Key([], "d", lazy.spawn("bravectl dev")),
        Key([], "e", lazy.spawn("emacsclient -c")),
        Key([], "f", lazy.spawn("floatwin -t -d 1920x1080+960+0 -n 1 fmenu 1")),
        Key([], "i", lazy.spawn("bravectl inco")),
        Key([], "l", lazy.spawn("floatwin -t -d 1920x2160+0+0 lfrun")),
        Key([], "m", lazy.spawn("floatwin -t -d 1500x600+10+60 ncmpcpp")),
        Key([], "n", lazy.spawn("nautilus")),
        Key([], "p", lazy.spawn("murl toggle")),
        Key([], "s", lazy.spawn("flameshot full -p ~/Pictures/screenshots")),
        Key([], "v", lazy.spawn("murl main")),
        Key([], "x", lazy.spawn("floatwin -t -d 1920x1080+960+1080 -n 2 fmenu 2")),
    ]),
    Key([], "Delete", lazy.spawn(bin_path + "powermenu"), desc="Powermenu"),
    Key([], "Insert", lazy.spawn(bin_path + "smartpaste"), desc="Paste from clipboard"),
    Key([], "F7", lazy.spawn("playerctl -p mpd previous"), desc="Previous song"),
    Key([], "F8", lazy.spawn("playerctl -p mpd play-pause"), desc="Play-pause"),
    Key([], "F9", lazy.spawn("playerctl -p mpd next"), desc="Next song"),
    Key([], "F10", lazy.spawn(bin_path + "eww_vol.sh mute"), desc="Toggle mute"),
    Key([], "F11", lazy.spawn(bin_path + "eww_vol.sh down"), desc="Decrease volume"),
    Key([], "F12", lazy.spawn(bin_path + "eww_vol.sh up"), desc="Increase volume"),
    Key([HYP], "F10", lazy.spawn("xvkbd -xsendevent -text '\[F10]'"), desc="Send F10"),
    Key([HYP], "F11", lazy.spawn("xvkbd -xsendevent -text '\[F11]'"), desc="Send F11"),
    Key([HYP], "F12", lazy.spawn("xvkbd -xsendevent -text '\[F12]'"), desc="Send F12"),
]

BACKGROUND         = "#2e3440"
FOREGROUND         = "#d8dee9"
BACKGROUND_LIGHTER = "#3b4252"
RED                = "#bf616a"
GREEN              = "#a3be8c"
YELLOW             = "#ebcb8b"
BLUE               = "#81a1c1"
MAGENTA            = "#b48ead"
CYAN               = "#88c0d0"
WHITE              = "#e5e9f0"
GREY               = "#4c566a"
ORANGE             = "#d08770"
SUPER_CYAN         = "#8fbcbb"
SUPER_BLUE         = "#5e81ac"
BACKGROUND_DARKER  = "#242831"

layout_theme = {
    "border_width": 4,
    "margin": 4,
    "border_focus": CYAN,
    "border_normal": BACKGROUND_LIGHTER,
    "font": "FiraCode Nerd Font",
    "grow_amount": 2,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
]

workspaces = [
    {"name": "", "key": "1", "matches": [Match(wm_class="emacs")]},
    {"name": "", "key": "2"},
    {"name": "", "key": "3", "matches": [Match(wm_class="libreoffice"),Match(wm_class="org.pwmt.zathura")], },
    {"name": "", "key": "4", "matches": [Match(wm_class="obs")]},
    {"name": "", "key": "5", "matches": [Match(wm_class="gimp")]},
    {"name": "", "key": "6", "matches": [Match(wm_class="slack"),Match(wm_class="zoom")]},
]

groups = []

for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    groups.append(Group(workspace["name"], matches=matches, layout="bsp"))
    keys.append(Key([SUP],workspace["key"], lazy.group[workspace["name"]].toscreen(), desc="Focus this desktop"))
    keys.append(Key([SUP,HYP],workspace["key"], lazy.window.togroup(workspace["name"]), desc="Move focused window to another group"))

widget_defaults = dict(font='FiraCode Nerd Font', fontsize=22, padding=3, background=BACKGROUND)

extension_defaults = widget_defaults.copy()

sep_widget_settings = {
    "foreground": BACKGROUND_LIGHTER,
    "padding": 10,
    "size_percent": 50,
}

def open_dmenu():
    qtile.cmd_spawn(dmenu)

def kill_window():
    qtile.cmd_spawn("xdotool getwindowfocus windowkill")

def open_pavu():
    qtile.cmd_spawn("pavucontrol")

def open_powermenu():
    qtile.cmd_spawn(powermenu)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(**sep_widget_settings),
                widget.TextBox(
                    text="",
                    foreground=CYAN,
                    background=BACKGROUND,
                    font="Font Awesome 5 Free Solid",
                    fontsize=28,
                    padding=20,
                    mouse_callbacks={"Button1": open_dmenu},
                ),
                widget.Sep(**sep_widget_settings),
                widget.GroupBox(
                    font="Font Awesome 5 Brands",
                    fontsize=24,
                    padding=5,
                    borderwidth=4,
                    active=SUPER_BLUE,
                    inactive=GREY,
                    disable_drag=True,
                    rounded=True,
                    highlight_color=BACKGROUND_LIGHTER,
                    block_highlight_text_color=WHITE,
                    highlight_method="block",
                    this_current_screen_border=BACKGROUND_DARKER,
                    this_screen_border=MAGENTA,
                    other_current_screen_border=BACKGROUND_DARKER,
                    other_screen_border=BACKGROUND_DARKER,
                    foreground=FOREGROUND,
                    background=BACKGROUND_DARKER,
                    urgent_border=RED
                ),
                widget.Sep(**sep_widget_settings),
                widget.CurrentLayoutIcon(
                    custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
                    foreground=BACKGROUND_LIGHTER,
                    background=BACKGROUND_DARKER,
                    padding=-2,
                    scale=0.45,
                ),
                widget.Sep(**sep_widget_settings),
                widget.Spacer(),
                widget.Clock(
                    format="%H:%M ",
                    foreground=GREEN,
                    background=BACKGROUND_DARKER,
                    fontsize=28,
                ),
                widget.Clock(
                    format="%d-%a",
                    background=BACKGROUND_DARKER,
                    foreground=GREEN,
                    padding=5,
                    fontsize=20,
                ),
                widget.Sep(**sep_widget_settings),
                widget.TextBox(
                    text=" ",
                    foreground=CYAN,
                    background=BACKGROUND_DARKER,
                    font="Font Awesome 5 Free Solid",
                    fontsize=20,
                ),
                widget.PulseVolume(
                    foreground=CYAN,
                    background=BACKGROUND_DARKER,
                    limit_max_volume="True",
                    mouse_callbacks={"Button3": open_pavu},
                ),
                widget.Sep(**sep_widget_settings),
                widget.TextBox(
                    text=" ",
                    font="Font Awesome 5 Free Solid",
                    foreground=MAGENTA,
                    background=BACKGROUND_DARKER,
                    fontsize=20,
                ),
                widget.Systray(icon_size=24, background=BACKGROUND_DARKER, padding=10),
                widget.Sep(**sep_widget_settings),
                widget.TextBox(
                    text="",
                    foreground=SUPER_BLUE,
                    font="Font Awesome 5 Free Solid",
                    fontsize=30,
                    padding=10,
                    mouse_callbacks={"Button1": open_powermenu},
                ),
                widget.Sep(**sep_widget_settings),
            ],
            50,
            margin=[0, -4, 5, -4],
        ),
    ),
]

mouse = [
    Drag([SUP], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([SUP], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([SUP], "Button2", lazy.window.bring_to_front()),
    Click([], "Button8", lazy.spawn("./.config/qtile/send_key.sh '\Cx'")),
    Click([], "Button9", lazy.spawn("./.config/qtile/send_key.sh '\Aa'")),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
# dgroups_app_rules = [Rule(match=[Match(wm_class='ncmpcpp')], group="", float=True)]
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='mpv'),
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# Window swallowing ;)
@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {
        c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()
    }
    for i in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()

@hook.subscribe.client_killed
def _unswallow(window):
    skip_classes = ("fmenu.1", "fmenu.2")
    if window.window.get_wm_class()[0] in skip_classes:
        return
    if hasattr(window, "parent"):
        window.parent.minimized = False

wmname = "LG3D"
