-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
vicious         = require("vicious")
local lain      = require("lain")
local blingbling = require("blingbling")
local freedesktop = require("freedesktop")
--local widgets = require("actionless.widgets")
--local tasklist_addon = require("actionless.tasklist_addon")
--local persistent = require("actionless.persistent")
--require("applicationsmenu")
--cal = require("calendar")
local calendar = lain.widget.calendar()
scratch = require("scratch")
local APW = require("apw/widget")
local hotkeys_popup = require("awful.hotkeys_popup").widget
--local radical = require("radical")
--require("collision")()
local desktop_icons = require("desktop_icons")
local mpd = require("mpd")
require("mic")
local ramgraph_widget = require("ram-widget") 
local watch = require("awful.widget.watch")
mpdarc = require("mpdarc")

--awful.util.spawn_with_shell("sleep 14 && xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7 &")
--awful.util.spawn_with_shell("xcompmgr -cCfF &")
--awful.util.spawn_with_shell("sleep 7 && killall xcompmgr &")
awful.spawn.with_shell("sleep 17 && compton -icCfF -r7 -o.65 -l-10 -t-8 -D7 &")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
beautiful.init("/home/valera/.config/awesome/themes/colored/theme.lua")
-- This is used later as the default terminal and editor to run.
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "leafpad"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

--for s in screen do
--    freedesktop.desktop.add_icons({screen = s})
--end

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end, "/home/valera/sharingan-icons-1.5/acestream16.png"},
   { "manual", "xterm -e man awesome", "/home/valera/.icons/Black Diamond-V2/scalable/places/folder-documents.png"},   
  -- { "edit config", editor_cmd .. " " .. awesome.conffile, "/home/valera/.icons/Black Diamond-V2/scalable/emblems/emblem-xxs.png"},
   { "edit config", "leafpad /home/valera/.config/awesome/rc.lua", "/home/valera/.icons/Black Diamond-V2/scalable/emblems/emblem-xxs.png"},
   { "edit desktop_i", "leafpad /home/valera/.config/awesome/desktop_icons.lua", "/home/valera/.config/awesome/appicons/desktop.png"},
   { "restart", awesome.restart, "/home/valera/sharingan-icons-1.5/clamtk.png"},
   { "quit", function() awesome.quit() end, "/home/valera/sharingan-icons-1.5/Curtains.png"}
}

standart_menu = {
    { "Opera", "opera-developer","/usr/share/pixmaps/opera-developer.xpm" },
    { "KDE", "systemsettings5", "/home/valera/.icons/Black Diamond-V2/scalable/devices/gnome-dev-harddisk-1394.png" },
    { "Pcmanfm", "pcmanfm", "/home/valera/.icons/Black Diamond-V2/scalable/apps/folder_wine_burgunder.png" },
    { "CHROME", "google-chrome-stable", "/home/valera/.icons/Black Diamond-V2/scalable/apps/22/chromium-browser.png" },
    { "KlaVa", "onboard", "/home/valera/.icons/Black Diamond-V2/scalable/apps/gnutella.png" },
    { "FiReFox", "firefox", "/home/valera/.icons/Black Diamond-V2/scalable/apps/firefox.png" },
    { "TOR", "env GTK_THEME=Boje-Red /home/valera/tor/Browser/start-tor-browser --detach", "/home/valera/.icons/Black Diamond-V2/scalable/apps/epiphany-bookmarks.png" },
    { "Google-Earth", "google-earth", "/home/valera/.icons/Black Diamond-V2/scalable/apps/googleearth-icon.png" },
    { "Aisleriot", "env GTK_THEME='Fire Red Theme' sol", "/usr/share/icons/Black Diamond-V2/scalable/apps/gnome-aisleriot.png" },
    { "XTERM", "xterm", "/home/valera/.icons/Black Diamond-V2/scalable/apps/xterm.png"  },
    { "KDEnLive", "kdenlive", "/home/valera/.icons/Black Diamond-V2/scalable/apps/kdenlive.png" }             
}

