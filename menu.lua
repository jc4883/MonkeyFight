
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoGame()
	--composer.gotoScene("level4", { time =  800, effect = "crossFade"})
	composer.gotoScene("cutscenes.between3and4.1", { time =  800, effect = "crossFade"})

end
local function gotoTutorial()
	composer.gotoScene("tutorial", { time =  800, effect = "crossFade"})
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect(sceneGroup, "Images.xcassets/background.png", 800, 1400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local title = display.newText(sceneGroup, "Monkey Fight", display.contentCenterX, 100, native.systemFont, 44)
	title:setFillColor(.82, .86, 1)
	local playButton = display.newText(sceneGroup, "Play", display.contentCenterX, 200, native.systemFont, 44)
	playButton:setFillColor(.82, .86, 1)
	local tutorialButton = display.newText(sceneGroup, "Tutorial", 120, 270, native.systemFont, 20)
	tutorialButton:setFillColor(.2, .5, 1)

	playButton:addEventListener("tap", gotoGame)
	tutorialButton:addEventListener("tap", gotoTutorial)
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
