---------------------------------------------------------------------
-- LIBS
---------------------------------------------------------------------
local client, awesome = client, awesome
local awful  = require("awful")
local centered = awful.placement.centered
local table = { sort = table.sort }

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Disable maximized status by default
    local current_tag = awful.screen.focused().selected_tag
    local current_layout = current_tag.layout

    -- TODO: stateful layouts aren't supported yet
    if type(current_layout) == "table" then
      if current_layout.name ~= "max" then
        c.maximized = false
      end
    end

    -- Centered and movable dialogs
    if c.type == "dialog" then
      centered(c.focus)
      c.floating = true
    end
end)

local function sort_slaves_by_index(a, b)
  local idx_a = awful.client.idx(a).idx
  local idx_b = awful.client.idx(b).idx

  return idx_a < idx_b
end

local function rearrange_slaves(focused_client)
  -- Get master client
  local master_client = awful.client.getmaster()
  if not master_client then return end

  -- We've focused back master client
  if focused_client.window == master_client.window then
    local clients = awful.screen.focused().tiled_clients

    -- We need to sort tiled clients by their layout index
    table.sort(clients, sort_slaves_by_index)
    
    -- Raise these clients back except the master client
    local clients_size = #clients
    for i = 1, clients_size do
      local client = clients[i]

      if client.window ~= master_client.window then
        client:raise()
      end
    end 
  end
end

client.connect_signal("focus", function(c)
  if awesome.startup then return end

  local current_tag    = awful.screen.focused().selected_tag
  local current_layout = current_tag.layout

  if type(current_layout) == "table" then
    if current_layout.name == "cascadetile" then
      rearrange_slaves(c)
    end
  end
end)