-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Melody Berhane
-- Date: Nov 05, 2019
-- Description: This is the splash screen of the game. It displays the 
-- company logo that appears on the screen, then gets bigger and starts to rotate and fade in while growing smaller.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local CompanyLogo
local CompanyLogo2
local scrollXSpeed = 4
local backgroundSounds = audio.loadSound("Sounds/backgroundSound.mp3")
local backgroundSoundsChannel
local bkg

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- This function shows the companylogo2 
local function showCompanyLogo2()
    bkg.isVisible = true
    CompanyLogo2.isVisible = true
end

-- This function hides the companylogo
local function hideCompanyLogo()
    CompanyLogo.alpha = 0
    CompanyLogo.isVisible = false
end

-- This function rotates the companylogo2
local function RotateCompanyLogo2(event) 
    -- rotates the CompanyLogo2  
    CompanyLogo2:rotate(5)
end

local function FadeOutCompanyLogo2(event) 
    -- change the transparency of the companylogo2 so that it fades out
    CompanyLogo2.alpha = CompanyLogo2.alpha - 0.001
    CompanyLogo2.xScale = CompanyLogo2.xScale - 0.004
    CompanyLogo2.yScale = CompanyLogo2.yScale - 0.004
end

local function MainMenu()
    composer.gotoScene("mainmenu")
end

-- Function: moveCompanyLogo
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function calls hideCompanyLogo and showCompanyLogo2 after 1 second. After 2.3 second it calls RotateCompanyLogo2 . 
--After 2.5 seconds it calls FadeOutCompanyLogo2
local function moveCompanyLogo()
    timer.performWithDelay(500, hideCompanyLogo)
    timer.performWithDelay(500, showCompanyLogo2)
    timer.performWithDelay(500, RotateCompanyLogo2)
    timer.performWithDelay(1000, FadeOutCompanyLogo2)
    
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------

    display.setDefault("background", 105/255, 105/255, 225/255)

    bkg = display.newImageRect("Images/background1.png", display.contentWidth, display.contentHeight)
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight
    bkg.isVisible = false
    



    -- Insert the CompanyLogo image
    CompanyLogo = display.newImageRect("Images/CompanyLogoMelody@2x.png", 530, 530)
    CompanyLogo.isVisible = true

    -- set the initial x and y position of the CompanyLogo
    CompanyLogo.x = display.contentWidth/2--100
    CompanyLogo.y = display.contentHeight/2

    -- Insert the CompanyLogo2 image
    CompanyLogo2 = display.newImageRect("Images/CompanyLogoMelodyAfter@2x.png", 600, 570)
    CompanyLogo2.isVisible = false


    -- set the initial x and y position of the CompanyLogo2
    CompanyLogo2.x = display.contentWidth/2--100
    CompanyLogo2.y = display.contentHeight/2


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( CompanyLogo )
    sceneGroup:insert( CompanyLogo2 )
    sceneGroup:insert( bkg )
    -- Send the background image to the back layer so all other objects can be on top
    bkg:toBack()

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
       backgroundSoundsChannel = audio.play(backgroundSounds)

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveCompanyLogo)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay( 5500, MainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        --stop the jungle sounds channel for this screen
        audio.stop(backgroundSoundsChannel)

    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
   

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
