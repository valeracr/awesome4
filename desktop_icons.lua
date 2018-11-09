--local wibox = require("wibox")
--local color = require("gears.color")
--local awful = require("awful")
--local lain       = require("lain")
require("mic")

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
--local calendar = lain.widget.calendar()
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
                                     command = "pcmanfm / && sleep 3 && xdotool key F3"
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
                                     command = "pcmanfm && sleep 3 && xdotool key F3"
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
                                     command = "pcmanfm trash:// && sleep 3 && xdotoll key F3"
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
desktop_wibox9:geometry({ x = 1310, y = 500, width = 32, height = 32 })
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
my_widget01 = awful.widget.launcher({ name = "PkgBrowser",
                                     image = "/home/valera/.config/awesome/appicons/blackarch1.png",
                                     command = "pkgbrowser"
                                     })
function my_widget01:fit(context, width, height) return width, height end
local desktop_wibox02 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox02:geometry({ x = 1306, y = 600, width = 32, height = 32 })
desktop_wibox02:set_widget(my_widget01)

local my_widget03 = wibox.widget.textbox()
my_widget03.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 15\"><b>PkgBrowser</b></span></span>"
function my_widget03:fit(context, width, height) return width, height end
local desktop_wibox04 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox04:geometry({ x = 1275, y = 640, width = 90, height = 18 })
desktop_wibox04:set_widget(my_widget03)
-----------

my_widget19a = awful.widget.launcher({ name = "coolreader",
                                     image = "/home/valera/.config/awesome/appicons/cr3.png",
                                     command = "cr3"
                                     })
function my_widget19a:fit(context, width, height) return width, height end
local desktop_wibox19a = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox19a:geometry({ x = 50, y = 590, width = 32, height = 32 })
desktop_wibox19a:set_widget(my_widget19a)
--
local my_widget10a = wibox.widget.textbox()
--my_widget10a.markup = "<span color=\"#f29466\">CoolReader</span>"
my_widget10a.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 14\"><b>CoolReader</b></span></span>"
function my_widget10a:fit(context, width, height) return width, height end
local desktop_wibox10a = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox10a:geometry({ x = 26, y = 630, width = 79, height = 18 })
desktop_wibox10a:set_widget(my_widget10a)
---------------

my_widget9aa = awful.widget.launcher({ name = "firefox",
                                     --image = "/home/valera/.config/awesome/appicons/12.png",
                                     image = "/home/valera/.config/awesome/appicons/firefox.png",
                                     command = "firefox"
                                     })
function my_widget9aa:fit(context, width, height) return width, height end
local desktop_wibox9aa = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox9aa:geometry({ x = 150, y = 590, width = 32, height = 32 })
desktop_wibox9aa:set_widget(my_widget9aa)
--
local my_widget10aa = wibox.widget.textbox()
--my_widget10aa.markup = "<span color=\"#f29466\">CoolReader</span>"
my_widget10aa.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 14\"><b>Firefox</b></span></span>"
function my_widget10aa:fit(context, width, height) return width, height end
local desktop_wibox10aa = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox10aa:geometry({ x = 141, y = 630, width = 70, height = 18 })
desktop_wibox10aa:set_widget(my_widget10aa)
----------------

my_widget9b = awful.widget.launcher({ name = "cantata",
                                     --image = "/home/valera/.config/awesome/appicons/speaker.png",
                                     image = "/home/valera/.config/awesome/appicons/armagetronad.png",
                                     command = "cantata"
                                     })
function my_widget9b:fit(context, width, height) return width, height end
local desktop_wibox9b = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox9b:geometry({ x = 250, y = 593, width = 32, height = 32 })
desktop_wibox9b:set_widget(my_widget9b)
--
local my_widget10b = wibox.widget.textbox()
--my_widget10aa.markup = "<span color=\"#f29466\">Cantata</span>"
my_widget10b.markup = "<span color=\"#e74f12\"><span font=\"odstemplik 14\"><b>Cantata</b></span></span>"
function my_widget10b:fit(context, width, height) return width, height end
local desktop_wibox10b = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox10b:geometry({ x = 238, y = 630, width = 70, height = 18 })
desktop_wibox10b:set_widget(my_widget10b)