mymainmenu = freedesktop.menu.build({
                                     before = {
                                      { "awesome", myawesomemenu, "/home/valera/.icons/Black Diamond-V2/scalable/places/emptytrash.png" },
                                      { "____________"},
                                    -- other triads can be put here
                                      },
                                    
                                    after = {
                                     { "____________"},
                                   -- { "awesome", myawesomemenu, "/home/valera/.icons/Black Diamond-V2/scalable/places/emptytrash.png" },
                                    { "PR", standart_menu, "/home/valera/.icons/Black Diamond-V2/scalable/categories/preferences-other.png" },
                                    { "____________"},
                                    --{ "Terminal", terminal, "/home/valera/.icons/Black Diamond-V2/scalable/apps/gnome-system-monitor.png" },
                                    --{ "HOME", "gksu dbus-launch thunar", "/home/valera/.config/awesome/image-missing.png" },
                                    --{ "OPERA", "opera", "/home/valera/.icons/opera.png" },
                                    { "Reboot", "systemctl reboot", "/home/valera/.icons/Black Diamond-V2/scalable/web-browser.png"},
                                    { "STOP",  "systemctl poweroff", "/home/valera/.icons/Black Diamond-V2/scalable/actions/gnome-session-logout.png"}
                                   }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

    -- Each screen has its own tag table.
--awful.tag({ 1, 2, 3, 4, 5 }, s, awful.layout.layouts[1])

local names = { "Ƅ", "ƀ", "Ɵ", "ƈ", "Ɗ" }
--local names = { "Ƅ", "Ɵ", "ƈ", "Ɗ" }
local l = awful.layout.suit  -- Just to save some typing: use an alias.
local layouts = { l.tile.bottom, l.tile.bottom, l.tile.bottom, l.spiral.dwindle, l.floating }
--local layouts = { l.tile.bottom, l.tile.bottom, l.spiral.dwindle, l.floating }
awful.tag(names, s, layouts )
awful.screen.connect_for_each_screen(function(s)
--local t = awful.tag.find_by_name(awful.tag.setncol( 4 ),"ƀ" ) 
--local _tag = awful.tag.find_by_name(awful.tag.setmwfact(0.15, t3), "ƈ" ) 
--awful.tag.setncol( 4, t )
--awful.tag.setncol( 2, t1)
--awful.tag.setmwfact (0.15, screen[1].tags[3])
awful.tag.setnmaster(1, screen[1].tags[3])
awful.tag.setncol( 3, screen[1].tags[1])
awful.tag.setncol( 2, screen[1].tags[2])
awful.tag.setncol( 2, screen[s].tags[3])
--awful.tag.setmwfact(0.15, _tag)
--awful.tag.setmfpol(0.70, screen[s].tags[3])
--awful.tag.seticon("/home/valera/Sharingan Icons by Kshegzyaj/PNG/128x128/Sharingan 2 Virgules.png", screen[s].tags[1]) 
awful.tag.setproperty(screen[s].tags[3], "master_width_factor", 0.70)
end)
------------------------


-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
-------------
mytextclockicon = wibox.widget.imagebox()
mytextclockicon.image = "/home/valera/.icons/Black Diamond-V2/scalable/actions/editdelete.png"

mytextclock1 = wibox.widget.textclock(" <span color=\"#e65117\"><span font=\"odstemplik Bold 18\"><b>%H:%M</b></span></span>")
lain.widget.calendar({
    attach_to = { mytextclock1 }
})
--widgets.calendar:attach(mytextclockicon)

--{{{--Kbdd----------------------------------------------------------------

function change()
kbd_next_cmd = "dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout"
awful.util.spawn_with_shell(kbd_next_cmd)
end
kbdwidget = wibox.widget.textbox()

kbdwidget.markup = "<span color=\"#e65117\"><b><span font=\"odstemplik Bold 11\">⌨ </span>ℰN</b></span>"
dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
        local data = {...}
        local layout = data[2]
        lts = {[0] = "<span color=\"#e65117\"><b><span font=\"odstemplik Bold 11\">⌨ </span>ℰN</b></span>", [1] = "<span color=\"#0400ff\"><b><span font=\"odstemplik Bold 11\">⌨ </span>ℜU</b></span>"}
        kbdwidget:set_markup(lts[layout])
        end
        )
kbdwidget:buttons(awful.util.table.join(awful.button({ }, 1, change)))
fixedwidget4 = wibox.layout.constraint(kbdwidget, "exact", 51)
kbdwidget:set_align("center")

--CPU---------------
---- Инициализация виджета
--cpuwidget = awful.widget.graph()
---- Свойства графика
--cpuwidget.width = 50
--cpuwidget.background_color = "#00000080"
--cpuwidget.color = { type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#ed0c0c"}, {0.5, "#71e21b"}, 
--                    {1, "#ee170c" }}}
---- Регистрация виджета
--vicious.register(cpuwidget, vicious.widgets.cpu, "$1" ,5)
---- Инициализация виджета
--cpuwidget2 = wibox.widget.textbox()
-- Регистрация виджета
--vicious.register(cpuwidget2, vicious.widgets.cpu, "$2%" ,2)
--fixedwidget = wibox.layout.constraint(cpuwidget2, "exact", 35)
---cpuwidget2:set_align("center")

cpu_icon = awful.widget.launcher({ name = "htop",
                                     image = "/home/valera/.config/awesome/appicons/cp21.png",
                                     command = "xfce4-terminal -e htop"})
local markup = lain.util.markup
local cpu = lain.widget.cpu({
    timeout = 5,
    settings = function()
        widget:set_markup(markup.fontfg("odstemplik Bold 15", "#e65117", ":".. cpu_now.usage .. "%"))
    end
})
cpu = wibox.layout.constraint(widget, "exact", 35)
widget:set_align("center")
-----------

--Sensors
tempwidget = awful.widget.launcher({ name = "weather",
                                     image = "/home/valera/sharingan-icons-1.5/speedownload.png",
                                     command = "gis-weather"})
sensors = wibox.widget.textbox()
vicious.register(sensors, vicious.widgets.thermal, "<span color=\"#e65117\"><span font=\"odstemplik Bold 14\"><b>$1°C</b></span></span>", 3, { "coretemp.0/hwmon/hwmon1", "core"} ,5)
fixedwidget1 = wibox.layout.constraint(sensors, "exact", 32)
sensors.align = "center"
local function disptemp()
	local f, infos
	local capi = {
		mouse = mouse,
		screen = screen
	}

	f = io.popen("sensors  nouveau-pci-0100")
	infos = f:read("*all")
	f:close()

	showtempinfo = naughty.notify( {
                font = "odstemplik Bold 14",
		text	= infos,
		timeout	= 0,
        position = "top_right",
        margin = 10,
        height = 200,
        width = 420,
        border_color = '#404040',
        border_width = 2,
        -- opacity = 0.95,
		screen	= capi.mouse.screen })
end

sensors:connect_signal('mouse::enter', function () disptemp(path) end)
sensors:connect_signal('mouse::leave', function () naughty.destroy(showtempinfo) end)

-----------

function sensors:fit(context, width, height) return width, height end
local sensors1 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
sensors1:geometry({ x = 1413, y = 799, width = 24, height = 50 })
sensors1:set_widget(sensors)

--------------
----------------

--memicon = wibox.widget.imagebox()
--memicon.image = "/home/valera/.icons/Black Diamond-V2/scalable/apps/gnome-system-monitor.png"
memicon = awful.widget.launchers({ name = "prev",
                                     image = "/home/valera/.config/awesome/appicons/xfce4-terminal.png",
                                     command = "xfce4-terminal -e htop"})

-- Memory
memwidget = wibox.widget.textbox()
--vicious.register(memwidget, vicious.widgets.mem, "<span font=\"odstemplik Bold 14\"><b>$2/$3</b></span>", 1)
vicious.register(memwidget, vicious.widgets.mem, "<span color=\"#e65117\"><span font=\"odstemplik Bold 14\"><b>$2 m</b></span></span>", 5)
--vicious.register(memwidget, vicious.widgets.mem, "<span >$2 m</span>", 5)
fixedmemwidget = wibox.layout.constraint(memwidget, "exact", 147)
memwidget.align = "center"
fixedwidget3 = wibox.layout.constraint(memwidget, "exact", 50)
--fixedwidget3:set_width(50)
-----------
-----------
--- Widget which is shown when user clicks on the ram widget
local w = wibox {
    height = 200,
    width = 400,
    ontop = true,
    screen = mouse.screen,
    expand = true,
   -- bg = '#1e252c',
    font = "Z003",
    bg = '#00000030',
    max_widget_size = 500
}

w:setup {
    border_width = 2,
    font = "odstemplik Bold",
    colors = {
        '#f92603',
        '#e65117',
        '#2a0000',
    },
    display_labels = false,
    forced_width = 25,
    id = 'pie',
    widget = wibox.widget.piechart,
}

local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

local function getPercentage(value)
    return math.floor(value / (total+total_swap) * 100 + 0.5) .. '%'
end

watch('bash -c "free | grep -z Mem.*Swap.*"', 1,
    function(widget, stdout, stderr, exitreason, exitcode)
        total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
            stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

        widget.data = { used, total-used } widget.data = { used, total-used }

        if w.visible then
            w.pie.data_list = {
                {'used ' .. getPercentage(used + used_swap), used + used_swap},
                {'free ' .. getPercentage(free + free_swap), free + free_swap},
                {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
            }
        end
    end,
   memicon
)

memicon:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            awful.placement.top_right(w, { margins = {top = 25, right = 168}})
            w.pie.data_list = {
                {'used ' .. getPercentage(used + used_swap), used + used_swap},
                {'free ' .. getPercentage(free + free_swap), free + free_swap},
                {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
            }
            w.pie.display_labels = true
            w.visible = not w.visible
        end)
    )
)
-----------------

volicon = awful.widget.launchers({ name = "pavucontrol",
                                     image = "/home/valera/.config/awesome/appicons/armagetronad.png",
                                     command = "pavucontrol"})
--volumewidget = wibox.widget.textbox()
--vicious.register( volumewidget, vicious.widgets.volume, "<span color=\"#ffde00\">$1%</span>", 1, "Master" )
-------------------

-- {{{ PACMAN
-- Icon

pacman=awful.widget.launcher({ name = "pacman",
                                     image = "/home/valera/.config/awesome/appicons/skull32.png",
                                     command = "xfce4-terminal -e 'yaourt -Syyu --aur'"})
-- Pacman Widget
pacwidget = wibox.widget.textbox()

pacwidget_t = awful.tooltip({ objects = { pacwidget},})

vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    --local s = io.popen("pacman -Qu -b /tmp/checkup-db-valera")
                    local s = io.popen("/usr/bin/checkupdates")
                    local str = ''
		    local i = 0

                    for line in s:lines() do
                        str = str .. line .. "\n"
                        i = i + 1
		    end
                    pacwidget_t:set_text(str)
                    s:close()
                    return "<span color=\"#e65117\"><b>:"  .. i ..  "</b></span>"
                end, 1800, "Arch C")
pacwidget:set_font("odstemplik Bold 17")

--
-- Network Widget
netwidget = blingbling.net({ interface = "enp3s0", show_text = false, timeout = 5 })
netwidget:set_ippopup()
netwidget:set_graph_line_color("#e65117ff")
----netwidget:set_background_color("#f7010150")
netwidget:set_graph_color("#f70101ff")
----netwidget:set_background_graph_color("#00ea00ff")
netwidget:set_text_color("#e65117")
netwidget:set_font("odstemplik Bold")
netwidget:set_font_size(14)
netwidget.height = 0.50
fixedwidget5 = wibox.layout.constraint(netwidget, "exact", 19)
-----------
fixempd = wibox.layout.constraint(mpdarc, "exact", 17)
----------
spr = wibox.widget.imagebox()
spr.image = "/home/valera/.config/awesome/icons/mpd/separators/spr.png"
spr5px = wibox.widget.imagebox()
spr5px.image = "/home/valera/.config/awesome/icons/mpd/separators/spr5px.png"

-- Create a laucher widget
--myapp1start = awful.widget.launcher({ name = "firefox",
--                                     image = "/home/valera/.config/awesome/appicons/firefox.png",
--                                     command = "firefox"
--                                     })

-- Create a laucher widget
myapp2start = awful.widget.launcher({ name = "thunar",
                                     image = "/home/valera/.config/awesome/appicons/thunar.png",
                                     --command = "dbus-launch thunar"})
                                     command = "pcmanfm"})

-- Create a laucher widget
myapp3start = awful.widget.launcher({ name = "xfce4-terminal",
                                     image = "/home/valera/.config/awesome/appicons/xfce4-terminal.png",
                                     command = "xfce4-terminal"})

-- Create a laucher widget
myapp4start = awful.widget.launcher({ name = "fbreader",
                                     image = "/home/valera/.config/awesome/appicons/cr3.png",
                                     command = "FBReader"})

-- Create a laucher widget
myapp5start = awful.widget.launcher({ name = "palemoon",
                                     image = "//home/valera/.config/awesome/appicons/a10.png",
                                     command = "google-chrome-stable"})

-- Create a laucher widget
myapp7start = awful.widget.launcher({ name = "opera",
                                     image = "/home/valera/.config/awesome/appicons/opera.png",
                                     command = "opera"})

-- Create a laucher widget
myapp8start = awful.widget.launcher({ name = "thunderbird",
                                     image = "/usr/share/icons/gnome/32x32/apps/thunderbird.png",
                                     command = "thunderbird"})


space = wibox.widget.textbox()
--space.text = " ⍿ "
space.text = " ╠ "

space2 = wibox.widget.textbox()
space2.text = " ╣ "

space3 = wibox.widget.textbox()
space3.text = " "

space1 = wibox.widget.textbox()
space1.text = "  "

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

local tag_menu = {
    {"⸻⸻⸻"},
    { "Add Tag",      function() lain.util.add_tag()     end, "/usr/share/icons/Black Diamond-V2/scalable/actions/add1.png" },    
    { "Rename Tag",  function() lain.util.rename_tag()  end, "/home/valera/.icons/Black Diamond-V2/scalable/places/emptytrash.png" },
    { "Tag right",          function() lain.util.move_tag(1)   end, "/home/valera/.config/awesome/themes/colored/icons/right.png" },
    { "Tag left",          function() lain.util.move_tag(-1)  end , "/home/valera/.config/awesome/themes/colored/icons/left.png" },
    { "Delete Tag",        function() lain.util.delete_tag()  end, "/usr/share/icons/Black Diamond-V2/scalable/categories/internet.png" },
    { "Clients", function() awful.menu.clients() end, "/usr/share/icons/Black Diamond-V2/scalable/apps/console.png" },
    {"            "}
}
---------
--Tag_menu
local function tag_menu_toggle()
    local instance = nil
    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            --instance = lain.util.menu_clients_current_tags(tag_menu)
              instance =  awful.menu(tag_menu):show() 
        end
    end
end
------------
-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 2, awful.tag.viewtoggle), 
                    awful.button({ }, 3, tag_menu_toggle () ),                                                                  
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag_fn(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
-------------
---Client_menu

local t1 = awful.tag.find_by_name(awful.client.movetotag( "Ƅ" ),"Ƅ" )  
local t2 = awful.tag.find_by_name(awful.client.movetotag( "ƀ" ),"ƀ" )
local t2 = awful.tag.find_by_name(awful.client.movetotag( "Ɵ" ),"Ɵ" )
local t3 = awful.tag.find_by_name(awful.client.movetotag( "ƈ" ),"ƈ" )
local t4 = awful.tag.find_by_name(awful.client.movetotag( "Ɗ" ),"Ɗ" )


local t_menu ={ 
           {"____FIRST", function() awful.client.movetotag(t1) end },
           {"____SECOND", function() awful.client.movetotag(t2) end},
           {"____THIRD", function() awful.client.movetotag(t3) end},
           {"____FOURTH", function() awful.client.movetotag(t4) end},
           {"____FIFTH", function() awful.client.movetotag(t5) end},           
}

local move_menu = ({ items = { { "Move to tag", t_menu, "/usr/share/icons/Black Diamond-V2/scalable/11.png" },
             {"Floating",  function() awful.client.floating.toggle(c) end, "/usr/share/icons/Black Diamond-V2/scalable/12.png" },
             {"Ontop",  function() client.focus.ontop = not client.focus.ontop client.focus:raise() end , "/usr/share/icons/Black Diamond-V2/scalable/actions/25.png"},
             {"Minimized", function() client.focus.minimized = true client.focus:raise() end, "/usr/share/icons/Black Diamond-V2/scalable/actions/26.png"},
             {"Maximized", function() client.focus.maximized = not client.focus.maximized client.focus:raise() end, "/usr/share/icons/Black Diamond-V2/scalable/actions/27.png"},
             {"Fullscreen", function() client.focus.fullscreen = not client.focus.fullscreen end, "/usr/share/icons/Black Diamond-V2/scalable/places/16/folder-drag-accept.png"},
             {"V_Max", function() client.focus.maximized_vertical = not client.focus.maximized_vertical client.focus:raise() end, "/usr/share/icons/Black Diamond-V2/scalable/vert.png"},
             {"H_Max",  function() client.focus.maximized_horizontal = not client.focus.maximized_horizontal client.focus:raise() end, "/usr/share/icons/Black Diamond-V2/scalable/horis.png"},
             {"Restore",  function() client.focus.maximized_vertical = not client.focus.maximized_vertical client.focus.maximized_horizontal = not client.focus.maximized_horizontal client.focus:raise() end, "/usr/share/icons/Black Diamond-V2/scalable/restore.png"},
             {"Close", function() client.focus:kill() end,  "/usr/share/icons/Black Diamond-V2/scalable/actions/add.png"},
             { "Clients", function(c) awful.menu.clients() end, "/usr/share/icons/Black Diamond-V2/scalable/apps/console.png" }, 
                                  }
                        })   

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                 
                    awful.button({ }, 8, client_menu_toggle_fn()),                   
                  awful.button({ }, 2, function (c)  c:kill()                         end),                                  
                  awful.button({ }, 3, function (c)
                                        if instance then
                                        instance:hide()
                                        instance = nil
                                    else
                                     instance = awful.menu(move_menu):toggle()
                                       end
                                       end,
                                          function (c)
                                          client.focus = c
                                                  c:raise()
                                              end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)




    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            space1,
            mylauncher,
            space,
            s.mytaglist,
            space2,
              -- MPD widget
          spr,
          prev_icon,
          spr,
          fixempd,
          spr,
          stop_icon,
          spr,
          next_icon,
          spr,
           -- space,
           -- myapp1start,
            space,
            myapp7start,
            space2,
            myapp3start,
            space,
            myapp4start,
            space2,
            myapp5start,
            space,
            myapp2start,
            space2,
            --myapp8start,
            --space2,
            space1,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
           -- mykeyboardlayout,
          space,
          wibox.widget.systray(),
          space2,
         -- space1,
            fixedwidget5,
            space,
            fixedwidget4,
            space2,
            pacman,
            pacwidget,
            space,
            cpu_icon,
            cpu,
            --cpuwidget,
            --space1,
            --cpuwidget2,
            --fixedwidget,
            space2,
            tempwidget,
            fixedwidget1,
            space,
            memicon,
            fixedwidget3,
            space2,
            volicon,
            APW,
            space,
            --mytextclock,
            micon,
            mytextclock1,
            --space3,
            space2,
            s.mylayoutbox,
           -- space2,
        },
    }
