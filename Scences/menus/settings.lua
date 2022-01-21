local composer = require( "composer" )
local widget = require( "widget" )
local loadSave = require("loadSave")
local scene = composer.newScene()
local backgroundMusic = audio.loadStream( "audio/music.mp3" ) -- Loops the music
local sfx_click = audio.loadStream( "audio/Click.mp3" )

--------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE 
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------------
-- local forward references should go here
--------------------------------------------------------------------------------
local background
local title
local startButton
local close
local settingsText
local volumeText
local musicText
local sfxText
local gameOptionsText
local resetGameText
local exitGameText
local helpGameText
local sliderMusic
local musicCurVol
local SFXCurVol

local userData = loadSave.loadTable("userdata.json")

musicCurVol = userData.soundvol
SFXCurVol = userData.sfxvol

local function backPrevFrame()

  audio.play(sfx_click)

  local previousScene=composer.getSceneName("previous")

  local userDataToUpdate = {
      soundvol=musicCurVol,
      sfxvol=SFXCurVol,
      health=userData.health,
      current_frame=userData.current_frame
  }

  loadSave.saveTable( userDataToUpdate,"userdata.json")

  if (previousScene ~= "Scences.menus.help") then
    composer.gotoScene(previousScene, "fade", 500)
  else
    composer.gotoScene(userData.current_frame, "fade", 500)
  end


end
local function sliderListenerMusic( event )

    musicCurVol =  event.value

    audio.setVolume(event.value/100, { channel=1 } )
   
end


local function sliderListenerSFX( event )

    SFXCurVol =  event.value

    audio.setVolume(event.value/100, { channel=2 } )

    audio.setVolume(event.value/100, { channel=3 } )
   
end

local function resetGame( )
   audio.stop( 1 )
   audio.play(backgroundMusic, { channel=1, loops=-1 })

   audio.play(sfx_click)

   local userDataToUpdate = {
      soundvol=userData.soundvol,
      sfxvol=userData.sfxvol,
      health=100,
      current_frame="begin"
   }

   loadSave.saveTable( userDataToUpdate,"userdata.json")
   composer.gotoScene("Scences.menus.title","fade",500)
   
end

local function exitGame ()
   audio.play(sfx_click)
  
  native.requestExit()
end

local function helpGame()
   audio.play(sfx_click)
  
  composer.gotoScene("Scences.menus.help","fade",500)
end


--------------------------------------------------------------------------------
-- "scene:create()"
--------------------------------------------------------------------------------
function scene:create( event )
  local sceneGroup = self.view
  -- Initialize the scene here.
  -- Example: add display objects to "sceneGroup", add touch listeners, etc.
  background = display.newImageRect("images/menus/settings_frame.jpg",1080,1920)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  sceneGroup:insert(background)


  close = display.newImageRect("images/menus/close.png",70,70)
  close.x, close.y = 950, 130
  sceneGroup:insert(close)

  settingsText = display.newText("Settings", 150, 80, "font/EnchantedLand.otf", 120 )
  settingsText.anchorX = 0
  settingsText.anchorY = 0
  settingsText.x,settingsText.y = 400,120
  settingsText:setFillColor(1,1,1)
  sceneGroup:insert(settingsText)

  volumeText = display.newText("Volume", 150, 80, "font/EnchantedLand.otf", 100 )
  volumeText.anchorX = 0
  volumeText.anchorY = 0
  volumeText.x,volumeText.y = 430,355
  volumeText:setFillColor(1,1,1)
  sceneGroup:insert(volumeText)


  musicText = display.newText("Music", 150, 80, "font/EnchantedLand.otf", 80 )
  musicText:setFillColor(1,1,1)
  musicText.anchorX = 0
  musicText.anchorY = 0
  musicText.x, musicText.y = 185, 520
  sceneGroup:insert(musicText)

  sfxText = display.newText("Sfx", 150, 80, "font/EnchantedLand.otf", 80 )
  sfxText:setFillColor(1,1,1)
  sfxText.anchorX = 0
  sfxText.anchorY = 0
  sfxText.x, sfxText.y = 185, 700
  sceneGroup:insert(sfxText)

  gameOptionsText = display.newText("Game Options", 150, 80, "font/EnchantedLand.otf", 80 )
  gameOptionsText:setFillColor(1,1,1)
  gameOptionsText.anchorX = 0
  gameOptionsText.anchorY = 0
  gameOptionsText.x, gameOptionsText.y = 400, 950
  sceneGroup:insert(gameOptionsText)

  resetGameText = display.newText("Reset Game", 150, 80, "font/EnchantedLand.otf", 80 )
  resetGameText:setFillColor(1,1,1)
  resetGameText.anchorX = 0
  resetGameText.anchorY = 0
  resetGameText.x, resetGameText.y = 185, 1100
  sceneGroup:insert(resetGameText)

  exitGameText = display.newText("Exit Game", 150, 80, "font/EnchantedLand.otf", 80 )
  exitGameText:setFillColor(1,1,1)
  exitGameText.anchorX = 0
  exitGameText.anchorY = 0
  exitGameText.x, exitGameText.y = 185, 1250
  sceneGroup:insert(exitGameText)

  helpGameText = display.newText("Help", 150, 80, "font/EnchantedLand.otf", 80 )
  helpGameText:setFillColor(1,1,1)
  helpGameText.anchorX = 0
  helpGameText.anchorY = 0
  helpGameText.x, helpGameText.y = 185, 1400
  sceneGroup:insert(helpGameText)

  
     

 
  -- Image sheet options and declaration
  -- For testing, you may copy/save the image under "Visual Customization" above
  local options = {
      frames = {
          { x=0, y=0, width=36, height=64 },
          { x=40, y=0, width=36, height=64 },
          { x=80, y=0, width=36, height=64 },
          { x=124, y=0, width=36, height=64 },
          { x=168, y=0, width=64, height=64 }
      },
      sheetContentWidth = 232,
      sheetContentHeight = 64
  }
  local sliderSheet = graphics.newImageSheet( "images/menus/widget-slider.png", options )
   
  -- Create the widget
  sliderMusic = widget.newSlider(
      {
          sheet = sliderSheet,
          leftFrame = 0,
          middleFrame = 2,
          rightFrame = 3,
          fillFrame = 4,
          frameWidth = 36,
          frameHeight = 64,
          handleFrame = 5,
          handleWidth = 64,
          handleHeight = 64,
          x = display.contentCenterX,
          y = 661,
          value = userData.soundvol,
          orientation = "horizontal",
          width = 700,
          listener = sliderListenerMusic
      }
  )
  sceneGroup:insert(sliderMusic)

  sliderSfx = widget.newSlider(
      {
          sheet = sliderSheet,
          leftFrame = 1,
          middleFrame = 2,
          rightFrame = 3,
          fillFrame = 4,
          frameWidth = 36,
          frameHeight = 64,
          handleFrame = 5,
          handleWidth = 64,
          handleHeight = 64,
          x = display.contentCenterX,
          y = 830,
          value = userData.sfxvol,
          orientation = "horizontal",
          width = 700,
          listener = sliderListenerSFX
      }
  )
  sceneGroup:insert(sliderSfx)



  -- event listener
  close:addEventListener("tap",backPrevFrame)
  resetGameText:addEventListener("tap",resetGame)
  exitGameText:addEventListener("tap", exitGame)
  helpGameText:addEventListener("tap",helpGame)

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