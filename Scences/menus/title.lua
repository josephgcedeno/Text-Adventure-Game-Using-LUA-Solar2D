local composer = require( "composer" )
local loadsave = require("loadSave") 
local userData = loadsave.loadTable( "userdata.json" )
local scene = composer.newScene()
local sfx_click = audio.loadStream( "audio/Click.mp3" )

composer.recycleOnSceneChange = true
--------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE 
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------
local background
local buttonstart
local buttonexit
local logo

local function startGame ()
  audio.play(sfx_click)
 
  if (userData.current_frame == "begin") then
    composer.gotoScene("Scences.chapter1.scene1.frame1", "fade", 500)
    
  else
    composer.gotoScene(userData.current_frame, "fade", 500)
  end

end
local function exitGame ()
  audio.play(sfx_click)
  native.requestExit()
end
--------------------------------------------------------------------------------
-- "scene:create()"
--------------------------------------------------------------------------------
function scene:create( event )
  local sceneGroup = self.view
  -- Initialize the scene here.
  -- Example: add display objects to "sceneGroup", add touch listeners, etc.
  background = display.newImageRect("images/menus/background.jpg",1080,1920)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  sceneGroup:insert(background)

  logo = display.newImageRect("images/menus/logo.png",  650,650)
  logo.anchorX = 0
  logo.anchorY = 0
  logo.x, logo.y = 200, 150
  sceneGroup:insert(logo)


  if (userData.current_frame == "begin") then
    buttonstart = display.newImageRect("images/menus/startButton.png",  700,100)
    
  else
    buttonstart = display.newImageRect("images/menus/resumeButton.png",  700,100)
  end

  buttonstart.anchorX = 0
  buttonstart.anchorY = 0
  buttonstart.x, buttonstart.y = 200, 1350
  sceneGroup:insert(buttonstart)
 
  buttonexit = display.newImageRect("images/menus/exitButton.png",  700,100)
  buttonexit.anchorX = 0
  buttonexit.anchorY = 0
  buttonexit.x, buttonexit.y = 200, 1500
  sceneGroup:insert(buttonexit)


  buttonstart:addEventListener("tap", startGame)
  buttonexit:addEventListener("tap", exitGame)
end

--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

    -- Called when the scene is still off screen (but is about to come on screen).
  elseif ( phase == "did" ) then
    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
  end
end

--------------------------------------------------------------------------------
-- "scene:hide()"
--------------------------------------------------------------------------------
function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
  elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen.
  end
end

--------------------------------------------------------------------------------
-- "scene:destroy()"
--------------------------------------------------------------------------------
function scene:destroy( event )
  local sceneGroup = self.view

  -- Called prior to the removal of scene's view ("sceneGroup").
  -- Insert code here to clean up the scene.
  -- Example: remove display objects, save state, etc.
end

--------------------------------------------------------------------------------
-- Listener setup
--------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------------

return scene