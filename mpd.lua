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
local spawn = require("awful.spawn")
mpdarc = require("mpdarc")
-------------------------------------
-------------------------------------
-- MPD


stop_icon = wibox.widget.imagebox()
stop_icon.image = "/home/valera/.config/awesome/icons/mpd/mpd_play.png"
pause_icon = wibox.widget.imagebox()
pause_icon.image = "/home/valera/.config/awesome/icons/mpd/mpd_pause.png"
play_pause_icon = wibox.widget.imagebox()
play_pause_icon.image = "/home/valera/.config/awesome/icons/mpd/mpd_stop.png"
mpd_sepr = wibox.widget.imagebox()
mpd_sepr.image = "/home/valera/.config/awesome/icons/mpd/mpd_sepr.png"
sep = wibox.widget.imagebox()
sep.image = "/home/valera/.config/awesome/icons/mpd/sep.png"
function sep:fit(context, width, height) return width, height end
sep1 = wibox.widget.imagebox()
sep1.image = "/home/valera/.config/awesome/icons/mpd/333.png"
function sep:fit(context, width, height) return width, height end
sep2 = wibox.widget.imagebox()
sep2.image = "/home/valera/.config/awesome/icons/mpd/334.png"
function sep:fit(context, width, height) return width, height end

mpdwidget = lain.widget.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_notification_preset.font = "Z003 17"
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            --widget:set_markup(markup.font("odstemplik Bold 18", " ")
              --                .. markup.font("odstemplik Bold 18",
              --                mpd_now.artist
              --                .. " - " ..
              --                mpd_now.title
              --                .. markup.font("odstemplik Bold 18", " ")))
            play_pause_icon = wibox.widget.imagebox(beautiful.mpd_pause)
            mpd_sepl = wibox.widget.imagebox(beautiful.mpd_sepl)
            mpd_sepr = wibox.widget.imagebox(beautiful.mpd_sepr)
        elseif mpd_now.state == "pause" then
            --widget:set_markup(markup.font("odstemplik Bold 18", "") ..
            --                  markup.font("odstemplik Bold 18", "MPD PAUSED") ..
            --                  markup.font("odstemplik Bold 18", ""))
            play_pause_icon = wibox.widget.imagebox(beautiful.mpd_play)
            mpd_sepl = wibox.widget.imagebox(beautiful.mpd_sepl)
            mpd_sepr = wibox.widget.imagebox(beautiful.mpd_sepr)
        else
            widget:set_markup("")
            play_pause_icon = wibox.widget.imagebox(beautiful.mpd_play)
            mpd_sepl = wibox.widget.imagebox(nil)
            mpd_sepr = wibox.widget.imagebox(nil)
        end
    end
})

music_widget = wibox.container.background(mpdwidget.widget)
music_widget.bgimage=beautiful.widget_display
music_widget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(ncmpcpp) end)))
-------

local desktop_wibox30 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox30:geometry({ x = 606, y = 700, width = 10, height = 32 })
desktop_wibox30:set_widget(sep1)

prev_icon = awful.widget.launchers({ name = "prev",
                                     image = "/home/valera/.config/awesome/icons/mpd/mpd_prev.png",
                                     command = "mpc prev || ncmpcpp prev"})
local desktop_wibox18 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox18:geometry({ x = 617, y = 700, width = 32, height = 32 })
desktop_wibox18:set_widget(prev_icon)

local desktop_wibox30a = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox30a:geometry({ x = 650, y = 700, width = 10, height = 32 })
desktop_wibox30a:set_widget(sep)


function mpdarc:fit(context, width, height) return width, height end
--mpdarc = wibox.container.mirror(midget, { horizontal = true })
local desktop_wibox81 = wibox({ type = "desktop", visible = true, bg = "#2a0000" })
desktop_wibox81:geometry({ x = 661, y = 700, width = 32, height = 32 })
desktop_wibox81:set_widget(mpdarc)

local desktop_wibox31 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox31:geometry({ x = 694, y = 700, width = 10, height = 32 })
desktop_wibox31:set_widget(sep)

stop_icon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () stop_icon:set_image("/home/valera/.config/awesome/icons/mpd/mpd_pause.png") mpicon:set_image("/home/valera/.config/awesome/icons/14a.png") mpicon1:set_image("/home/valera/.config/awesome/icons/15a.png") mpicon3:set_image("/home/valera/.config/awesome/icons/16a.png") awful.util.spawn_with_shell("mpd") mpdwidget.update()  end),
    awful.button({ }, 2, function () stop_icon:set_image("/home/valera/.config/awesome/icons/mpd/mpd_play.png") mpicon:set_image("/home/valera/.config/awesome/icons/14.png") mpicon1:set_image("/home/valera/.config/awesome/icons/15.png") mpicon3:set_image("/home/valera/.config/awesome/icons/16.png") awful.util.spawn_with_shell("killall mpd") mpdwidget.update() end)
))
--function stop_icon:fit(context, width, height) return width, height end
local desktop_wibox15 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox15:geometry({ x = 705, y = 700, width = 32, height = 32 })
desktop_wibox15:set_widget(stop_icon)

local desktop_wibox32 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox32:geometry({ x = 738, y = 700, width = 10, height = 32 })
desktop_wibox32:set_widget(sep)

next_icon = awful.widget.launchers({ name = "next",
                                     image = "/home/valera/.config/awesome/icons/mpd/mpd_next.png",
                                     command = "mpc next || ncmpcpp next"})
local desktop_wibox14 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox14:geometry({ x = 749, y = 700, width = 32, height = 32 })
desktop_wibox14:set_widget(next_icon)

local desktop_wibox33 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox33:geometry({ x = 782, y = 700, width = 10, height = 32 })
desktop_wibox33:set_widget(sep)

------------------
volume_master = blingbling.volume({height = 32, width = 60, bar =true, show_text = true, label ="♪:$percent%", text_background_color = "#2a000050", pulseaudio = false})
volume_master:update_master()
volume_master:set_master_control()
volume_master:set_graph_line_color("#e6511790")
volume_master:set_background_color("#2a0000ff")
volume_master:set_graph_color("#f70101ff")
volume_master:set_text_color("#f6400eff")
volume_master:set_font("odstemplik Bold")
volume_master:set_font_size(18)
function volume_master:fit(context, width, height) return width, height end
local desktop_wibox19 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox19:geometry({ x = 784, y = 700, width = 58, height = 32 })
desktop_wibox19:set_widget(volume_master)
--------

local desktop_wibox34 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox34:geometry({ x = 843, y = 700, width = 10, height = 32 })
desktop_wibox34:set_widget(sep2)
----------------------
--------------
mpicon1 = wibox.widget.imagebox()
mpicon1.image = "/home/valera/.config/awesome/icons/15.png"

local desktop_wibox34a = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox34a:geometry({ x = 610, y = 666, width = 46, height = 31 })
desktop_wibox34a:set_widget(mpicon1)

mpicon = wibox.widget.imagebox()
mpicon.image = "/home/valera/.config/awesome/icons/14.png"

local desktop_wibox34 = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox34:geometry({ x = 657, y = 660, width = 150, height = 40 })
desktop_wibox34:set_widget(mpicon)

mpicon3 = wibox.widget.imagebox()
mpicon3.image = "/home/valera/.config/awesome/icons/16.png"

local desktop_wibox34c = wibox({ type = "desktop", visible = true, bg = "#00000000" })
desktop_wibox34c:geometry({ x = 803,  y = 666, width = 46, height = 31 })
desktop_wibox34c:set_widget(mpicon3)
