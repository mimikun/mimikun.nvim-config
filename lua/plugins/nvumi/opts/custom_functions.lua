---@type table
local custom_functions = {
  -- Factorial
  -- Calculates the factorial of a number (e.g., `5! = 5 × 4 × 3 × 2 × 1 = 120`).
  {
    def = { phrases = "factorial, fact" },
    fn = function(args)
      if #args < 1 or type(args[1]) ~= "number" then
        return { error = "factorial requires a single numeric argument" }
      end
      local n = math.floor(args[1])
      if n < 0 then
        return { error = "factorial undefined for negative numbers" }
      end
      if n > 100 then
        return math.huge
      end

      local function factorial(num)
        if num <= 1 then
          return 1
        end
        return num * factorial(num - 1)
      end

      return { result = factorial(n) }
    end,
  },
  -- Logarithm (Base 2 & Custom Base)
  -- Computes the logarithm of a number with a default base of **2**, or a custom base.
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
  -- Tax Calculator
  -- Computes VAT (default 20%) on a given amount.
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
  -- Min & Max Functions
  -- Returns the **smallest** (`nmin`) or **largest** (`nmax`) value from a list.
  {
    def = { phrases = "nmin" },
    fn = function(args)
      if #args < 1 then
        return { error = "nmin requires at least one argument" }
      end
      return { result = math.min(table.unpack(args)) }
    end,
  },
  {
    def = { phrases = "nmax" },
    fn = function(args)
      if #args < 1 then
        return { error = "nmax requires at least one argument" }
      end
      return { result = math.max(table.unpack(args)) }
    end,
  },
  -- Standard Deviation
  -- Computes the **standard deviation** of a set of numbers.
  {
    def = { phrases = "stddev, sd" },
    fn = function(args)
      if #args < 2 then
        return { error = "stddev requires at least two numbers" }
      end

      local function mean(vals)
        local sum = 0
        for _, v in ipairs(vals) do
          sum = sum + v
        end
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
  -- Percentage Change**
  -- Calculates **percentage change** between two numbers.
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
  -- Square
  {
    def = { phrases = "square, sqr" },
    fn = function(args)
      if #args < 1 or type(args[1]) ~= "number" then
        return { error = "square requires a single numeric argument" }
      end
      return { result = args[1] * args[1] }
    end,
  },
  -- Greeting
  {
    def = { phrases = "hello, hi" },
    fn = function(args)
      local name = args[1] or "stranger"
      return { result = "Hello, " .. name .. "!" }
    end,
  },
  -- Coin flip
  {
    def = { phrases = "coinflip, flip" },
    fn = function()
      return { result = (math.random() > 0.5) and "Heads" or "Tails" }
    end,
  },
  -- Dice Roll
  -- Rolls an `n`-sided die (default: 6)
  {
    def = { phrases = "roll, dice" },
    fn = function(args)
      local sides = args[1] or 6
      return { result = math.random(1, sides) }
    end,
  },
}

return custom_functions
