-- {{{ License
-- rc.lua, currently works with awesome 3.4.8
-- author: Lex Rivera <me at lex.io>
-- based on multiple rc.lua files from different awesome users
--
-- This work is licensed under the Creative Commons Attribution Share
-- Alike License: http://creativecommons.org/licenses/by-sa/3.0/
-- }}}

-- {{{ Load libraries
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("lib/shifty")
-- Menu library
require("lib/freedesktop.utils")
require("lib/freedesktop.menu")
require("lib/freedesktop.desktop")
-- This is needed for vicious from some version
vicious = require("vicious")
-- }}}

-- {{{ Variable definitions
-- Home variable
local home   = os.getenv("HOME")
-- Themes define colours, icons, and wallpapers
beautiful.init(home .. "/.config/awesome/themes/zenburn.lua")

-- This is used later as the default terminal and editor to run.
local terminal = "urxvt"
local editor = "gvim"
local editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- some commands
local commands = {}
commands.poweroff = "sudo poweroff"
commands.suspend = "sudo s2ram -f"
commands.lock = "/usr/lib/kde4/libexec/kscreenlocker --forcelock"
commands.screenshot = "scrot -e `mv $f ~/tmp/`"
--audio stuff
commands.raisevol = "amixer set Master 2%+"
commands.lowervol = "amixer set Master 2%-"
commands.mute = "amixer set Master toggle"
commands.musnext = "mpc next"
commands.musprev = "mpc prev"
commands.muspause = "mpc pause"
commands.mustoggle = "mpc toggle"
-- other apps
commands.calc = "krunner"
commands.screensaver = "/usr/lib/kde4/libexec/kscreenlocker --forcelock"
commands.fileman = "dolphin"
commands.calc = "kcalc"
commands.browser = "chromium"
-- }}}

--{{{ Tags
--{{{ Shifty: configured tags
shifty.config.tags = {
  ["G"] =          { layout = awful.layout.suit.tile,         mwfact=0.60, exclusive = false, solitary = false, position = 1, init = true, screen = 1, slave = true, persist = true } ,
  ["www"] =        { layout = awful.layout.suit.max,                       exclusive = true , solitary = true , position = 2  } ,
  ["swww"] =       { layout = awful.layout.suit.max,                       exclusive = true , solitary = true , position = 3  } ,
  ["im"] =         { layout = awful.layout.suit.tile,         mwfact=0.85, exclusive = true , solitary = true , position = 4  } ,
  ["media"] =      { layout = awful.layout.suit.float,                     exclusive = false, solitary = false, position = 5  } ,
  ["office"] =     { layout = awful.layout.suit.tile,                                                           position = 6  } ,
  ["code"] =       { layout = awful.layout.suit.tile.bottom,  mwfact=0.65, exclusive = true , solitary = true , position = 7  } ,
  ["skype"] =      { layout = awful.layout.suit.tile.bottom,  mwfact=0.65, exclusive = true , solitary = true , position = 8  } ,
  ["irc"] =        { layout = awful.layout.suit.tile.bottom,  mwfact=0.65, exclusive = true , solitary = true , position = 9  } ,
  ["doc"] =        { layout = awful.layout.suit.tile.bottom,  mwfact=0.65, exclusive = true , solitary = true , position = 10 } ,
  ["rdesktop"] =   { layout = awful.layout.suit.tile.max,                  exclusive = true , solitary = true , position = 11 } ,
}
--}}}
 
--{{{ Shifty: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
         { match = { "Chromium","Google Chrome","Gran Paradiso"            } , tag = "www"    } ,
         { match = { "qutim"                                               } , tag = "im"     } ,
         { match = { "Dolphin"                                             } , slave = true   } ,
         { match = { "OpenOffice.*", "Abiword", "Gnumeric", "wxmaxima"     } , tag = "office" } ,
         { match = { "Mplayer.*","gimp", "digikam", "easytag"              } , tag = "media", nopopup = true, } ,
         { match = { "MPlayer", "Gnuplot", "kcalc",                        } , float = true   } ,
         { match = { "MonoDevelop", "gvim", "qtcreator"                    } , tag = "code"   } ,
         { match = { "skype"                                               } , tag = "skype"  } ,
         { match = { "xchat"                                               } , tag = "irc"    } ,
         { match = { terminal                                              } , honorsizehints = false, slave = true   } ,
         { match = { "Okular"                                              } , tag = "doc"    } ,
         { match = { "rdesktop", "remmina"                                 } , tag = "rdesktop" } ,
         { match = { "iron"                                                } , tag = "swww"    } ,
         -- match all
         { match = { "" } ,  buttons = awful.util.table.join(
                                        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
                                        awful.button({ modkey }, 1, awful.mouse.client.move),
                                        awful.button({ modkey }, 3, awful.mouse.client.resize))
  }
}
--}}}
 
--{{{ Shifty: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : wether shifty should try and guess tag names when creating new (unconfigured) tags
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * remember_index: ?
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
  ncol = 1, 
  mwfact = 0.60,
  floatBars=true,
  guess_name=true,
  run = function(tag)
		naughty.notify({ text = "Shifty Created #"..
				 (awful.tag.getproperty(tag,"position") or shifty.tag2index(mouse.screen,tag))..": "..
				 (tag.name or "foo")
				})
		end,
  guess_position = true,
  remember_index = true
}
--}}}
--}}}

