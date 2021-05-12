local upKeyStroke = function()
  hs.eventtap.keyStroke({}, 'up')
end

local downKeyStroke = function()
  hs.eventtap.keyStroke({}, 'down')
end

local vimMotionUp = hs.hotkey.new({"ctrl"}, "k", upKeyStroke, nil, upKeyStroke)
local vimMotionDown = hs.hotkey.new({"ctrl"}, "j", downKeyStroke, nil, downKeyStroke)

local enableVimNavigation = function()
  -- hs.alert.show('Enable VIM motion')
  vimMotionUp:enable()
  vimMotionDown:enable()
end

local disableVimNavigation = function()
  -- hs.alert.show('Disable VIM motion')
  vimMotionUp:disable()
  vimMotionDown:disable()
end

enableVimNavigation();
-- hs.application.enableSpotlightForNameSearches(true)

hs.hotkey.bind({"ctrl"}, "escape", function()
  local app = hs.application.get("kitty")
  if app then
      if not app:mainWindow() then
          app:selectMenuItem({"kitty", "New OS window"})
          disableVimNavigation()
      elseif app:isFrontmost() then
          enableVimNavigation()
          app:hide()
      else
          disableVimNavigation()
          app:activate()
      end
  else
      hs.application.launchOrFocus("kitty")
  end
end)

--[[ local eventsHr = {}

for key, _ in pairs(hs.application.watcher) do
  local value = hs.application.watcher[key]
  if type(value) == 'number' and value < 10 then
    eventsHr[tostring(value)] = key
  end
end ]]

local appWatcher = hs.application.watcher.new(function(name, event)
  -- hs.alert.show("Event: "..(eventsHr[tostring(event)] or '').."; App: "..name, 10)
  if event == hs.application.watcher.activated then
    if name == 'kitty' then
      vimMotionUp:disable()
      vimMotionDown:disable()
    else
      vimMotionUp:enable()
      vimMotionDown:enable()
    end
  end
end)

appWatcher:start()
