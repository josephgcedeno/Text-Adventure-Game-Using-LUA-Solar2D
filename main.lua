-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")
local loadsave = require("loadSave") 
local userData = loadsave.loadTable( "userdata.json" )

local backgroundMusic = audio.loadStream( "audio/music.mp3" ) -- Loops the music

audio.play(backgroundMusic, { channel=1, loops=-1 })


audio.setVolume(userData.soundvol/100, { channel=1 } ) -- backgroundMusic

audio.setVolume(userData.sfxvol/100, { channel=2 } ) -- sfx_click

audio.setVolume(userData.sfxvol/100, { channel=3 } ) -- sfx_turn




composer.gotoScene("Scences.menus.title")