-- {{{ Menu
-- applications menu
freedesktop.utils.terminal = terminal

menu_items = freedesktop.menu.new()
myawesomemenu = {
    { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
    { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
    { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = '' }) },
    { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = '' }) }
}
table.insert(menu_items, { "awesome", myawesomemenu, beautiful.awesome_icon })
table.insert(menu_items, { "open terminal", terminal, freedesktop.utils.lookup_icon({icon = 'terminal'}) })

mymainmenu = awful.menu.new({ items = menu_items, width = 150 })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- }}}

-- {{{ Wibox

-- {{{ Widgets configuration

-- {{{ Reusable separators
spacer    = widget({ type = "textbox"  })
separator = widget({ type = "imagebox" })
spacer.text     = " "
separator.image = image(beautiful.widget_sep)
-- }}}

-- {{{ CPU usage
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
-- Initialize widgets
cpugraph  = awful.widget.graph()
-- Graph properties
cpugraph:set_width(40)
cpugraph:set_height(14)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_gradient_angle(0)
cpugraph:set_gradient_colors({ beautiful.fg_end_widget,
   beautiful.fg_center_widget, beautiful.fg_widget
}) -- Register widgets
vicious.register(cpugraph, vicious.widgets.cpu, "$1")
-- }}}

-- {{{ CPU Temperature
tempicon = widget({ type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)
-- Initialize widget
tempwidget = widget({ type = "textbox" })
-- Register widget
    vicious.register(tempwidget, vicious.widgets.thermal,
    function (widget, args)
        if  args[1] >= 65 and args[1] < 75 then
            return "<span color='#d79b1e'> " .. args[1] .. "°C</span>"
        elseif args[1] >= 75 and args[1] < 80 then
            return "<span color='#ff4b4b'> " .. args[1] .. "°C</span>"
        elseif args[1] > 80 then
            naughty.notify({ title = "Temperature Warning", text = "Running hot! " .. args[1] .. "°C!\nTake it easy.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
            return "<span color='#ff4b4b'> " .. args[1] .. "°C</span>"
        else
            return "<span color='#9acd32'> " .. args[1] .. "°C</span>"
        end
    end, 19, "thermal_zone0" )

-- }}}

-- {{{ Battery state
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_bat)
-- Initialize widget
batwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(batwidget, vicious.widgets.bat,
    function (widget, args)
        if  args[2] >= 75 and args[2] < 95 then
            return "<span color='#9acd32'>" .. args[2] .. "%</span>"
        elseif args[2] >= 50 and args[2] < 75 then
            return "<span color='#d79b1e'>" .. args[2] .. "%</span>"
        elseif args[2] >= 20 and args[2] < 50 then
            return "<span color='#ff4b4b'>" .. args[2] .. "%</span>"
        elseif args[2] < 20 and args[1] == "-" then
            naughty.notify({ title = "Battery Warning", text = "Battery low! "..args[2].."% left!\nBetter get some power.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
            return "<span color='#ff4b4b'>" .. args[2] .. "%</span>"
        elseif args[2] < 20 then
            return "<span color='#ff4b4b'>" .. args[2] .. "%</span>"
        else
            return "<span color='#9acd32'>" .. args[2] .. "%</span>"
        end
    end, 23, "BAT1" )

-- }}}

-- {{{ Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
-- Initialize widget
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_width(10)
membar:set_height(12)
membar:set_vertical(true)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_border_color(beautiful.border_widget)
membar:set_gradient_colors({ beautiful.fg_widget,
   beautiful.fg_center_widget, beautiful.fg_end_widget
}) -- Register widget
vicious.register(membar, vicious.widgets.mem, "$1", 13)
-- }}}

-- {{{ Volume level
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)
-- Initialize widgets
volbar = awful.widget.progressbar()
-- Progressbar properties
volbar:set_width(10)
volbar:set_height(12)
volbar:set_vertical(true)
volbar:set_background_color(beautiful.fg_off_widget)
volbar:set_border_color(beautiful.border_widget)
volbar:set_gradient_colors({ beautiful.fg_widget,
   beautiful.fg_center_widget, beautiful.fg_end_widget
}) -- Enable caching
-- Register widgets
vicious.register(volbar, vicious.widgets.volume, "$1",  2, "Master")
-- }}}

-- {{{ Date and time
dateicon = widget({ type = "imagebox" })
-- Initialize widget
datewidget = widget({ type = "textbox" })
-- Register widget
vicious.register(datewidget, vicious.widgets.date, "%R", 61)
-- }}}

-- {{{ System tray
systray = widget({ type = "systray" })
-- }}}

-- }}}

-- {{{ Wibox initialisation
wibox     = {}
promptbox = {}
layoutbox = {}
taglist   = {}
taglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev
))
for s = 1, screen.count() do
    -- Create a promptbox
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create a layoutbox
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1)  end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1)  end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
    ))
    -- Create a taglist
    taglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, taglist.buttons)
    -- Create the wibox
    wibox[s] = awful.wibox({      screen = s,
        fg = beautiful.fg_normal, height = 13,
        bg = beautiful.bg_normal, position = "top",
        border_color = beautiful.border_focus,
        border_width = beautiful.border_width
    })
    -- Add widgets to the wibox
    wibox[s].widgets = {
        {   taglist[s], layoutbox[s], separator, promptbox[s],
            ["layout"] = awful.widget.layout.horizontal.leftright
        },
        s == screen.count() and systray or nil,
        separator, volbar.widget, volicon,
        separator, membar.widget, memicon,
        separator, batwidget, baticon,
        separator, tempwidget, cpugraph.widget, cpuicon,
        separator, ["layout"] = awful.widget.layout.horizontal.rightleft
    }
end

-- {{{ Shifty: initialize shifty
-- the assignment of shifty.taglist must always be after its actually initialized 
-- with awful.widget.taglist.new()
shifty.taglist = taglist
-- }}}

-- }}}