-----------
cpu1a = wibox.widget.imagebox()
cpu1a.image = "/home/valera/.config/awesome/appicons/cp1.png"
function cpu1a:fit(context, width, height) return width, height end
local cpu1aa = wibox({ type = "desktop", visible = true, bg = "#00000000" })
cpu1aa:geometry({ x = 1040, y = 850, width = 50, height = 50 })
cpu1aa:set_widget(cpu1a)
---------------
---------------
cpu_graph = blingbling.line_graph({ height = 50,
                                        width = 400,
                                        show_text = true,
                                        label = "cpu:$percent %",
                                        rounded_size = 0.3,
                                        graph_background_color = "#f4080815",
                                        text_background_color = "#2a000080",
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
cpu_graph:set_font_size("18")
blingbling.popups.htop(cpu_graph, { terminal =  "xfce4-terminal" })
vicious.register(cpu_graph, vicious.widgets.cpu,'$1', 5)
--vicious.register(cpu_graph, vicious.widgets.fs, "${/ used_a}", 120 )
function cpu_graph:fit(context, width, height) return width, height end
local desktop_wibox11 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox11:geometry({ x = 1090, y = 850, width = 350, height = 50 })
desktop_wibox11:set_widget(cpu_graph)

------------
------------
mem1a = wibox.widget.imagebox()
mem1a.image = "/home/valera/.config/awesome/appicons/mem.png"
function mem1a:fit(context, width, height) return width, height end
local mem1aa = wibox({ type = "desktop", visible = true, bg = "#00000000" })
mem1aa:geometry({ x = 1040, y = 799, width = 50, height = 50 })
mem1aa:set_widget(mem1a)
----------
mem = blingbling.line_graph({ height = 50,
                                        width = 400,
                                        show_text = true,
                                        label = "mem:$percent %",
                                        rounded_size = 0.3,
                                        graph_background_color = "#f4080815",
                                        text_background_color = "#2a000080",
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
mem:set_font_size("18")
vicious.register(mem, vicious.widgets.mem,'$1', 5)
function mem:fit(context, width, height) return width, height end
local desktop_wibox12 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox12:geometry({ x = 1090, y = 799, width = 307, height = 50 })
desktop_wibox12:set_widget(mem)

---------------
--------------
net1a = wibox.widget.imagebox()
net1a.image = "/home/valera/.config/awesome/appicons/net.png"
function net1a:fit(context, width, height) return width, height end
local net1aa = wibox({ type = "desktop", visible = true, bg = "#00000000" })
net1aa:geometry({ x = 1043, y = 749, width = 36, height = 50 })
net1aa:set_widget(net1a)
----------------
netwidget = blingbling.net1({ interface = "enp3s0", show_text = true, timeout = 5, text_background_color = "#2a000080" })
netwidget:set_ippopup()
netwidget:set_graph_line_color("#e65117ff")
netwidget:set_background_color("#2a000000")
netwidget:set_graph_color("#f70101ff")
----netwidget:set_background_graph_color("#00ea00ff")
netwidget:set_text_color("#e65117")
netwidget:set_font("odstemplik Bold")
netwidget:set_font_size(18)
netwidget.height = 0.70

function netwidget:fit(context, width, height) return width, height end
local desktop_wibox12 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox12:geometry({ x = 1078, y = 749, width = 214, height = 50 })
desktop_wibox12:set_widget(netwidget)

-----------
-----------
--next_icon = awful.widget.launchers({ name = "desktop",
--                                     image = "/home/valera/.config/awesome/mpd/mpd_next.png",
--                                     command = "mpc next || ncmpcpp next"
--                                     })
--function next_icon:fit(context, width, height) return width, height end
--local desktop_wibox14 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
--desktop_wibox14:geometry({ x = 1335, y = 755, width = 32, height = 32 })
--desktop_wibox14:set_widget(next_icon)

-----------
--stop_icon = wibox.widget.imagebox()
--stop_icon.image = "/home/valera/.config/awesome/icons/mpd/mpd_play.png"
--stop_icon:buttons(awful.util.table.join(
--    awful.button({ }, 1, function () stop_icon:set_image("/home/valera/.config/awesome/icons/mpd/mpd_pause.png") awful.util.spawn_with_shell("mpd")  end),
--    awful.button({ }, 2, function () stop_icon:set_image("/home/valera/.config/awesome/icons/mpd/mpd_play.png") awful.util.spawn_with_shell("killall mpd") end)
--))
--function stop_icon:fit(context, width, height) return width, height end
--local desktop_wibox15 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
--desktop_wibox15:geometry({ x = 1293, y = 755, width = 32, height = 32 })
--desktop_wibox15:set_widget(stop_icon)
---------
---------

-----------
--prev_icon = awful.widget.launchers({ name = "desktop",
--                                     image = "/home/valera/.config/awesome/mpd/mpd_prev.png",
--                                     command = "mpc prev || ncmpcpp prev"
--                                     })
--function prev_icon:fit(context, width, height) return width, height end
--local desktop_wibox18 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
--desktop_wibox18:geometry({ x = 1241, y = 755, width = 32, height = 32 })
--desktop_wibox18:set_widget(prev_icon)

------------------

--------
fs1 = wibox.widget.imagebox()
fs1.image = "/home/valera/.config/awesome/appicons/hdd.png"
function fs1:fit(context, width, height) return width, height end
local fs11 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
fs11:geometry({ x = 1277, y = 749, width = 50, height = 50 })
fs11:set_widget(fs1)
---------------

home_fs_usage=blingbling.value_text_box({height = 50, width = 110, v_margin = 4 })
--home_fs_usage:set_height(16)
--home_fs_usage:set_width(40)
--home_fs_usage:set_v_margin(2)

--home_fs_usage:set_font_size("18")
home_fs_usage:set_text_background_color("#2a000000")
home_fs_usage:set_values_text_color({{"#f43b0aff",0}, --all value > 0 will be displayed using this color
                          {"#e65117ff", 0.75},
                          {"#e65117ff", 0.77}})
--There is no maximum number of color that users can set, just put the lower values at first. 
home_fs_usage:set_text_color("#e65117ff")
home_fs_usage:set_rounded_size(0.4)
home_fs_usage:set_background_color("#2a000010")
home_fs_usage:set_label(": $percent% :")
home_fs_usage:set_font("odstemplik")
home_fs_usage:set_font_size(26)

vicious.register(home_fs_usage, vicious.widgets.fs, "${/ used_p}", 120 )
home_fs_usage:buttons(awful.util.table.join(
    awful.button({ }, 1, function ()  awful.util.spawn_with_shell("pcmanfm")  end) ))

function home_fs_usage:fit(context, width, height) return width, height end
local desktop_wibox20 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox20:geometry({ x = 1320, y = 749, width = 70, height = 50 })
desktop_wibox20:set_widget(home_fs_usage)
----------
---------
cores_graph_conf ={height = 14, width = 50, graph_line_color = "#f43b0a", graph_color = "#ea1010ff", graph_background_color = "#6d0606ff", rounded_size = 0.8}
cores_graphs = {}
for i=1,4 do
  cores_graphs[i] = blingbling.progress_graph( cores_graph_conf)
  --vicious.register(cores_graphs[i], vicious.widgets.cpu, "$"..(i+1).."",1)
  vicious.register(cores_graphs[i], vicious.widgets.fs, "${/ used_p}", 120 )
end
for i=1,4 do
--function cores_graphs[i]:fit(context, width, height) return width, height end
local desktop_wibox41 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox41:geometry({ x = 1410, y = 749, width = 14, height = 50 })
desktop_wibox41:set_widget(cores_graphs[i])
end
----------
----------
--local desktop_wibox42 = wibox({ type = "desktop", visible = true, bg = "#2a000080" })
--desktop_wibox42:geometry({ x = 20, y = 60, width = 40, height = 50 })
--desktop_wibox42:set_widget(email_icon)

--local desktop_wibox43 = wibox({ type = "desktop", visible = true, bg = "#2a000080" })
--desktop_wibox43:geometry({ x = 59, y = 60, width = 50, height = 50 })
--desktop_wibox43:set_widget(email_widget)

my_widget51 = awful.widget.launchers({ name = "desktop",
                                     image = "/home/valera/.config/awesome/appicons/111.png",
                                     command = "xfce4-terminal -e 'aurman -Syyu'"
                                     })
function my_widget51:fit(context, width, height) return width, height end
local desktop_wibox52 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox52:geometry({ x = 83, y = 884, width = 32, height = 32 })
desktop_wibox52:set_widget(my_widget51)

-- Pacman Widget
pacwidget1 = wibox.widget.textbox()

pacwidget1_t = awful.tooltip({ objects = { pacwidget1},})

vicious.register(pacwidget1, vicious.widgets.pkg1,
                function(widget,args)
                    local io = { popen = io.popen }
                    --local s = io.popen("pacman -Qu -b /tmp/checkup-db-valera")
                    local s = io.popen("/usr/bin/checkupdates")
                    local str = ''
		    local i = 0

                    for line in s:lines() do
                        --str = str .. line .. "\n"
                         str = "<span color=\"#e65117\"><span font=\"Sony Sketch EF Bold 11\">" .. str .. " " .. line .. "</span></span>\n"
                        i = i + 1
		    end
                    pacwidget1_t:set_markup(str)
                    s:close()
                    return "<span color=\"#e6511750\"><b>"  .. i ..  "</b></span>"
                end, 1800, "Arch C")
pacwidget1:set_font("odstemplik Bold 56")

function pacwidget1:fit(context, width, height) return width, height end
local wibox50 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
wibox50:geometry({ x = 175, y = 830, width = 70, height = 60 })
wibox50:set_widget(pacwidget1)
-------------------------------
temp1 = wibox.widget.imagebox()
temp1.image = "/home/valera/.config/awesome/appicons/temp.png"
function temp1:fit(context, width, height) return width, height end
local temp11 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
temp11:geometry({ x = 1397, y = 799, width = 16, height = 50 })
temp11:set_widget(temp1)
