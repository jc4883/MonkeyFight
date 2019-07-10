
local composer = require( "composer" )

local scene = composer.newScene()
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 9.8 )

local backGroup
local mainGroup
local uiGroup

local jumpScreen
local moveScreen
local attackScreen

local winner

local opponent
	local opponentPercent
	local opponentLives
	local opponentInStun
	local opponentLoopTimer
	local opponentStart
local player
	local usedDJ
	local inLag
	local lastFacingRight
	local playerPercent
	local playerLives
	local playerInStun
local gameLoopTimer
local ground
local leftPlatform
local rightPlatform
local topPlatform
local cw, ch = display.actualContentWidth, display.actualContentHeight

local leftNair = {20,0, 20,18, -35,18, -35,0} --4
local rightNair = {-20,0, 35,0, 35,18, -20,18} --5
local onlyDair = { -10,-10, 10,-10, 0, 25 } --6
local rightBair = {-28,27,  -28,-27,  0,0 } --7
local leftBair = {28,-27,  28,27, 0,0} --9
local onlyUair = {-30,-30,  30,-30,  3,-10, -3,-10 } --11


local function createBackground()
	local gameBackground = display.newImageRect(backGroup, "Images.xcassets/gameBackground.png", 570, 360)
	gameBackground.x = display.contentCenterX
	gameBackground.y = display.contentCenterY
end

local function createGround()
	ground = display.newRect( backGroup,display.contentCenterX, ch, cw-210, 180 )
	ground:setFillColor( 0.4, 0.4, 0.8 )
	ground.myName = "ground"
	physics.addBody( ground, "static", { bounce=0.0, friction=0.3 } )
	ground.x = display.contentCenterX
	ground.y = display.contentHeight
	
end

local function gameOver()
	if (winner == 2) then
		physics.pause()
		local loserScreen = display.newText( uiGroup,
		"You Died", display.contentCenterX, 100, native.systemFont, 100)
		loserScreen:setFillColor(.2, .3, .4)
		--You can use setVariable/getVariable to pass functions across scenes!
		composer.setVariable("lastFoughtOpponent", 2) 
		composer.gotoScene("tryAgain", { time = 800, effect = "crossFade"})
	else
		local winnerScreen = display.newText( uiGroup,
		"Ahhh!", display.contentCenterX, 100, native.systemFont, 37)
		physics.pause()
		winnerScreen:setFillColor(.2, .3, .4)
		timer.performWithDelay(2000, function()
			composer.gotoScene("menu", { time = 2000, effect = "crossFade"})
		end
		)
	end
end

local function restorePlayer()
	player.x = display.contentCenterX
	player.y = display.contentCenterY
	player:setLinearVelocity(0, 0)
	usedDJ = false
	lastFacingRight = true
	transition.to( player, { alpha=1, time=2000,
		onComplete = function()
			player.isBodyActive = true
		end
	})
	playerPercent = 0
	playerPercentText.text = "0%"
end

local function restoreOpponent()
	opponent.x = display.contentCenterX + 55
	opponent.y = display.contentCenterY
	opponent:setLinearVelocity(0, 0)
	transition.to( player, { alpha=1, time=2000,
		onComplete = function()
			opponent.isBodyActive = true
			opponentStart()
		end
	})
	opponentPercent = 0
	opponentPercentText.text = "0%"
end

local function playerLostStock()
	player.alpha = 0
	player.isBodyActive = false
	playerLives = playerLives - 1
	print(playerLives)
	if (playerLives == 0) then
		winner = 2
		gameOver()
		return
	else
		playerLivesText.text = "P1: " .. playerLives
	end
	restorePlayer()
end

local function opponentLostStock()
	transition.cancel(opponent)
	timer.cancel(opponentLoopTimer)
	opponent.alpha = 0
	opponent.isBodyActive = false
	opponentLives = opponentLives - 1
	if (opponentLives == 0) then
		winner = 1
		gameOver()
		return
	else
		opponentLivesText.text = "P2: " .. opponentLives
	end
	restoreOpponent()
end
 