-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    --user defined
    awful.key({                   }, "XF86PowerOff",         function() awful.util.spawn_with_shell(commands.poweroff) end ),
    awful.key({ modkey,           }, "F12",                  function() awful.util.spawn_with_shell(commands.lock) end),
    --audio stuff
    awful.key({                   }, "XF86AudioMute",        function() awful.util.spawn_with_shell(commands.mute) end ),
    awful.key({                   }, "XF86AudioRaiseVolume", function() awful.util.spawn_with_shell(commands.raisevol) end ),
    awful.key({                   }, "XF86AudioLowerVolume", function() awful.util.spawn_with_shell(commands.lowervol) end ),
    awful.key({                   }, "XF86AudioNext",        function() awful.util.spawn_with_shell(commands.musnext) end ),
    awful.key({                   }, "XF86AudioPrev",        function() awful.util.spawn_with_shell(commands.musprev) end ),
    awful.key({                   }, "XF86AudioPlay",        function() awful.util.spawn_with_shell(commands.mustoggle) end ),
    awful.key({                   }, "XF86Tools",            function() awful.util.spawn_with_shell(commands.musplay) end ),
    awful.key({                   }, "XF86Calculator",       function() awful.util.spawn_with_shell(commands.calc) end ),
    awful.key({                   }, "XF86ScreenSaver",      function() awful.util.spawn_with_shell(commands.screensaver) end ),
    awful.key({                   }, "Print",                function() awful.util.spawn_with_shell(commands.screenshot) end ),
    awful.key({                   }, "XF86Sleep",            function() awful.util.spawn_with_shell(commands.suspend) end ),
    --default bindings
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Control" }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey, "Control" }, "Right",  shifty.shift_next       ),
    awful.key({ modkey            }, "t",      function() shifty.add({ rel_index = 1 }) end),
    awful.key({ modkey, "Control" }, "t",      function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey            }, "i",      shifty.rename),
    awful.key({ modkey            }, "w",      shifty.del),
    awful.key({ modkey,           }, "u",      awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "n",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    -- Layout manipulation
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    -- Prompt
    awful.key({ modkey,           }, "e",     function () awful.prompt.run({prompt="Run:"},
                                               promptbox[mouse.screen].widget,
                                               check_for_terminal,
                                               clean_for_completion)
                                               end)
)
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "j",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- {{{ bindings / global / shifty.getpos
for i=1, ( shifty.config.maxtags or 9 ) do
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i,
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i,
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i,
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i,
    function ()
      if client.focus then
        local t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
end
-- }}}

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Register keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
-- }}}

