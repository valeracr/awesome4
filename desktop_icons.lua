--local wibox = require("wibox")
--local color = require("gears.color")
--local awful = require("awful")
--local lain       = require("lain")
-------
----------
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
blingbling.superproperties.init('the_theme_path')
mygraph = blingbling.line_graph()
--------
-------

my_widget = awful.widget.launcher({ name = "firefox",
                                     image = "/home/valera/.config/awesome/appicons/browser.png",
                                     command = "/home/valera/tor/Browser/start-tor-browser --detach"
                                     })
function my_widget:fit(context, width, height) return width, height end

local desktop_wibox = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox:geometry({ x = 1300, y = 100, width = 32, height = 32 })

desktop_wibox:set_widget(my_widget)

------------------
------------------
local my_widget1 = wibox.widget.textbox()
--my_widget1.text = " Firefox "
my_widget1.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 15\"><b>TorBrowser</b></span></span>"
function my_widget1:fit(context, width, height) return width, height end
local desktop_wibox1 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox1:geometry({ x = 1277, y = 140, width = 90, height = 18 })
desktop_wibox1:set_widget(my_widget1)
-------------------
-------------------------
my_widget3 = awful.widget.launchers({ name = "desktop",
                                     image = "/home/valera/.config/awesome/appicons/desktop.png",
                                     command = "thunar /"
                                     })
function my_widget3:fit(context, width, height) return width, height end
local desktop_wibox3 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox3:geometry({ x = 1300, y = 200, width = 32, height = 32 })
desktop_wibox3:set_widget(my_widget3)
--
local my_widget4 = wibox.widget.textbox()
my_widget4.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 15\"><b>File System</b></span></span>"
function my_widget4:fit(context, width, height) return width, height end
local desktop_wibox4 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox4:geometry({ x = 1278, y = 240, width = 90, height = 22 })
desktop_wibox4:set_widget(my_widget4)

-----------
-----------
my_widget5 = awful.widget.launchers({ name = "desktop",
                                     image = "/home/valera/.config/awesome/appicons/gnome-fs-desktop.png",
                                     command = "thunar"
                                     })
function my_widget5:fit(context, width, height) return width, height end
local desktop_wibox5 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox5:geometry({ x = 1300, y = 300, width = 32, height = 32 })
desktop_wibox5:set_widget(my_widget5)
--
local my_widget6 = wibox.widget.textbox()
my_widget6.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 15\"><b>Home</b></span></span>"
function my_widget6:fit(context, width, height) return width, height end
local desktop_wibox6 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox6:geometry({ x = 1296, y = 340, width = 50, height = 18 })
desktop_wibox6:set_widget(my_widget6)


-------------
-------------
my_widget7 = awful.widget.launchers({ name = "trash",
                                     image = "/home/valera/.config/awesome/appicons/user-trash.png",
                                     command = "thunar trash://"
                                     })
function my_widget7:fit(context, width, height) return width, height end
local desktop_wibox7 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox7:geometry({ x = 1300, y = 400, width = 32, height = 32 })
desktop_wibox7:set_widget(my_widget7)
--
local my_widget8 = wibox.widget.textbox()
my_widget8.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 15\"><b>Trash</b></span></span>"
function my_widget8:fit(context, width, height) return width, height end
local desktop_wibox8 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox8:geometry({ x = 1298, y = 440, width = 50, height = 18 })
desktop_wibox8:set_widget(my_widget8)


-------------
-------------
my_widget9 = awful.widget.launcher({ name = "acestream",
                                     --image = "/home/valera/.config/awesome/appicons/12.png",
                                     image = "/usr/share/icons/Black Diamond-V2/scalable/12.png",
                                     command = "acestreamplayer"
                                     })
function my_widget9:fit(context, width, height) return width, height end
local desktop_wibox9 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox9:geometry({ x = 1300, y = 500, width = 32, height = 32 })
desktop_wibox9:set_widget(my_widget9)
--
local my_widget10 = wibox.widget.textbox()
--my_widget10.markup = "<span color=\"#f29466\">Acestream</span>"
my_widget10.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 14\"><b>Acestream</b></span></span>"
function my_widget10:fit(context, width, height) return width, height end
local desktop_wibox10 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox10:geometry({ x = 1286, y = 540, width = 70, height = 18 })
desktop_wibox10:set_widget(my_widget10)

