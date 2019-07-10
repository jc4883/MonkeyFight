
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local function nextScene()
	composer.gotoScene( "level4", { time=800, effect="crossFade" } )
end

local kidnapper
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	local sceneGroup = self.view

	local timer1 = timer.performWithDelay(1500, function()
		kidnapper = display.newImageRect(sceneGroup, "Images.xcassets/stickman.png", 180, 120)
		kidnapper.x = display.contentCenterX
		kidnapper.y = display.contentCenterY
	end)

	local timer2 = timer.performWithDelay(3000, function()
		local dialogue = display.newText( "JACCO...", 
		display.contentCenterX , display.contentCenterY + 150, native.systemFont, 20 )
		local timer = timer.performWithDelay(1000, function()
			display.remove(dialogue)
			transition.to(kidnapper, {x=display.contentCenterX + 200, time=1000})
			local timer = timer.performWithDelay(2000, function()
				local dialogue = display.newText( "JACCO...", 
					display.contentCenterX , display.contentCenterY + 150, native.systemFont, 20 )
				transition.to(kidnapper, {x=display.contentCenterX, time=1000})
				local timer = timer.performWithDelay(2000, function()
					display.remove(dialogue)
					transition.to(kidnapper, {x=display.contentCenterX -400, time = 1000})
					local timer = timer.performWithDelay(1000, function()
						display.remove(kidnapper)
					end)
				end)
			end)
		end)
	end
	)

	local timer3 = timer.performWithDelay(10000, function()
		local monkey = display.newImageRect(sceneGroup, "Images.xcassets/monkey5.png", 180, 120)
		local gun = display.newImageRect(sceneGroup, "Images.xcassets/gun.png", 50, 70)
		monkey.x = 100
		monkey.y = display.contentCenterY
		gun.x = monkey.x + 50
		gun.y = display.contentCenterY
		local timer = timer.performWithDelay(1000, function()
			local dialogue = display.newText("Ooh Ooh Aah ah!\n*(to be or not to be!)*",
			display.contentCenterX , display.contentCenterY + 100, native.systemFont, 20 )
			local timer1 = timer.performWithDelay(2000, function()
				display.remove(dialogue)
			end)
			 kidnapper = display.newImageRect(sceneGroup, "Images.xcassets/stickman.png", 180, 120)
			kidnapper.x = display.contentWidth + 400
			kidnapper.y = display.contentCenterY
			transition.to(kidnapper, {x=display.contentCenterX + 150, time=2000})
			local timer2 = timer.performWithDelay(3000, function()
				local dialogue = display.newText("JACCO!\nPUT THAT DOWN",
					display.contentCenterX , display.contentCenterY + 100, native.systemFont, 20 )
					local timer1 = timer.performWithDelay(2000, function()
						display.remove(dialogue)
						local timer2 = timer.performWithDelay(1000, function()
							local dialogue = display.newText("Ooh Aah Ooh Ooh!\n*(I take arms against my sea of troubles!)*",
								display.contentCenterX , display.contentCenterY + 100, native.systemFont, 20 )
								local timer = timer.performWithDelay(2000, function()
									display.remove(dialogue)
									local bullet = display.newImageRect(sceneGroup, "Images.xcassets/bullet.png", 30, 30)
									bullet.x =  monkey.x 
									bullet.y = monkey.y
									transition.to(bullet, {x = display.contentWidth + 100, time = 1000})
									transition.to(kidnapper, {y = display.contentCenterY + 150, time = 500})
									local timer = timer.performWithDelay(1000, function()
										display.remove(bullet)
										transition.to(kidnapper, {y= display.contentCenterY, time = 1000})
									end)
								end)
						
						end)
					end)
			end)
		end)
	end)
	

	

	--[[

kidnapper = display.newImageRect(sceneGroup, "Images.xcassets/stickman.png", 180, 120)
kidnapper.x = display.contentWidth + 150
kidnapper.y = display.contentCenterY
local timer = timer.performWithDelay(3000, function()
	transition.to(kidnapper, {x = display.contentCenterX + 200, time = 1000})
end)
]]
	--[[
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

]]
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
		composer.removeScene( "cutscenes.between3and4.1" )

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