local function gameLoop()
	if ( player.x < -100 or
		player.x > display.contentWidth + 100 or
		player.y < -100 or
		player.y > display.contentHeight + 100)
	then
		playerLostStock()
	end
	if (opponent.x < -100 or
		opponent.x > display.contentWidth + 100 or
		opponent.y < -100 or
		opponent.y > display.contentHeight + 100 )
	then
		opponentLostStock()
	end
end

local function onCollision( event )
	local obj1 = event.object1
	local obj2 = event.object2
	
	if ( ( obj1.myName == "player" and obj2.myName == "ground" ) or
		 ( obj1.myName == "ground" and obj2.myName == "player" ) )
	then
    	-- Foot sensor has overlapped a ground object
		if ( event.phase == "began" ) then
			if (obj1.myName == "player") then
				obj1.sensorOverlaps = obj1.sensorOverlaps + 1
				inLag = false
				playerInStun = false
			else
				obj2.sensorOverlaps = obj2.sensorOverlaps + 1
				inLag = false
				playerInStun = false
			end
			usedDJ = false
        -- Foot sensor has exited a ground object
		elseif ( event.phase == "ended" ) then
			if (obj1.myName == "player") then
				obj1.sensorOverlaps = obj1.sensorOverlaps - 1
			else
				obj2.sensorOverlaps = obj2.sensorOverlaps - 1
			end
        end
	end

	if ( ( obj1.myName == "player" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "player" ) )
	then
		transition.cancel(opponent)
		opponent:setLinearVelocity(0, 0)
		usedDJ = false
		if (playerInStun == true) then
			return
		else
			playerInStun = true
			player:applyLinearImpulse(0, -100, player.x, player.y)
			playerPercent = playerPercent + 10
			playerPercentText.text = playerPercent .. "%"
			timer.performWithDelay(1000, function()
				playerInStun = false
			end)
			
		end
	end

	if ( ( obj1.myName == "rightNair" and obj2.myName == "opponent" ) or
		 ( obj1.myName == "opponent" and obj2.myName == "rightNair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 3
		print(opponentPercent)
		opponent:applyLinearImpulse( 3+ .2 * opponentPercent, -8 + .1 * opponentPercent, opponent.x, opponent.y)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

	if ( ( obj1.myName == "leftNair" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "leftNair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 3
		print(opponentPercent)
		opponent:applyLinearImpulse(  -3 - .2 * opponentPercent, - 8 + .1 * opponentPercent, opponent.x, opponent.y)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

	if ( ( obj1.myName == "rightBair" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "rightBair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 4
		print(opponentPercent)
		opponent:applyLinearImpulse( -3 - .23 * opponentPercent, -8 + .1 * opponentPercent, opponent.x, opponent.y)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

	if ( ( obj1.myName == "leftBair" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "leftBair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 4
		print(opponentPercent)
		opponent:applyLinearImpulse( 3 + .23 * opponentPercent, -8 + .1 * opponentPercent, opponent.x, opponent.y)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

	if ( ( obj1.myName == "dair" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "dair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 3
		print(opponentPercent)
		opponent:applyLinearImpulse( 0, 13 -.23 * opponentPercent, opponent.x, opponent.y)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

	if ( ( obj1.myName == "uair" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "uair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 3
		print(opponentPercent)
		opponent:applyLinearImpulse( 0, -15 - .33 * opponentPercent, opponent.x, opponent.y)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

	if ( ( obj1.myName == "fair" and obj2.myName == "opponent" ) or
		( obj1.myName == "opponent" and obj2.myName == "fair" ) )
	then
		transition.cancel(opponent)
		opponentPercent = opponentPercent + 1
		print(opponentPercent)
		opponent:setLinearVelocity(0,0)
		opponentPercentText.text = opponentPercent .. "%"
		opponentInStun = true 
		timer.performWithDelay(217, function()
			opponentInStun = false
		end
		)
	end

end

--TODO: Up B when swipe up
local function jump( event )
	if (playerInStun == true) then
		return
	end
	print("touching ground"..player.sensorOverlaps)
    if ( event.phase == "began" and player.sensorOverlaps == 1 ) then
		print("here")
		-- Jump procedure here
		local vx, vy = player:getLinearVelocity()
		player:setLinearVelocity( vx, 0 )
		player:applyLinearImpulse( nil, -70, player.x, player.y )  
	end
	if (event.phase == "began" and player.sensorOverlaps == 0 and usedDJ == false) then
		local vx, vy = player:getLinearVelocity()
		player:setLinearVelocity( vx, 0 )
		player:applyLinearImpulse( nil, -70, player.x, player.y ) 
		usedDJ = true
	end
end

--TODO: fastfall when swipe down 
local function move( event )
	if (playerInStun == true) then
		return
	end
	local swipeLength = math.abs(event.x - event.xStart) 
    print(event.phase, swipeLength)

    local t = event.target
    local phase = event.phase

    if (phase == "began") then
		
    elseif (phase == "moved") then

    elseif (phase == "ended" or phase == "cancelled") then
		--move left or right			
		local vx, vy = player:getLinearVelocity()
		if (event.xStart > event.x and swipeLength > 50) then 
			if (vx == -150) then
				return
			else
				lastFacingRight = false
				player:setLinearVelocity(-150, nil, player.x, player.y)
				return
			end
		elseif (event.xStart < event.x and swipeLength > 50) then 
			if(vx == 150) then
				return
			else
				lastFacingRight = true
				player:setLinearVelocity(150, nil, player.x, player.y)
				return
			end
		else	 
		--tap  movement
		player:setLinearVelocity( 0, vy )
		--maybe when both x, y velocity are zero, you shield
		end
    end
end


local function neutralAir()
	if(inLag == false) then
		inLag = true
		local newLaser = display.newRect(player.x, player.y, 75, 7)
		physics.addBody(newLaser, "kinematic", {isSensor=true})
		newLaser:setFillColor( 0.2, 0.8, 0.4 )
		newLaser.isBullet = true
		newLaser.myName = "fair"
		if (lastFacingRight == true) then
			transition.to(newLaser, { x=player.x + 1000, time=1500,
				onComplete = function() 
					display.remove(newLaser) 
					inLag = false	
				end
			})
		else
			transition.to(newLaser, { x=player.x-1000, time=1500, 
				onComplete = function() 
					display.remove(newLaser) 
					inLag = false
				end
			})
		end
	end
end

local function backAir()
	--50, 267, 333
	if (inLag == false) then
		inLag = true
		local bair 
		local vx, vy = player:getLinearVelocity()
		timer.performWithDelay(50, function()
			if (lastFacingRight == true) then
				bair = display.newPolygon(player.x,player.y, rightBair)
				bair.isBullet = true
				bair.myName = "rightBair"
				physics.addBody( bair, "kinematic", {isSensor=true})
				transition.to(bair, {x=player.x - 30 - vx*(267/1000), time = 267,
					onComplete = function() display.remove( bair ) end
				})
				print("rightNair performed")
			else
				bair = display.newPolygon(player.x, player.y, leftBair)
				bair.isBullet = true
				bair.myName = "leftBair"
				physics.addBody( bair, "kinematic", {isSensor=true})
				transition.to(bair, {x=player.x + 30 - vx * (267/1000), time = 267,
					onComplete = function() display.remove( bair ) end
				})
				print("leftNair performed")
			end 
			timer.performWithDelay(333, function()
				inLag = false
			end
			)
		end
		)
	end
end

--TODO: dair goes in wrong direction
local function downAir()
	if(inLag == false) then
		inLag = true
		local vx, vy = player:getLinearVelocity()
		timer.performWithDelay(67, function()
			local dair = display.newPolygon(player.x,player.y, onlyDair)
			dair.isBullet = true
			dair.myName = "dair"
			physics.addBody(dair, "kinematic", {isSensor = true})
			transition.to( dair, {y = player.y + 80 + vy * (333/1000), time=333, 
				onComplete = function() display.remove(dair) end 
			})
			print("dair performed")
		end
		)
		timer.performWithDelay(417, function()
			inLag = false 
		end
		)
	end
end 

local function upAir()
	--117 117 417
	if(inLag == false) then
		inLag = true
		local vx, vy = player:getLinearVelocity()
		timer.performWithDelay(117, function()
			local uair = display.newPolygon(player.x, player.y, onlyUair)
			uair.isBullet = true
			uair.myName = "uair"
			physics.addBody(uair, "kinematic", {isSensor = true})
			transition.to( uair, {y= player.y - 40 + vy * (117/1000), time=117, 
				onComplete = function() display.remove(uair) end 
			})
			print("uair performed")
		end
		)
		timer.performWithDelay(417, function()
			inLag = false 
		end
		)
	end
end

local function forwardAir()
	if (inLag == false) then
		inLag = true
		local nair 
		local vx, vy = player:getLinearVelocity()
		timer.performWithDelay(67, function()
			if (lastFacingRight == true) then
				nair = display.newPolygon(player.x, player.y, rightNair)
				nair.isBullet = true
				nair.myName = "rightNair"
				physics.addBody( nair, "kinematic", {isSensor=true})
				transition.to(nair, {x=player.x + 30 + vx * (383/1000), time = 383,
					onComplete = function() display.remove( nair ) end
				})
				print("rightNair performed")
			else
				nair = display.newPolygon(player.x,player.y, leftNair)
				nair.isBullet = true
				nair.myName = "leftNair"
				physics.addBody( nair, "kinematic", {isSensor=true})
				transition.to(nair, {x=player.x-30 + vx * (383/1000), time = 383, 
					onComplete = function() display.remove( nair ) end
				})
				print("leftNair performed")
			end 
			timer.performWithDelay(250, function()
				inLag = false
			end
			)
		end
		)
	end
end


local function attack(event)
	if(playerInStun == true) then
		return
	end
	local swipeLengthX = math.abs(event.x - event.xStart) 
	local swipeLengthY = math.abs(event.y - event.yStart)
	local vx, vy
	local phase = event.phase
	if (phase == "ended" or phase == "cancelled") then
		local vx, vy = player:getLinearVelocity()
		if(event.yStart > event.y and swipeLengthY > 50) then
			upAir()
		elseif(event.yStart < event.y and swipeLengthY > 50) then
			downAir()
		elseif(event.xStart > event.x and swipeLengthX > 50 ) then
			--swipe left
			if (vx > 0) then
				backAir()
			elseif( vx < 0) then
				forwardAir()
			else
				--vx==0
				if (lastFacingRight == true) then
					backAir()
				else
					forwardAir()
				end
			end
		elseif(event.xStart < event.x and swipeLengthX > 50) then
			--swipe right
			if (vx > 0) then
				forwardAir()
			elseif(vx < 0) then
				backAir()
			else
				--vx==o
				if (lastFacingRight == true) then
					forwardAir()
				else
					backAir()
				end
			end

		end
	end
end

local function createControls()
	jumpScreen = display.newRect(display.contentWidth, 0, display.contentWidth/2, display.contentHeight/2)
	jumpScreen:setFillColor(1,1,.2, .2)
	jumpScreen.anchorX = 1
	jumpScreen.anchorY = 0
	jumpScreen:addEventListener( "touch", jump ) --TODO: update this so when you touch right,top half

	moveScreen = display.newRect(0, 0, display.contentWidth/2, display.contentHeight)
	moveScreen:setFillColor(0, 1.5, 1.5, .2 )
	moveScreen.anchorX	= 0
	moveScreen.anchorY = 0
	moveScreen:addEventListener("touch", move)

	attackScreen = display.newRect(display.contentWidth, display.contentHeight, display.contentWidth/2, display.contentHeight/2)
	attackScreen:setFillColor(1.5, 0, 1.5, .2 )
	attackScreen.anchorX = 1
	attackScreen.anchorY = 1
	attackScreen:addEventListener("touch", attack)

end

function opponentStart()
	opponentLoopTimer = timer.performWithDelay(1000, function()
		local random = math.random()
		local randomAdusted = random * 355  + (60)
		transition.to(opponent, {time=1000, x=randomAdusted})
	end, 0 )
	--local new = display.newRect(60, 200, 5, 100)
	--[local old = display.newRect(cw-150, 200, 5, 100)
	--local stageSize = display.newRect(display.contentCenterX, display.contentCenterY + 50, 355, 100)
end

local function newOpponent()
	opponent = display.newRect(display.contentCenterX + 100, display.contentCenterY, 30, 46)
	opponent:setFillColor(.4, .9, .2)
	local opponentBodyParts = {
		body = {-15,-23,  15,-23,  15,23, -15,23}, --2
		feet = {-13,23, 13,23, 13,25, -13,25}, --3
		head = {-13,-23, -13,-25, 13,-25, 13,-23} --4
	}
	physics.addBody(opponent, "dynamic", 
		{density = 7}, 
		{ shape = opponentBodyParts["body"]},
		{ shape = opponentBodyParts["feet"]}, 
		{ shape = opponentBodyParts["head"]}
	)

	opponent.myName = "opponent"
	opponent.isFixedRotation = true
	opponentPercent = 0

	opponentLives = 4
	opponentPercent = 0

	opponentInStun = false

end

local function newPlayer()
	--TODO: change display from rectangle to image
	player = display.newRect( display.contentCenterX - 100, display.contentCenterY, 30, 46 )
	player:setFillColor( 1, 0.2, 0.4 )
	player.myName = "player"

	local bodyParts = {
		body = {-15,-23,  15,-23,  15,23, -15,23}, --2
		feet = {-13,23, 13,23, 13,25, -13,25}, --3
		head = {-13,-23, -13,-25, 13,-25, 13,-23} --4
	}    

	physics.addBody(player, "dynamic", 
		{ density=7},
		{ shape = bodyParts["body"] },
		{ shape = bodyParts["feet"]},
		{ shape = bodyParts["head"]}
	)

	player.isFixedRotation = true
	player.sensorOverlaps = 0
	Runtime:addEventListener( "collision", onCollision )

	inLag = false
	lastFacingRight = true
	usedDJ = false
	playerPercent = 0

	playerLives = 4
	
	playerPercent = 0

	playerInStun =  false

end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	-- create display groups
	physics.pause()
	backGroup = display.newGroup()  
    sceneGroup:insert( backGroup )  
 
    mainGroup = display.newGroup()  
    sceneGroup:insert( mainGroup )  
 
    uiGroup = display.newGroup()    
	sceneGroup:insert( uiGroup )

	newPlayer()

	newOpponent()

	createBackground()

	createControls()
	
	createGround()

	opponentStart()

	playerLivesText = display.newText( uiGroup, "P1: " .. playerLives, 20, display.contentHeight - 40, native.systemFont, 12 )
	print("playerLives: " .. playerLives)
	opponentLivesText = display.newText( uiGroup, "P2: " .. opponentLives, 20 , display.contentHeight - 14, native.systemFont, 12 )
	playerPercentText = display.newText( uiGroup,  playerPercent .. "%", 100, display.contentHeight - 40, native.systemFont, 12 )
	print("playerPercent" .. playerPercent)
	opponentPercentText = display.newText( uiGroup, opponentPercent .. "%", 100, display.contentHeight - 14, native.systemFont, 12 )
	
	local exitButton = display.newText(sceneGroup, "< Exit", 20, 20, native.systemFont, 20)
	exitButton:setFillColor(.2, .5, 1)
	exitButton:addEventListener("tap", function() 
		timer.performWithDelay(80, function()
			composer.gotoScene("menu", { time = 300, effect = "crossFade"})
		end
		)
	end
	)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		physics.setDrawMode( "hybrid" )
	
		gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		timer.cancel( gameLoopTimer)
		timer.cancel( opponentLoopTimer)
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener("collision", onCollision)
		jumpScreen:removeEventListener( "touch", jump ) --TODO: update this so when you touch right,top half
		moveScreen:removeEventListener("touch", move)
		attackScreen:removeEventListener("touch", attack)

		display.remove(ground)
		display.remove(jumpScreen)
		display.remove(moveScreen)
		display.remove(attackScreen)
		display.remove(player)
		display.remove(opponent)

		physics.pause()
		composer.removeScene( "level2" )
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

--[[
TODO: 
- opponents
- gameover scene
- plot building scenes
]]