------------------------------------
--  Konoha Forest awesome theme   --
--    By Remy CLOUARD (shikamaru) --
--  Inspired from                 --
--  "Zenburn" awesome theme       --
--    By Adrian C. (anrxc)        --
------------------------------------


-- {{{ Main
theme   = {}
confdir = awful.util.getdir("config")
theme.wallpaper_cmd = { "/home/shikamaru/.fehbg &" }
--theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/zenburn/zenburn-background.png" }
-- }}}


-- {{{ Styles
theme.font      = "Profont 8"

-- {{{ Colors
theme.fg_normal = "#52584D"
theme.fg_focus  = "#DCDCCC"
theme.fg_urgent = "#BF0303"
theme.bg_normal = "#000000"
theme.bg_focus  = "#52584D"
theme.bg_urgent = "#451E1A"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#52584D"
theme.border_marked = "#60B48A"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#000000"
theme.titlebar_bg_normal = "#000000"
-- theme.titlebar_[normal|focus]
-- }}}

-- {{{ Widgets
theme.fg_widget        = "#60B48A"
theme.fg_center_widget = "#F7B60F"
theme.fg_end_widget    = "#BF0303"
theme.fg_off_widget    = "#494B4F"
theme.fg_netup_widget  = "#60B48A"
theme.fg_netdn_widget  = "#BF0303"
theme.bg_widget        = "#262626"
theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Taglist and Tasklist
-- theme.[taglist|tasklist]_[bg|fg]_[focus|urgent]
-- }}}

-- {{{ Menu
-- theme.menu_[height|width]
-- theme.menu_[bg|fg]_[normal|focus]
-- theme.menu_[border_color|border_width]
-- }}}
-- }}}
theme.menu_height = 16
theme.menu_width = 127
theme.menu_bg = "#000000"
theme.menu_fg = "#52584D"

-- {{{ Icons
--
-- {{{ Taglist icons
theme.taglist_squares_sel   = confdir .. "/icons/taglist/squarefz.png"
theme.taglist_squares_unsel = confdir .. "/icons/taglist/squareza.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc icons
theme.awesome_icon           = confdir .. "/icons/shikamaru.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout icons
theme.layout_tile       = confdir .. "/icons/layouts/tile.png"
theme.layout_tileleft   = confdir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom = confdir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop    = confdir .. "/icons/layouts/tiletop.png"
theme.layout_fairv      = confdir .. "/icons/layouts/fairv.png"
theme.layout_fairh      = confdir .. "/icons/layouts/fairh.png"
theme.layout_spiral     = confdir .. "/icons/layouts/spiral.png"
theme.layout_dwindle    = confdir .. "/icons/layouts/dwindle.png"
theme.layout_max        = confdir .. "/icons/layouts/max.png"
theme.layout_fullscreen = confdir .. "/icons/layouts/fullscreen.png"
theme.layout_magnifier  = confdir .. "/icons/layouts/magnifier.png"
theme.layout_floating   = confdir .. "/icons/layouts/floating.png"
-- }}}

-- {{{ Widget icons
theme.widget_cpu    = confdir .. "/icons/cpu.png"
theme.widget_bat    = confdir .. "/icons/bat.png"
theme.widget_mem    = confdir .. "/icons/mem.png"
theme.widget_fs     = confdir .. "/icons/disk.png"
theme.widget_net    = confdir .. "/icons/down.png"
theme.widget_netup  = confdir .. "/icons/up.png"
theme.widget_mail   = confdir .. "/icons/mail.png"
theme.widget_vol    = confdir .. "/icons/vol.png"
theme.widget_org    = confdir .. "/icons/cal.png"
theme.widget_date   = confdir .. "/icons/time.png"
theme.widget_crypto = confdir .. "/icons/crypto.png"
-- }}}

-- {{{ Titlebar icons
theme.titlebar_close_button_focus  = confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = confdir .. "/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = confdir .. "/icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = confdir .. "/icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = confdir .. "/icons/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = confdir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = confdir .. "/icons/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}


return theme
