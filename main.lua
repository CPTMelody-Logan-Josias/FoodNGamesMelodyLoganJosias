-----------------------------------------------------------------------------------------
--
-- main.lua
-- Created by: Melody Berhane
-- Date: Nov. 22nd, 2014
-- Description: This calls the splash screen of the app to load itself.
-----------------------------------------------------------------------------------------

-- Hiding Status Bar
display.setStatusBar( display.HiddenStatusBar )

-----------------------------------------------------------------------------------------

-- Use composer library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Go to the intro screen
composer.gotoScene(  "splash_screen" )