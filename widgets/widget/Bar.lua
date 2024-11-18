local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Battery = astal.require("AstalBattery")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local App = require("astal.gtk3.app")
local Variable = astal.Variable
local Gdk = astal.require("Gdk", "3.0")
local GLib = astal.require("GLib")
local bind = astal.bind
-- local Mpris = astal.require("AstalMpris")
-- local Wp = astal.require("AstalWp")
-- local Network = astal.require("AstalNetwork")
local Tray = astal.require("AstalTray")
-- local Hyprland = astal.require("AstalHyprland")
local map = require("lib").map

local function BatteryLevel()
	local bat = Battery.get_default()
	return Widget.Box({
		Widget.Label({
			label = bind(bat, "percentage"):as(function(p)
				return tostring(math.floor(p * 100)) .. " %"
			end),
		}),
	})
end

local function ButtonDropdown()
	return Widget.Button({
		label = "Click for dropdown",
		child = function()
			return Widget.Window({
				anchor = Anchor.TOP,
				Widget.Box({
					Widget.Label({
						label = "Hyprland",
					}),
				}),
			})
		end,
	})
end

local function SyshelloTray()
	local tray = Tray.get_default()

	return Widget.Box({
		bind(tray, "items"):as(function(items)
			return map(items, function(item)
				if item.icon_theme_path ~= nil then
					App:add_icons(item.icon_theme_path)
				end

				local menu = item:create_menu()

				return Widget.Button({
					tooltip_markup = bind(item, "tooltip_markup"),
					on_destroy = function()
						if menu ~= nil then
							menu:destroy()
						end
					end,
					on_click_release = function(self)
						if menu ~= nil then
							menu:popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, nil)
						end
					end,
					Widget.Icon({
						g_icon = bind(item, "gicon"),
					}),
				})
			end)
		end),
	})
end

local function SysTray()
	local tray = Tray.get_default()

	return Widget.Box({
		bind(tray, "items"):as(function(items)
			return map(items, function(item)
				if item.icon_theme_path ~= nil then
					App:add_icons(item.icon_theme_path)
				end

				local menu = item:create_menu()

				return Widget.Button({
					tooltip_markup = bind(item, "tooltip_markup"),
					on_destroy = function()
						if menu ~= nil then
							menu:destroy()
						end
					end,
					on_click_release = function(self)
						if menu ~= nil then
							menu:popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, nil)
						end
					end,
					Widget.Icon({
						g_icon = bind(item, "gicon"),
					}),
				})
			end)
		end),
	})
end

-- -- Get the button's position
-- local x, y = ButtonDropdown().get_position()
-- local height = ButtonDropdown():get_height()
-- print(x)
-- print(y)
-- print(height)
-- Position the new window just below the button
-- return function(monitor)
-- 	local WindowAnchor = astal.require("Astal", "3.0").WindowAnchor
-- 	return Widget.Window({
-- 		class_name = "Bar",
-- 		gdkmonitor = monitor,
-- 		anchor = WindowAnchor.TOP + WindowAnchor.LEFT + WindowAnchor.RIGHT,
-- 		exclusivity = "EXCLUSIVE",
-- 		Widget.CenterBox({
-- 			Widget.Box({
-- 				BatteryLevel(),
-- 				ButtonDropdown(),
-- 				SysTray(),
-- 			}),
-- 		}),
-- 	})
-- end

return function(gdkmonitor)
	local WindowAnchor = astal.require("Astal", "3.0").WindowAnchor

	return Widget.Window({
		class_name = "Bar",
		gdkmonitor = gdkmonitor,
		anchor = WindowAnchor.TOP + WindowAnchor.LEFT + WindowAnchor.RIGHT,
		exclusivity = "EXCLUSIVE",

		Widget.CenterBox({
			Widget.Box({
				halign = "START",
				SyshelloTray(),
				-- Workspaces(),
				-- FocusedClient(),
			}),
			Widget.Box({
				-- Media(),
			}),
			Widget.Box({
				halign = "END",
				-- Wifi(),
				-- AudioSlider(),
				BatteryLevel(),
				SysTray(),
				-- Time("%H:%M - %A %e."),
			}),
		}),
	})
end