end)
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
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ }, "F6", function () scratch.pad.toggle() end),
    awful.key({ }, "F7", function () scratch.drop("xfce4-terminal", "bottom", nil, nil, 0.30) end),
    --awful.key({ }, "F2", function () scratch.drop("opera", c, nil, nil, 1.00, 0.90) end),
    awful.key({ }, "F2", function () awful.spawn("opera") end),
    --awful.key({ }, "F3", function () awful.spawn("thunar") end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),


    -- Prompt
    awful.key({  },            "Menu",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)


clientkeys = awful.util.table.join(
    awful.key({ }, "F5", function (c) scratch.pad.set(c, 0.80, 0.60, true) end),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,     }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({  }, 8, awful.mouse.client.move),
    awful.button({ }, 9, function () awful.menu(move_menu):toggle() end),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },    
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     size_hints_honor = false,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen                    
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
       { rule = { class = "MPlayer" },
      properties = { floating = true } },
     { rule = { class = "Clementine" },
      properties = { floating = true, border_width = 0 } },  
    { rule = { instance = "plugin-container" },
     properties = { onfocus = true, floating = true, border_width = 0, ontop = true, fullscreen = true} },
    { rule = { class = "Sopcast-player.py" },
      properties = { floating = true, border_width = 0 },  
      callback = function (c)
      awful.placement.centered(c,nil)
     end
  },
    { rule = { class = "Blueman-manager" },
      properties = { floating = true } },
     { rule = { class = "File-roller" },
      properties = { floating = true } },
     { rule = { class = "Catfish" },
      properties = { floating = true } },
    { rule = { class = "Gnome-mplayer" }, 
      properties = { floating = true } },
     { rule = { class = "smplayer" },
      properties = { floating = true } },
     { rule = { class = "mpv" },
			properties = { floating = true },
			callback = function (c)
         awful.placement.centered(c,nil)
       end},
    { rule = { class = "Tor Browser" },
      properties = { floating = true, border_width = 0 } },
    
    -- { rule = { class = "Xfce4-terminal" },
     -- properties = { size_hints_honor = true } },
    
     { rule = { class = "Vlc" },
     --properties = { screen = 1,  tag = "ƈ" }
     properties = { floating = true },
			callback = function (c)
         awful.placement.centered(c,nil)
       end},
     { rule = { class = "vlc" },
     --properties = { screen = 1,  tag = "ƈ" }
     properties = { floating = true },
			callback = function (c)
         awful.placement.centered(c,nil)
       end},
   { rule = { class = "Gsopcast" },
     --properties = { screen = 1,  tag = "ƈ" }
     properties = { floating = true },
			callback = function (c)
         awful.placement.centered(c,nil)
       end},
   { rule = { class = "cantata" },
     --properties = { screen = 1,  tag = "ƈ" }
     properties = { floating = true },
			callback = function (c)
         awful.placement.centered(c,nil)
       end},
   { rule = { class = "SimpleScreenRecorder" },
     --properties = { screen = 1,  tag = "ƈ" }
     properties = { floating = true },
			callback = function (c)
         awful.placement.centered(c,nil)
       end},
   { rule = { class = "Deadbeef" },
      properties = { floating = true, border_width = 0 } },
      { rule = { class = "Dialog" },
      properties = { floating = true } },
    { rule = { class = "Gtk-recordMyDesktop" },
      properties = { floating = true, border_width = 0 } },
    { rule = { class = "Grun" },
      properties = { floating = true } },
    { rule = { class = "Xmessage" },
      properties = { floating = true, } },
     --{ rule = { class = "XVkbd" },
     -- properties = { floating = true, ontop = true } },
    { rule = { class = "Xwinmosaic" },
      properties = { floating = true },
     properties = { floating = true },  
      callback = function (c)
      awful.placement.centered(c,nil)
     end
  },
    { rule = { class = "Gxmessage" },
      properties = { floating = true, ontop = true } },    
      { rule = { class = "Florence" },
      properties = { floating = true, focus = false, offfocus = true, onfocus = false, ontop = true, top = false, border_width = 0 } }, 
    { rule = { class = "Xfce4-appfinder" },
      properties = { floating = true } }, 
    { rule = { class = "pinentry" },
      properties = { floating = true } }, 
    { rule = { class = "xine" },
      properties = { floating = true } },
    { rule = { class = "Onboard" },
      properties = { floating = true } },
     {rule = {class = "Skype"},
      properties = {floating = true} },

     { rule = { class = "Pavucontrol" },
      properties = { floating = true } },
     { rule = { class = "Galculator" },
      properties = { floating = true } },
    { rule = { class = "Gis-weather.py" },
      properties = {  floating = true, border_width = 0 } },

    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    --size_hints_honor=false
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end 
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
awful.util.spawn_with_shell("run_once kbdd")
--awful.util.spawn_with_shell("run_once kbdd && killall -9 kbdd && kbdd")
--awful.util.spawn_with_shell("xset s off && xset -dpms &")
--awful.util.spawn_with_shell("run_once google-chrome-stable")
--awful.util.spawn_with_shell("run_once /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.util.spawn_with_shell("run_once sleep 3 && /usr/bin/nm-applet --sm-disable")
--awful.util.spawn_with_shell("run_once /usr/bin/touchpad11")
--awful.util.spawn_with_shell("setxkbmap -layout 'us, ru' -option 'grp:caps_toggle'")
--awful.util.spawn_with_shell("run_once start-pulseaudio-x11")
--awful.util.spawn_with_shell("run_once /usr/bin/synclient TouchpadOff=1")
--awful.util.spawn_with_shell (awful.tag.incncol( 4, nil, true))
awful.util.spawn_with_shell("run_once gis-weather")
--awful.util.spawn_with_shell("run_once nm-applet")
awful.util.spawn_with_shell("setxkbmap")