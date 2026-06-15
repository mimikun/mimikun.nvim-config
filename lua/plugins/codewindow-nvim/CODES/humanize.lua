local M = {}

local function left_pad(value, width)
  local padding = width - #value
  if padding <= 0 then
    return value
  end
  return string.rep(" ", padding) .. value
end

local units = {
  { value = 1000000000, suffix = "g" },
  { value = 1000000, suffix = "m" },
  { value = 1000, suffix = "k" },
}

local function get_unit(value)
  for _, unit in ipairs(units) do
    if value >= unit.value then
      return unit
    end
  end
  return nil
end

local function strip_decimal_zeros(value)
  value = value:gsub("0+$", "")
  value = value:gsub("%.$", "")
  return value
end

local function compact_line_number(value, precision)
  local unit = get_unit(value)
  if not unit then
    return tostring(value)
  end

  if precision == 0 then
    if value % unit.value ~= 0 then
      return nil
    end
    return tostring(math.floor(value / unit.value)) .. unit.suffix
  end

  local scaled = string.format("%." .. precision .. "f", value / unit.value)
  local label = strip_decimal_zeros(scaled) .. unit.suffix
  if value % unit.value ~= 0 and label == tostring(math.floor(value / unit.value)) .. unit.suffix then
    return nil
  end
  return label
end

local function labels_are_unique(labels)
  local seen = {}
  for _, label in ipairs(labels) do
    if seen[label] then
      return false
    end
    seen[label] = true
  end
  return true
end

local function labels_for_precision(values, precision)
  local labels = {}
  for i, value in ipairs(values) do
    local label = compact_line_number(value, precision)
    if label == nil then
      return nil
    end
    labels[i] = label
  end
  if labels_are_unique(labels) then
    return labels
  end
  return nil
end

local function raw_labels(values)
  local labels = {}
  for i, value in ipairs(values) do
    labels[i] = tostring(value)
  end
  return labels
end

local function padded_labels(labels, min_width)
  local width = min_width
  for _, label in ipairs(labels) do
    width = math.max(width, #label)
  end

  local padded = {}
  for i, label in ipairs(labels) do
    padded[i] = left_pad(label, width)
  end
  return padded, width
end

function M.line_number_labels(values, min_width)
  min_width = math.max(0, math.floor(tonumber(min_width) or 0))

  for precision = 0, 6 do
    local labels = labels_for_precision(values, precision)
    if labels then
      return padded_labels(labels, min_width)
    end
  end

  return padded_labels(raw_labels(values), min_width)
end

return M
