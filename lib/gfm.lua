local event_manager = require "event_manager"
local buttons = require "buttons"
local thread = require "thread"
local drawing = require "drawing"
local event = require "event"
local helpers = require "helper_functions"

local gfm = {}



--[[
  starts the frameworks threads
  IMPORTANT:
    notSafe = false or nil (default) : requires that the method event_manager.stopEventLoop has been registered to at least 1 eventName
]]--
function gfm.start(notSafe)	
	if isEventHandlerRegistered("touch", buttons.buttonsHandlerDispatcher) == false then
		event_manager.registerEventHandler("touch", buttons.buttonsHandlerDispatcher)
  	end

  	-- start drawing thread
  	
  	local drawingThread = thread.create(
  		drawing.startEventLoop
  	)
  	-- become the event thread 
	event_manager.startEventLoop(notSafe)

	-- cleanup 
	drawingThread:kill()
end

return gfm