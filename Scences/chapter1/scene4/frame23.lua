local composer = require( "composer" )
local scene = composer.newScene()
local loadSave = require("loadSave")
local userData = loadSave.loadTable("userdata.json")
local sfx_click = audio.loadStream( "audio/Click.mp3" )
local sfx_turn = audio.loadStream( "audio/TurningPage.mp3" )


--------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE 
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------
local health
local healthbar
local settings
local imagescene
local textScene
local buttonNext
local buttonPrev

local function nextFrame()
  audio.play(sfx_turn)
  composer.gotoScene("Scences.chapter1.scene4.frame24", "fade", 500)
end

local function prevFrame()
  audio.play(sfx_turn)
  composer.gotoScene("Scences.chapter1.scene4.frame22", "fade", 500)
end
local function openSettings()
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


  health = display.newText("Health:", 150, 80, "font/EnchantedLand.otf", 60 )
  health.anchorX = 0
  health.anchorY = 0
  health.x, health.y = 200, 100
  sceneGroup:insert(health)

  local currentHealth = userData.health
  local healthbar = display.newRect( 0, 0, 10, 5.4*currentHealth )

  healthbar:setFillColor(1,1,1)
  healthbar.anchorX = 0
  healthbar.anchorY = 0
  healthbar.x, healthbar.y = 340, 144
  healthbar.rotation = 270
  sceneGroup:insert(healthbar)


  settings = display.newImageRect("images/chapter1/settings.png",70,70)
  settings.x, settings.y = 950, 130
  sceneGroup:insert(settings)

  imagescene = display.newImageRect("images/chapter1/scene_11/scene_11.png", 700,1100)
  imagescene.anchorX = 0
  imagescene.anchorY = 0
  imagescene.x, imagescene.y = 200, 250
  sceneGroup:insert(imagescene)

  local textCenter = 
  {
      text = "Leopold then shouts - “We are getting sloppy” \n\n “Let’s take them one at a time, I'll hit them with my crossbow and you get them with your mace” Leopold nocks a quarrel on his crossbow and takes aim towards the two enemies advancing from the left flank.",     
      x = 193,
      y = 1380,
      width = 700,
      font = "font/EnchantedLand.otf",   
      fontSize = 55,
      align = "center"  -- Alignment parameter
  }
  
  textScene = display.newText(textCenter)
  textScene:setFillColor(1,1,1)
  textScene.anchorX = 0
  textScene.anchorY = 0
  sceneGroup:insert(textScene)


  buttonPrev = display.newImageRect("images/chapter1/next_arrow_icon.png"  ,150,150)
  buttonPrev.anchorX = 0
  buttonPrev.anchorY = 0
  buttonPrev.x, buttonPrev.y = 170, 1650
  buttonPrev.rotation = 180
  sceneGroup:insert(buttonPrev)

  buttonNext = display.newImageRect("images/chapter1/next_arrow_icon.png"  ,150,150)
  buttonNext.anchorX = 0
  buttonNext.anchorY = 0
  buttonNext.x, buttonNext.y = 910, 1500
  sceneGroup:insert(buttonNext)

  buttonNext:addEventListener("tap", nextFrame)
  buttonPrev:addEventListener("tap", prevFrame)
  settings:addEventListener("tap",openSettings)

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
    if (userData.health<=0) then
      composer.gotoScene("Scences.menus.gameover", "fade")
    end
     
     local currentFrame=composer.getSceneName("current")

     local userDataToUpdate = {
        soundvol=userData.soundvol,
        sfxvol=userData.sfxvol,
        health=userData.health,
        current_frame=currentFrame
     }

    loadSave.saveTable( userDataToUpdate,"userdata.json")
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