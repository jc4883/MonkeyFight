
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local function nextScene()
	composer.gotoScene( "level1", { time=800, effect="crossFade" } )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	local sceneGroup = self.view

	local monkey = display.newImageRect(sceneGroup, "Images.xcassets/monkey5.png", 180, 120)
	monkey.x = display.contentCenterX
	monkey.y = display.contentCenterY
	
	local timer1 = timer.performWithDelay(3000, function()
		display.remove(monkey)
	end
	)
	local timer2 = timer.performWithDelay(4000, function()
		local text
		text = display.newText( "The internal machinery of life,\nthe chemistry of the parts,\nis something beautiful. And it turns out that \nall life is interconnected with all other life.\n\n-Richard Feynman", 
		display.contentCenterX , display.contentCenterY, native.systemFont, 12 )
		timer.performWithDelay(5300, function()
			display.remove(text)
		end
		)
	end
	)

	local timer3 = timer.performWithDelay(10000, function()
		local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
		local monkey = display.newImageRect(sceneGroup, "Images.xcassets/monkey.png", 180, 120)
		monkey.x = display.contentCenterX
		monkey.y = display.contentCenterY
		local kidnapper = display.newImageRect(sceneGroup, "Images.xcassets/kidnapper.png",-100,100)
		kidnapper.x = -100
		kidnapper.y = display.contentCenterY
		transition.to(kidnapper, {time=3000, x=display.contentCenterX, y=display.contentCenterY, onComplete=function()
			timer.performWithDelay(800, function()
				display.remove(monkey)
				local text = display.newText("It was precisely at that moment that he was without anything...",
				display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
				text:setFillColor(0,0,0)
				timer.performWithDelay(3000, function()
					display.remove(text)
					display.remove(kidnapper)
					local text = display.newText("That he became everything...",
					display.contentCenterX , display.contentCenterY, native.systemFont, 30)
					text:setFillColor(0,0,0)
					timer.performWithDelay(3000, function()
						display.remove(text)
						local text = display.newText("\"Puss the Dog\"",
						display.contentCenterX , display.contentCenterY, native.systemFont, 30)
						text:setFillColor(0,0,0)
						local timeText = display.newText("June 2, 1822",display.contentCenterX , display.contentCenterY  + 30, native.systemFont, 14)
						timeText:setFillColor(0,0,0)
						local locationText = display.newText("The Westminster Pit, London",display.contentCenterX , display.contentCenterY  + 50, native.systemFont, 14)
						locationText:setFillColor(0,0,0)
						timer.performWithDelay(3000, function()
							display.remove(locationText)
							display.remove(timeText)
							display.remove(text)
							display.remove(background)
							nextScene()
						end)
					end)
				end)
			end
			)
		end
		})
	end
	)


	local exitButton = display.newText(sceneGroup, "Skip >", display.contentWidth -20, 20, native.systemFont, 20)
	exitButton:setFillColor(.2, .5, 1)
	exitButton:addEventListener("tap", function() 
		timer.performWithDelay(80, function()
			timer.cancel(timer1)
			timer.cancel(timer2)
			timer.cancel(timer3)			
			composer.gotoScene("level1", { time = 300, effect = "crossFade"})
		end
		)
	end
	)
	-- Code here runs when the scene is first created but has not yet appeared on screen

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
