
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local function nextScene()
	composer.gotoScene( "level2", { time=800, effect="crossFade" } )
end


local background
local captivityText
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	local sceneGroup = self.view

	captivityText = display.newText( "1 year of captivity and brutal fighting later...", 
		display.contentCenterX , display.contentCenterY, native.systemFont, 12 )

	local timer1 = timer.performWithDelay(4000, function()
		display.remove(captivityText)
	end
	)

	local timer2 = timer.performWithDelay(5000, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/dog1.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Puss\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(2000, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(4000, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer3 = timer.performWithDelay(9000, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/monkey1.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Jape the Ape\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(1500, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(3000, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer4 = timer.performWithDelay(12000, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/dog2.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Doggo Boi\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(1000, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(2000, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer5 = timer.performWithDelay(14000, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/monkey2.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Keke the Monkey\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(800, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1600, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer6 = timer.performWithDelay(15600, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/dog3.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Snoopy\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(600, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1200, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer7 = timer.performWithDelay(16800, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/monkey3.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Curious George\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(700, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1400, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)


	local timer8 = timer.performWithDelay(18200, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/dog4.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"My Guy\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(600, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1200, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer9 = timer.performWithDelay(19400, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/monkey4.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"The Bourgeois\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(600, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1200, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer10 = timer.performWithDelay(20600, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/dog5.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Doge Coin\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(600, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1200, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer11 = timer.performWithDelay(21800, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/monkey.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"FreeBSD\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(600, function()
			defeatedText = display.newText("DEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(1,0,0)
		end)
		timer.performWithDelay(1200, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)
	--23000
	
	local timer12 = timer.performWithDelay(23000, function()
		local animal = display.newImageRect(sceneGroup, "Images.xcassets/trainingmonkey.png", 180, 120)
		animal.x = display.contentCenterX
		animal.y = display.contentCenterY
		local defeatedText
		local text = display.newText("\"Jacco Maccaco\"",
		display.contentCenterX , display.contentCenterY + 100, native.systemFont, 14)
		timer.performWithDelay(800, function()
			defeatedText = display.newText("UNDEFEATED",
			display.contentCenterX , display.contentCenterY, native.systemFont, 30)
			defeatedText:setFillColor(0,1,0)
		end)
		timer.performWithDelay(1600, function()
			display.remove(text)
			display.remove(animal)
			display.remove(defeatedText)
		end)
	end)

	local timer13 = timer.performWithDelay(26000, function()
		background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
		local text = display.newText("\"Mr. Unpredictable\"",
		display.contentCenterX , display.contentCenterY, native.systemFont, 30)
		text:setFillColor(0,0,0)
		local timeText = display.newText("July 3, 1823",display.contentCenterX , display.contentCenterY  + 30, native.systemFont, 14)
		timeText:setFillColor(0,0,0)
		local locationText = display.newText("Callooh Animal Fight Club, London",display.contentCenterX , display.contentCenterY  + 50, native.systemFont, 14)
		locationText:setFillColor(0,0,0)
		timer.performWithDelay(3000, function()
			display.remove(locationText)
			display.remove(timeText)
			display.remove(text)
		end)
	end)

	local timer14 = timer.performWithDelay(30000, function()
		local text = display.newText("Learned Double Jump!",
		display.contentCenterX , display.contentCenterY, native.systemFont, 30)
		text:setFillColor(0,0,1)
		timer.performWithDelay(2000, function()
			display.remove(text)
			display.remove(background)
			nextScene()
		end)
	end)

	local exitButton = display.newText(sceneGroup, "Skip >", display.contentWidth -20, 20, native.systemFont, 20)
	exitButton:setFillColor(.2, .5, 1)
	exitButton:addEventListener("tap", function() 
		timer.performWithDelay(80, function()
			timer.cancel(timer1)
			timer.cancel(timer2)
			timer.cancel(timer3)		
			timer.cancel(timer4)
			timer.cancel(timer5)
			timer.cancel(timer6)
			timer.cancel(timer7)
			timer.cancel(timer8)
			timer.cancel(timer9)
			timer.cancel(timer10)
			timer.cancel(timer11)
			timer.cancel(timer12)
			timer.cancel(timer13)
			timer.cancel(timer14)	
			composer.gotoScene("level2", { time = 800, effect = "crossFade"})
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
		composer.removeScene( "cutscenes.between1and2.1" )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	display.remove(captivityText)

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
