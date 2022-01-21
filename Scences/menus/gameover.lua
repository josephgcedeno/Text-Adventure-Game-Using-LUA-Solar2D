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
local gameoverText
local choice1
local choice2
local choice3

audio.stop( 1 )

local userData = loadSave.loadTable("userdata.json")


local function resetGame( )
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

local function gotoSettings( )
  audio.play(sfx_click)

  composer.gotoScene("Scences.menus.settings","fade",500)
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


  background = display.newImageRect("images/menus/game_over.png", 800,800)
  background.anchorX = 0
  background.anchorY = 0
  background.x, background.y = 150, 250
  sceneGroup:insert(background)

  gameoverText = display.newText("Game over", 150, 80, "font/EnchantedLand.otf", 120 )
  gameoverText.anchorX = 0
  gameoverText.anchorY = 0
  gameoverText.x,gameoverText.y = 370,1180
  gameoverText:setFillColor(1,1,1)
  sceneGroup:insert(gameoverText)

  choice1 = display.newImageRect("images/menus/restart.png",700,100)
  choice1.anchorX = 0
  choice1.anchorY = 0
  choice1.x, choice1.y = 200, 1400
  sceneGroup:insert(choice1)


  choice2 = display.newImageRect("images/menus/settings.png",700,100)
  choice2.anchorX = 0
  choice2.anchorY = 0
  choice2.x, choice2.y = 200, 1520
  sceneGroup:insert(choice2)

  choice3 = display.newImageRect("images/menus/exit.png",700,100)
  choice3.anchorX = 0
  choice3.anchorY = 0
  choice3.x, choice3.y = 200, 1640
  sceneGroup:insert(choice3)

  choice1:addEventListener("tap",resetGame)
  choice2:addEventListener("tap",gotoSettings)
  choice3:addEventListener("tap",exitGame)
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