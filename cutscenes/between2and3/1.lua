
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local function nextScene()
	composer.gotoScene( "level3", { time=800, effect="crossFade" } )
end


local background
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	local sceneGroup = self.view
	local text = display.newText( "Mr. Unpredictable, a vicious foe worthy of neither death nor life...", 
		display.contentCenterX , display.contentCenterY, native.systemFont, 15 )

	local timer1 = timer.performWithDelay(3500, function()
		display.remove(text)
	end
	)

	local timer2 = timer.performWithDelay(4000, function()
		local text = display.newText( "loses the fight, yet wins Jacco Macacco's left leg\n", 
			display.contentCenterX , display.contentCenterY, native.systemFont, 15 )
		timer.performWithDelay(4000, function()
			display.remove(text)
				timer.performWithDelay(1500, function()
					local text = display.newText( "Upon death, he remembers a life neither solemn nor celebratory...\n", 
					display.contentCenterX , display.contentCenterY, native.systemFont, 15 )
					timer.performWithDelay(3500, function()
						display.remove(text)
						timer.performWithDelay(500, function()	
							local text = display.newText( "...the life of a forced fighter...a life altogether unremarkable", 
							display.contentCenterX , display.contentCenterY, native.systemFont, 15 )
							timer.performWithDelay(4500, function()
								display.remove(text)
							end)
						end)
					end)
			end)
		end)
	end)

	local timer3 = timer.performWithDelay(20000, function()
		background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
		local text = display.newText("\"The Turtle\"",
		display.contentCenterX , display.contentCenterY, native.systemFont, 30)
		text:setFillColor(0,0,0)
		local timeText = display.newText("January 1, 1823",display.contentCenterX , display.contentCenterY  + 30, native.systemFont, 14)
		timeText:setFillColor(0,0,0)
		local locationText = display.newText("Underground Blood Sport Championships, London",display.contentCenterX , display.contentCenterY  + 50, native.systemFont, 14)
		locationText:setFillColor(0,0,0)
		timer.performWithDelay(3000, function()
			display.remove(locationText)
			display.remove(timeText)
			display.remove(text)
		end)
	end)

	local timer4 = timer.performWithDelay(23000, function()
		local text = display.newText("Jacco Maccaco now hops on one leg!",
		display.contentCenterX , display.contentCenterY, native.systemFont, 30)
		text:setFillColor(0,0,1)
		timer.performWithDelay(2000, function()
			display.remove(text)
			display.remove(background)
			nextScene()
		end)
	end)

end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene( "cutscenes.between2and3.1" )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
