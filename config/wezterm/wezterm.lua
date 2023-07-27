local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.font = wezterm.font('JetBrains Mono')
config.font_size = 12.0

config.hide_tab_bar_if_only_one_tab = true
config.unzoom_on_switch_pane = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.scrollback_lines = 10000

config.color_schemes = require('schemes')
config.color_scheme = 'light'

config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 0.95,
}

local scheme = config.color_schemes[config.color_scheme]

local bg = scheme.background
local fg = scheme.foreground

config.colors = {
  tab_bar = {
    background = bg,

    active_tab = {
      bg_color = fg,
      fg_color = bg,
      intensity = 'Bold',
    },

    inactive_tab = {
      bg_color = bg,
      fg_color = fg,
    },

    new_tab = {
      bg_color = bg,
      fg_color = fg,
    },

    new_tab_hover = {
      bg_color = bg,
      fg_color = fg,
    },
  }
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, _, _, _, _, max_width)
    local background = bg
    local foreground = fg

    local title = tab_title(tab)
    if tab.is_active then
      title = wezterm.truncate_right(title, max_width)
      background = fg
      foreground = bg
    else
      title = wezterm.truncate_right((tab.tab_index + 1) .. ':' .. title, max_width)
    end

    return {
      { Text = ' '},
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Text = ' '},
    }
  end
)

require('keys').setup(config)

return config