------------
------------
cpu_graph = blingbling.line_graph({ height = 50,
                                        width = 400,
                                        show_text = true,
                                        label = "cpu:$percent %",
                                        rounded_size = 0.3,
                                        graph_background_color = "#f4080815",
                                        --graph_text_color = "#f29466"                                        
                                      })
--cpu_graph:set_height(18)
--cpu_graph:set_width(200)
--cpu_graph:set_show_text(true)
--cpu_graph:set_label("Load: $percent %")
--cpu_graph:set_rounded_size(0.3)
--cpu_graph:set_graph_background_color("#00000033")
cpu_graph:set_graph_line_color("#e65117ff")
cpu_graph:set_graph_color("#f70101ff")
cpu_graph:set_text_color("#e74f12")
cpu_graph:set_font("odstemplik bold")
cpu_graph:set_font_size("22")
vicious.register(cpu_graph, vicious.widgets.cpu,'$1',2)
function cpu_graph:fit(context, width, height) return width, height end
local desktop_wibox11 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox11:geometry({ x = 1040, y = 850, width = 400, height = 50 })
desktop_wibox11:set_widget(cpu_graph)

------------
------------
mem = blingbling.line_graph({ height = 50,
                                        width = 400,
                                        show_text = true,
                                        label = "mem:$percent %",
                                        rounded_size = 0.3,
                                        graph_background_color = "#f4080815",
                                        --graph_text_color = "#f29466"                                        
                                      })
--cpu_graph:set_height(18)
--cpu_graph:set_width(200)
--cpu_graph:set_show_text(true)
--cpu_graph:set_label("Load: $percent %")
--cpu_graph:set_rounded_size(0.3)
--cpu_graph:set_graph_background_color("#00000033")
mem:set_graph_line_color("#e65117ff")
mem:set_graph_color("#f70101ff")
mem:set_text_color("#e74f12")
mem:set_font("odstemplik bold")
mem:set_font_size("22")
vicious.register(mem, vicious.widgets.mem,'$1',2)
function mem:fit(context, width, height) return width, height end
local desktop_wibox12 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox12:geometry({ x = 1040, y = 799, width = 400, height = 50 })
desktop_wibox12:set_widget(mem)

---------------
--------------
netwidget = blingbling.net1({ interface = "enp3s0", show_text = true })
netwidget:set_ippopup()
netwidget:set_graph_line_color("#e65117ff")
----netwidget:set_background_color("#f7010150")
netwidget:set_graph_color("#f70101ff")
----netwidget:set_background_graph_color("#00ea00ff")
netwidget:set_text_color("#e65117")
netwidget:set_font("odstemplik Bold")
netwidget:set_font_size(22)
netwidget.height = 0.70

function netwidget:fit(context, width, height) return width, height end
local desktop_wibox12 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox12:geometry({ x = 1040, y = 749, width = 200, height = 50 })
desktop_wibox12:set_widget(netwidget)

-----------
-----------
my_widget14 = awful.widget.launchers({ name = "desktop",
                                     image = "/home/valera/.config/awesome/mpd/mpd_next.png",
                                     command = "mpc next"
                                     })
function my_widget14:fit(context, width, height) return width, height end
local desktop_wibox14 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox14:geometry({ x = 1385, y = 755, width = 32, height = 32 })
desktop_wibox14:set_widget(my_widget14)

-----------
stop_icon1 = wibox.widget.imagebox()
stop_icon1.image = "/home/valera/.config/awesome/mpd/mpd_play.png"
stop_icon1:buttons(awful.util.table.join(
    awful.button({ }, 1, function () stop_icon1:set_image("/home/valera/.config/awesome/mpd/mpd_pause.png") awful.util.spawn_with_shell("mpd")  end),
    awful.button({ }, 2, function () stop_icon1:set_image("/home/valera/.config/awesome/mpd/mpd_play.png") awful.util.spawn_with_shell("killall mpd") end)
))
function stop_icon1:fit(context, width, height) return width, height end
local desktop_wibox15 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox15:geometry({ x = 1343, y = 755, width = 32, height = 32 })
desktop_wibox15:set_widget(stop_icon1)
---------
---------

-----------
my_widget18 = awful.widget.launchers({ name = "desktop",
                                     image = "/home/valera/.config/awesome/mpd/mpd_prev.png",
                                     command = "mpc next"
                                     })
function my_widget18:fit(context, width, height) return width, height end
local desktop_wibox18 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox18:geometry({ x = 1301, y = 755, width = 32, height = 32 })
desktop_wibox18:set_widget(my_widget18)













