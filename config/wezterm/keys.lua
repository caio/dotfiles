local wezterm = require 'wezterm'
local act = wezterm.action

local mod = {}

function mod.setup(config)
  config.disable_default_key_bindings = true

  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = {
    { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' }, },

    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'K', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = true } },
    { key = ',', mods = 'LEADER', action = act.PromptInputLine {
      description = 'Enter new tab name',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }},

    { key = 'a', mods = 'LEADER', action = act.ActivateLastTab },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
    { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
    { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
    { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
    { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
    { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
    { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
    { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
    { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },

    { key = '-', mods = 'LEADER', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
    { key = '\\', mods = 'LEADER', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

    { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },

    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },

    { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    { key = 'L', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },

    { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
    { key = 'f', mods = 'LEADER', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'phys:Space', mods = 'LEADER', action = act.QuickSelect },

    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },

    { key = 'H', mods = 'LEADER', action = act.AdjustPaneSize{ 'Left', 5 } },
    { key = 'L', mods = 'LEADER', action = act.AdjustPaneSize{ 'Right', 5 } },
    { key = 'K', mods = 'LEADER', action = act.AdjustPaneSize{ 'Up', 5 } },
    { key = 'J', mods = 'LEADER', action = act.AdjustPaneSize{ 'Down', 5 } },
  }

  config.key_tables = {
    copy_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },

      { key = 'v', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Block' } },

      { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },

      { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },

      { key = 'V', mods = 'NONE', action = act.CopyMode{ SetSelectionMode =  'Line' } },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },

      { key = 'd', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (0.5) } },
      { key = 'u', mods = 'CTRL', action = act.CopyMode{ MoveByPage = (-0.5) } },

      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },

      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },

      { key = 'y', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
    },

    search_mode = {
      { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
      { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
      { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },
  }

  return config
end

return mod
