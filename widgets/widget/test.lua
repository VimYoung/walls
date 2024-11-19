local lgi = require("lgi")
local Gtk = lgi.Gtk

-- Initialize GTK
Gtk.init()

-- Create a new window
local window = Gtk.Window({
	title = "GTK Menu Example",
	default_width = 300,
	default_height = 200,
	on_destroy = Gtk.main_quit,
})

-- Create a box to hold the button
local box = Gtk.Box({ orientation = "VERTICAL", spacing = 6 })
window:add(box)

-- Create a button
local button = Gtk.Button({ label = "Open Menu" })
box:pack_start(button, true, true, 0)

-- Create a menu
local menu = Gtk.Menu()

-- Create menu items
local menu_item1 = Gtk.MenuItem({ label = "Item 1" })
local menu_item2 = Gtk.MenuItem({ label = "Item 2" })
local menu_item3 = Gtk.MenuItem({ label = "Item 3" })

-- Add menu items to the menu
menu:append(menu_item1)
menu:append(menu_item2)
menu:append(menu_item3)

-- Show all menu items
menu:show_all()

-- Connect button click event to show the menu
button.on_clicked = function()
	menu:popup(nil, nil, nil, button, 0, Gtk.get_current_event_time())
end

-- Show the window
window:show_all()

-- Start the GTK main loop
Gtk.main()
