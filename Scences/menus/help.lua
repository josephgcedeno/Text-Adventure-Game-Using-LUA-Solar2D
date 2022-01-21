local composer = require( "composer" )
local scene = composer.newScene()
local sfx_click = audio.loadStream( "audio/Click.mp3" )

--------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE 
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------
local background
local close
local helpText
local helpPara



local function backPrevFrame()

  audio.play(sfx_click)

  composer.gotoScene("Scences.menus.settings", "fade", 500)


end



--------------------------------------------------------------------------------
-- "scene:create()"
--------------------------------------------------------------------------------
function scene:create( event )
  local sceneGroup = self.view
  -- Initialize the scene here.
  -- Example: add display objects to "sceneGroup", add touch listeners, etc.
  background = display.newImageRect("images/menus/help_frame.jpg",1080,1920)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  sceneGroup:insert(background)


  close = display.newImageRect("images/menus/close.png",70,70)
  close.x, close.y = 950, 130
  sceneGroup:insert(close)

  helpText = display.newText("Help", 150, 80, "font/EnchantedLand.otf", 120 )
  helpText.anchorX = 0
  helpText.anchorY = 0
  helpText.x,helpText.y = 450,120
  helpText:setFillColor(1,1,1)
  sceneGroup:insert(helpText)





  local textCenter = 
  {
      text = "To Play\n\n\n The game will let you select between choices that you think is the best. Click the next icon to proceed with the game. You cannot go back once you have chosen an answer.",     
      x = 195,
      y = 600,
      width = 700,
      font = "font/EnchantedLand.otf",   
      fontSize = 55,
      align = "center"  -- Alignment parameter
  }


  helpPara = display.newText(textCenter)
  helpPara:setFillColor(1,1,1)
  helpPara.anchorX = 0
  helpPara.anchorY = 0
  sceneGroup:insert(helpPara)

  

 

  -- event listener
  close:addEventListener("tap",backPrevFrame)


end

--------------------------------------------------------------------------------
-- "scene:show()"
--------------------------------------------------------------------------------
function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    
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