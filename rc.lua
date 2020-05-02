-- LuaRocks
require "luarocks.loader"

---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local os = os

local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local DEBUG = false
if DEBUG then require("debugger") end

-- Legacy
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- Custom
require("handlers")
require("autostart")
require("themes")
require("menu")
require("signals")
require("bindings.global")
require("rules")

-- Modules
require("modules")