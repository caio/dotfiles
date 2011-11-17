---------------------------
-- Default awesome theme --
---------------------------

theme = {}
theme.wallpaper_cmd = { "nitrogen --restore" }

theme.font          = "Droid Sans Mono 8"

theme.bg_normal     = "#0F0F0F"
theme.bg_focus      = "#0F0F0F"
--theme.bg_urgent     = "#000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#C6C6C6"
theme.fg_focus      = "#FFFFFF"
--theme.fg_focus      = "#D8D9DA"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#000000"

theme.border_width  = "0"
theme.border_normal = "#151515"
theme.border_focus  = "#C6C6C6"
theme.border_marked = "#000000"

theme.basedir = "/usr/share/awesome/themes/default/"


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.basedir .. "taglist/squarefw.png"
theme.taglist_squares_unsel = theme.basedir .. "taglist/squarew.png"

--theme.tasklist_floating_icon = theme.basedir .. "tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.basedir .. "submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.basedir .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.basedir .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.basedir .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.basedir .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.basedir .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.basedir .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.basedir .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.basedir .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.basedir .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.basedir .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.basedir .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.basedir .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.basedir .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.basedir .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.basedir .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.basedir .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.basedir .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.basedir .. "titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme.basedir .. "layouts/fairhw.png"
theme.layout_fairv = theme.basedir .. "layouts/fairvw.png"
theme.layout_floating  = theme.basedir .. "layouts/floatingw.png"
theme.layout_magnifier = theme.basedir .. "layouts/magnifierw.png"
theme.layout_max = theme.basedir .. "layouts/maxw.png"
theme.layout_fullscreen = theme.basedir .. "layouts/fullscreenw.png"
theme.layout_tilebottom = theme.basedir .. "layouts/tilebottomw.png"
theme.layout_tileleft   = theme.basedir .. "layouts/tileleftw.png"
theme.layout_tile = theme.basedir .. "layouts/tilew.png"
theme.layout_tiletop = theme.basedir .. "layouts/tiletopw.png"
theme.layout_spiral  = theme.basedir .. "layouts/spiralw.png"
theme.layout_dwindle = theme.basedir .. "layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
