-- LuaRocks
require "luarocks.loader"

---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local dpi           = require("beautiful.xresources").apply_dpi

local DEV_MODE = false
if DEV_MODE then require("debugger") end

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