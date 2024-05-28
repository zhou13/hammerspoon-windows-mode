# hammerspoon-windows-mode

With this project, you are able to replace system-wide hotkeys such as `cmd+c`, `cmd+v` with their
Windows/Linux equivalents, e.g., `ctrl+c`, `ctrl+v`. This project is heavily inpsired by
[karabiner-windows-mode](https://github.com/rux616/karabiner-windows-mode).  However,
Karabiner-Elements operates on a lower level and does not support tools like [Barrier](https://github.com/debauchee/barrier) and [input-leap](https://github.com/input-leap/input-leap).
I need Barrier to switch between my Linux workstation and my MacOS computer.

`hammerspoon-windows-mode` is meant to be more minimistic, so it only implements relavent part of the
keymaps defined in [karabiner-windows-mode](https://github.com/rux616/karabiner-windows-mode) that I
found most useful. However, the configuration framework is already there and it should be easy to
configure it to your needs.  If you think that there is something missing, please open an issue or
PR.

## Installation

First, make sure that `hammerspoon` is installed.  You can install it with homebrew:
```bash
brew install --cask hammerspoon
```

Next, clone this repository as the following:
```bash
cd ~
mv .hammerspoon .hammerspoon.backup
git clone https://github.com/rux616/hammerspoon-windows-mode.git .hammerspoon
```

Finally, click "Reload Config" in `hammerspoon` tray icon. If you have not launched `hammerspoon`, you can simply start the application.  It should work!
The "Console" menu item should help you debugging the problem in case of any issue.

## Shortcuts

By default, the keymap does not apply to hypervisors, IDEs, remote desktops, and terminal emulators.
The actual list of apps bundle ID can be found in [`init.lua`](init.lua).

Below is the full list of shortcuts for people who don't want to read the `init.lua` file:
| Input Key | Input Modifier(s) | Output Key | Output Modifier(s) | Notes |
|-|-|-|-|-|
| A | Ctrl | A | Command |  |
| B | Ctrl | B | Command |  |
| F | Ctrl | F | Command |  |
| H | Ctrl | H | Command | Only applies to web browsers. |
| I | Ctrl | I | Command |  |
| L | Ctrl | L | Command | Only Applies to Web Browsers. |
| N | Ctrl | N | Command |  |
| O | Ctrl | O | Command |  |
| P | Ctrl | P | Command |  |
| R | Ctrl | R | Command |  |
| S | Ctrl | S | Command |  |
| T | Ctrl | T | Command |  |
| U | Ctrl | U | Command |  |
| V | Ctrl | V | Command |  |
| W | Ctrl | W | Command |  |
| X | Ctrl | X | Command |  |
| Y | Ctrl | Y | Command |  |
| Z | Ctrl | Z | Command |  |
| Home |  | Left Arrow | Command |  |
| Home | Shift | Left Arrow | Command+Shift |  |
| End |  | Right Arrow | Command |  |
| End | Shift | Right Arrow | Command+Shift |  |
| Left Arrow | Ctrl | Left Arrow | Option |  |
| Left Arrow | Ctrl+Shift | Left Arrow | Option+Shift |  |
| Right Arrow | Ctrl | Right Arrow | Option |  |
| Right Arrow | Ctrl+Shift | Right Arrow | Option+Shift |  |
