-------------------------------------------------
-- mpd Arc Widget for Awesome Window Manager
-- Modelled after Pavel Makhov's work

-- @author Raphaël Fournier-S'niehotta
-- @copyright 2018 Raphaël Fournier-S'niehotta
-------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")

local GET_MPD_CMD = "mpc status"
local PAUSE_MPD_CMD = "mpc pause"
local STOP_MPD_CMD = "mpc stop"
local NEXT_MPD_CMD = "mpc next"
local PREV_MPD_CMD = "mpc prev"

local PATH_TO_ICONS = "/home/valera/.config/awesome/icons/mpd"
local PAUSE_ICON_NAME = "/home/valera/.config/awesome/icons/mpd/mpd_pause.png"
local PLAY_ICON_NAME = "/home/valera/.config/awesome/icons/mpd/mpd_play.png"
local STOP_ICON_NAME = "/home/valera/.config/awesome/icons/mpd/mpd_stop.png"

local icon = wibox.widget { 
        id = "icon",
        widget = wibox.widget.imagebox,
        image = PLAY_ICON_NAME
    }
local mirrored_icon = wibox.container.mirror(icon, { horizontal = true })

local mpdarc = wibox.widget {
    mirrored_icon,
    max_value = 1,
    value = 0.75,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
   forced_height = 16,
    forced_width = 16,
    rounded_edge = true,
    bg = "#000000",
    paddings = 0,
    widget = wibox.container.arcchart
}

local mpdarc_widget = wibox.container.mirror(mpdarc, { horizontal = true })

local update_graphic = function(widget, stdout, _, _, _)
    stdout = string.gsub(stdout, "\n", "")
    local mpdpercent = string.match(stdout, "(%d%d)%%")
    local mpdstatus = string.match(stdout, "%[(%a+)%]")
    if mpdstatus == "playing" then 
      icon.image = PLAY_ICON_NAME
      widget.colors = { "#fb1c11" }
      widget.value = tonumber((100-mpdpercent)/100)
    elseif mpdstatus == "paused" then 
      icon.image = PAUSE_ICON_NAME
      widget.colors = { "#a95817" }
      widget.value = tonumber(mpdpercent/100)
    else
      icon.image = STOP_ICON_NAME
      widget.colors = { "#ff0000" }
    end
end

mpdarc:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.spawn("mpc toggle", false)      -- left click
    elseif (button == 2) then awful.spawn(STOP_MPD_CMD, false)
    elseif (button == 3) then awful.spawn(PAUSE_MPD_CMD, false)
    elseif (button == 4) then awful.spawn(NEXT_MPD_CMD, false)  -- scroll up
    elseif (button == 5) then awful.spawn(PREV_MPD_CMD, false)  -- scroll down
    end

    spawn.easy_async(GET_MPD_CMD, function(stdout, stderr, exitreason, exitcode)
        update_graphic(mpdarc, stdout, stderr, exitreason, exitcode)
    end)
end)

local notification
function show_MPD_status()
    spawn.easy_async(GET_MPD_CMD,
        function(stdout, _, _, _)
            notification = naughty.notify {
                text = stdout,
                font = "Z003 14",
                title = "MPD",
               -- timeout = 5,
                --hover_timeout = 0.5,
                width = 270,
            }
        end)
end

mpdarc:connect_signal("mouse::enter", function() show_MPD_status() end)
mpdarc:connect_signal("mouse::leave", function() naughty.destroy(notification) end)

watch(GET_MPD_CMD, 1, update_graphic, mpdarc)

return mpdarc_widget
