local Battery = require("lgi").require("AstalBattery")

local battery = Battery.get_default()

print(battery.percentage)
