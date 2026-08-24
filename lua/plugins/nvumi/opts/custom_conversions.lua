---@type table
local custom_conversions = {
  -- Speed Units
  {
    id = "kmh",
    phrases = "kmh, kmph, khm, kph, klicks, kilometers per hour",
    base_unit = "speed",
    format = "km/h",
    -- base ratio
    ratio = 1,
  },
  {
    id = "mph",
    phrases = "mph, miles per hour",
    base_unit = "speed",
    format = "mph",
    -- 1 mph equals 1.609344 km/h
    ratio = 1.609344,
  },
  {
    id = "meterspersecond",
    phrases = "mps, meters per second",
    base_unit = "speed",
    format = "m/s",
    -- 1 km/h ≈ 0.27778 m/s
    ratio = 0.27778,
  },
  {
    id = "knots",
    phrases = "kts, knots",
    base_unit = "speed",
    format = "kt",
    -- 1 knot = 1.852 km/h
    ratio = 1.852,
  },

  -- Volume Units
  {
    id = "liters",
    phrases = "l, liter, liters",
    base_unit = "volume",
    format = "L",
    ratio = 1,
  },
  {
    id = "gallons",
    phrases = "gal, gallon, gallons",
    base_unit = "volume",
    format = "gal",
    -- 1 gallon = 3.78541 liters
    ratio = 3.78541,
  },

  -- Electrical Units
  {
    id = "watt",
    phrases = "watt, W",
    format = "W",
    ratio = 1,
  },
  {
    id = "kilowatt",
    phrases = "kilowatt, kW",
    base_unit = "watt",
    format = "kW",
    ratio = 1000,
  },
  {
    id = "megawatt",
    phrases = "megawatt, MW",
    base_unit = "watt",
    format = "MW",
    ratio = 1000000,
  },
}

return custom_conversions