-- {{{ Functions
-- {{{ functions to help launch run commands in a terminal using ":" keyword 
function check_for_terminal (command)
   if command:sub(1,1) == ":" then
      command = terminal .. ' -e ' .. command:sub(2)
   end
   awful.util.spawn(command)
end
   
function clean_for_completion (command, cur_pos, ncomp, shell)
   local term = false
   if command:sub(1,1) == ":" then
      term = true
      command = command:sub(2)
      cur_pos = cur_pos - 1
   end
   command, cur_pos =  awful.completion.shell(command, cur_pos,ncomp,shell)
   if term == true then
      command = ':' .. command
      cur_pos = cur_pos + 1
   end
   return command, cur_pos
end
-- }}}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })
    -- remove gaps
    c.size_hints_honor = false

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)
shifty.init()
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart
function autostart(dir)
    if not dir then
        do return nil end
    end
    local fd = io.popen("ls -1 -F " .. dir)
    if not fd then
        do return nil end
    end
    for file in fd:lines() do
        local c= string.sub(file,-1)   -- last char
        if c=='*' then  -- executables
            executable = string.sub( file, 1,-2 )
            print("Awesome Autostart: Executing: " .. executable)
            awful.util.spawn_with_shell(dir .. "/" .. executable .. "") -- launch in bg
        elseif c=='@' then  -- symbolic links
            print("Awesome Autostart: Not handling symbolic links: " .. file)
        else
            print("Awesome Autostart: Skipping file " .. file .. " not executable.")
        end
    end
    io.close(fd)
end

autostart_dir = os.getenv("HOME") ..  "/.config/awesome/autorun"
autostart(autostart_dir)
-- }}}

-- vim: fdm=marker fdl=0 sts=4 ai
