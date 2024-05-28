local eventtap = hs.eventtap
local eventTypes = eventtap.event.types
local keycodes = hs.keycodes.map

SKIPPED_BUNDLE_IDS = {
  ["org.virtualbox.app.VirtualBoxVM"] = true,
  ["com.parallels.desktop.console"] = true,
  ["org.vmware.fusion"] = true,
  ["org.gnu.emacs"] = true,
  ["org.gnu.Emacs"] = true,
  ["com.jetbrains"] = true,
  ["com.microsoft.VSCode"] = true,
  ["com.vscodium"] = true,
  ["com.sublimetext.3"] = true,
  ["net.kovidgoyal.kitty"] = true,
  ["com.citrix.XenAppViewer"] = true,
  ["com.microsoft.rdc.macos"] = true,
  ["io.alacritty"] = true,
  ["co.zeit.hyper"] = true,
  ["com.googlecode.iterm2"] = true,
  ["com.apple.Terminal"] = true,
  ["com.github.wez.wezterm"] = true,
}

SCENE_BUNDLE_IDS = {
  browser = {
    ["com.google.Chrome"] = true,
    ["com.brave.Browser"] = true,
    ["com.vivaldi.Vivaldi"] = true,
    ["org.mozilla.firefox"] = true,
    ["org.mozilla.nightly"] = true,
    ["com.apple.Safari"] = true,
  },
}

KEY_MAPS = {
  ["ctrl+a"] = "cmd+a",
  ["ctrl+b"] = "cmd+b",
  ["ctrl+c"] = "cmd+c",
  ["ctrl+f"] = "cmd+f",
  ["ctrl+g"] = "cmd+g",
  ["ctrl+h"] = "cmd+h",
  ["ctrl+i"] = "cmd+i",
  ["ctrl+l"] = "cmd+l",
  ["ctrl+n"] = "cmd+n",
  ["ctrl+o"] = "cmd+o",
  ["ctrl+p"] = "cmd+p",
  ["ctrl+r"] = "cmd+r",
  ["ctrl+s"] = "cmd+s",
  ["ctrl+t"] = "cmd+t",
  ["ctrl+u"] = "cmd+u",
  ["ctrl+v"] = "cmd+v",
  ["ctrl+w"] = "cmd+w",
  ["ctrl+x"] = "cmd+x",
  ["ctrl+y"] = "cmd+y",
  ["ctrl+z"] = "cmd+z",

  ["home"] = "cmd+left",
  ["shift+home"] = "cmd+shift+left",
  ["end"] = "cmd+right",
  ["shift+end"] = "cmd+shift+right",
  ["ctrl+delete"] = "option+delete", -- delete is backspace in OSX
  ["ctrl+forwarddelete"] = "option+forwarddelete",  -- forwarddelete is delete in OSX
  ["ctrl+left"] = "option+left",
  ["ctrl+shift+left"] = "option+shift+left",
  ["ctrl+right"] = "option+right",
  ["ctrl+shift+right"] = "option+shift+right",
}

KEY_MAP_SCENES = {
  ["ctrl+h"] = "browser",
  ["ctrl+l"] = "browser",
}

local function setHotkey(hotkey, event)
  print("set hotkey: " .. hotkey)
  local keycode = event:getKeyCode()
  local flags = event:getFlags()
  flags.ctrl = false
  flags.option = false
  flags.cmd = false
  flags.shift = false
  for key, plusSign in string.gmatch(hotkey, "([^+]+)([+]?)") do
    print(key, plusSign)
    if plusSign == "+" then
      if key == "ctrl" then
        flags.ctrl = true
      elseif key == "option" then
        flags.alt = true
      elseif key == "cmd" then
        flags.cmd = true
      elseif key == "shift" then
        flags.shift = true
      end
    else
      keycode = keycodes[key]
    end
  end
  event:setKeyCode(keycode)
  event:setFlags(flags)
end

local function toHotkey(event)
  local keycode = event:getKeyCode()
  local flags = event:getFlags()
  local hotkey = ""
  if flags.ctrl then
    hotkey = hotkey .. "ctrl+"
  end
  if flags.cmd then
    hotkey = hotkey .. "cmd+"
  end
  if flags.cmd then
    hotkey = hotkey .. "option+"
  end
  if flags.shift then
    hotkey = hotkey .. "shift+"
  end
  if hotkey:sub(-1) ~= "+" then
    hotkey = hotkey:sub(1, -2)
  end
  if keycodes then
    hotkey = hotkey .. keycodes[keycode]
  end
  print("read hotkey: " .. hotkey)
  return hotkey
end

local function eventHandler(event)
  local activeWindow = hs.window.focusedWindow()
  local bundleID
  if activeWindow ~= nil then
    local activeApp = activeWindow:application()
    bundleID = activeApp:bundleID()
    if SKIPPED_BUNDLE_IDS[bundleID] ~= nil then
      return false
    end
  end

  print("bundleID: " .. bundleID)
  local hotkey = toHotkey(event)
  local mapped_hotkey = KEY_MAPS[hotkey]
  if mapped_hotkey ~= nil then
    local scene = KEY_MAP_SCENES[hotkey]
    if scene ~= nil then
      if SCENE_BUNDLE_IDS[scene][bundleID] == nil then
        return false
      end
    end
    setHotkey(mapped_hotkey, event)
  end

  return false
end

eventtap
  .new({
    eventTypes.flagsChanged,
    eventTypes.keyDown,
    eventTypes.keyUp,
  }, eventHandler)
  :start()

-- vim: set sw=2:
