# Nvumi Recipes

Below are a few examples of custom conversions/mathematical functions to get you started with your config. These hopefully illustrate the kinds of things you could expand nvumi with and hopefully serve as inspiration.

Some of these have been inspired by the original numi community plugins section on their GitHub so its worth linking/crediting that [here](https://github.com/nikolaeu/numi/tree/master/plugins)!

## Custom Conversions

Custom conversions allow you to define unit conversions beyond those provided by `numi-cli`. You can specify conversion factors and alias phrases for natural language inputs.

### **Speed Units**
```lua
custom_conversions = {
  {
    id = "kmh",
    phrases = "kmh, kmph, khm, kph, klicks, kilometers per hour",
    base_unit = "speed",
    format = "km/h",
    ratio = 1, -- base ratio
  },
  {
    id = "mph",
    phrases = "mph, miles per hour",
    base_unit = "speed",
    format = "mph",
    ratio = 1.609344, -- 1 mph equals 1.609344 km/h
  },
  {
    id = "meterspersecond",
    phrases = "mps, meters per second",
    base_unit = "speed",
    format = "m/s",
    ratio = 0.27778, -- 1 km/h ≈ 0.27778 m/s
  },
  {
    id = "knots",
    phrases = "kts, knots",
    base_unit = "speed",
    format = "kt",
    ratio = 1.852, -- 1 knot = 1.852 km/h
  },
}
```

### **Volume Units**
```lua
custom_conversions = {
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
    ratio = 3.78541, -- 1 gallon = 3.78541 liters
  },
}
```

### **Electrical Units**
```lua
custom_conversions = {
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
```

## Custom Functions

Custom functions extend the capabilities of nvumi, allowing for user-defined calculations and operations.

- Accept **numbers, strings, or no arguments**
- Return results using **`{ result = ... }`** 
- Surface **error messages** with **`{ error = ... }`**

---

## **Factorial**
Calculates the factorial of a number (e.g., `5! = 5 × 4 × 3 × 2 × 1 = 120`).

```lua
custom_functions = {
  {
    def = { phrases = "factorial, fact" },
    fn = function(args)
      if #args < 1 or type(args[1]) ~= "number" then
        return { error = "factorial requires a single numeric argument" }
      end
      local n = math.floor(args[1])
      if n < 0 then return { error = "factorial undefined for negative numbers" } end
      if n > 100 then return math.huge end
      
      local function factorial(num)
        if num <= 1 then return 1 end
        return num * factorial(num - 1)
      end

      return { result = factorial(n) }
    end,
  },
}
```

Usage:
```
factorial(5) → 120
factorial(-2) → Error: factorial is undefined for negative numbers
factorial(200) → inf
```


## **Logarithm (Base 2 & Custom Base)**
Computes the logarithm of a number with a default base of **2**, or a custom base.

```lua
custom_functions = {
  {
    def = { phrases = "log" },
    fn = function(args)
      if #args < 1 or type(args[1]) ~= "number" then
        return { error = "log requires at least one numeric argument" }
      end
      local base = args[2] and args[2] or 2
      if base <= 0 or args[1] <= 0 then
        return { error = "logarithm is undefined for non-positive numbers" }
      end
      
      return { result = math.log(args[1]) / math.log(base) }
    end,
  },
}
```

Usage:
```
log(8) → 3  (log₂(8) = 3)
log(100, 10) → 2  (log₁₀(100) = 2)
log(-10) → Error: logarithm is undefined for non-positive numbers
```


## **Tax Calculator**
Computes VAT (default 20%) on a given amount.

```lua
custom_functions = {
  {
    def = { phrases = "vat, tax, nett" },
    fn = function(args)
      if #args < 1 or type(args[1]) ~= "number" then
        return { error = "vat requires a numeric argument" }
      end
      local vat = args[2] and args[2] or 20 -- 20pc default
      return { result = (args[1] / (vat + 100)) * 100 }
    end,
  },
}
```

Usage:
```
vat(100) → 83.33
vat(200, 10) → 181.81
```


## **Min & Max Functions**
Returns the **smallest** (`nmin`) or **largest** (`nmax`) value from a list.

```lua
custom_functions = {
  {
    def = { phrases = "nmin" },
    fn = function(args)
      if #args < 1 then return { error = "nmin requires at least one argument" } end
      return { result = math.min(table.unpack(args)) }
    end,
  },
  {
    def = { phrases = "nmax" },
    fn = function(args)
      if #args < 1 then return { error = "nmax requires at least one argument" } end
      return { result = math.max(table.unpack(args)) }
    end,
  },
}
```

Usage:
```
nmin(10, 5, 2, 8) → 2
nmax(3, 6, 9) → 9
```


## **Standard Deviation**
Computes the **standard deviation** of a set of numbers.

```lua
custom_functions = {
  {
    def = { phrases = "stddev, sd" },
    fn = function(args)
      if #args < 2 then return { error = "stddev requires at least two numbers" } end

      local function mean(vals)
        local sum = 0
        for _, v in ipairs(vals) do sum = sum + v end
        return sum / #vals
      end

      local avg = mean(args)
      local variance = 0
      for _, v in ipairs(args) do
        variance = variance + (v - avg) ^ 2
      end
      variance = variance / #args

      return { result = math.sqrt(variance) }
    end,
  },
}
```

Usage:
```
stddev(10, 15, 20) → 4.08
stddev(1) → Error: stddev requires at least two numbers
```


## **Percentage Change**
Calculates **percentage change** between two numbers.

```lua
custom_functions = {
  {
    def = { phrases = "pc" },
    fn = function(args)
      if #args ~= 2 or type(args[1]) ~= "number" or type(args[2]) ~= "number" then
        return { error = "pc requires two numeric arguments" }
      end
      if args[1] == 0 then
        return { error = "percentage change undefined when initial value is 0" }
      end
      return { result = ((args[2] - args[1]) / args[1]) * 100 }
    end,
  },
}
```

Usage:
```
pc(100, 120) → 20
pc(50, 25) → -50
pc(0, 100) → Error: percentage change undefined when initial value is 0
```
# **Other/Non-Mathematical Examples**

## **Greeting**

```lua
custom_functions = {
  {
    def = { phrases = "hello, hi" },
    fn = function(args)
      local name = args[1] or "stranger"
      return { result = "Hello, " .. name .. "!" }
    end,
  },
}
```

Usage:
```
hello("Sam") → "Hello, Joe!"
hello() → "Hello, stranger!"
```

---

## **Dice Roll**
Rolls an `n`-sided die (default: 6).

```lua
custom_functions = {
  {
    def = { phrases = "roll, dice" },
    fn = function(args)
      local sides = args[1] or 6
      return { result = math.random(1, sides) }
    end,
  },
}
```

Usage:
```
roll() → 4  (random)
roll(20) → 15  (random)
```

This page will be updated as more useful functions and conversions are added!

