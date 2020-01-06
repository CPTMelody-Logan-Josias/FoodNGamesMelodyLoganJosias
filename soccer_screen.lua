-----------------------------------------------------------------------------------------
--
-- soccer_screen.lua
-- Created by: Melody Berhane
-- Date: Nov 14, 2019
-- Description: This is the soccer_screen, displaying the back, mute, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "soccer_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local instructionsButton
local level3Button
local level4Button
local MuteButton
local UnmuteButton

-----------------------------------------------------------------------------------------
-- LOCAL SOUND
-----------------------------------------------------------------------------------------
local soccerSound = audio.loadSound("Sounds/soccerSound.mp3")
local soccerSoundChannel2

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------------------------- 

-----------------------------------------------------------------------------------------

-- Creating Transition to instruction Screen
local function InstructionsScreenTransition( )
    composer.gotoScene( "instruction2_screen", {effect = "slideDown", time = 1000})
end    

-- Creating Transition to play Screen
local function Level3Transition( )
    composer.gotoScene( "Level3_screen", {effect = "slideDown", time = 500})
end 

-- Creating Transition to play Screen
local function Level4Transition( )
    composer.gotoScene( "Level4_screen", {effect = "slideDown", time = 500})
end 

-- Creating Transition to mainmenu Screen
local function BackTransition( )
    composer.gotoScene( "mainmenu", {effect = "slideDown", time = 500})
end 

-- making the music to pause when the mute button is clicked
local function MuteListener(touch)
    if (touch.phase == "ended") then
        UnmuteButton.isVisible = true
        MuteButton.isVisible = false
        soundOn = false
        print("***Soccer: soundOn is false")
        -- Play the correct soud on any available channel
        audio.pause( soccerSoundChannel2 )
    end
end

-- making the music to play when the unmute button is clicked
local function UnmuteListener(touch)
    if (touch.phase == "ended") then
        UnmuteButton.isVisible = false
        MuteButton.isVisible = true
        soundOn = true
        print("***Soccer: soundOn is true")
        -- Play the correct soud on any available channel
        audio.resume( soccerSoundChannel2)
    end
end 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    display.setDefault("background", 95/255, 15/255, 135/255)

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- creating the unmute button
    UnmuteButton = display.newImageRect("Images/UnmuteButtonMelody@2x.png", 198, 98)
    UnmuteButton.x = display.contentWidth/2
    UnmuteButton.y = display.contentHeight*1/10
    UnmuteButton.isVisible = false

    --creating the mute button
    MuteButton = display.newImageRect("Images/MuteButtonMelody@2x.png", 198, 98)
    MuteButton.x = display.contentWidth/2
    MuteButton.y = display.contentHeight*1/10
    MuteButton.isVisible = true

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

     -- Creating instruction Button
    instructionButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/5,
            y = display.contentHeight/2,
            width = 200,
            height = 100,

            --Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the instruction screen transition function
            onRelease = InstructionsScreenTransition          
        } )


    -----------------------------------------------------------------------------------------
    
    -- Creating Play Button
    level3Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight/2,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/level3ButtonUnpressedMelody@2x.png",
            overFile = "Images/level3ButtonpressedMelody@2x.png",

            -- When the button is released, call the level1 transition function
           onRelease = Level3Transition
        } ) 

    -- Creating Play Button
    level4Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight* 3/4,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/level4ButtonUnpressedMelody@2x.png",
            overFile = "Images/level4ButtonpressedMelody@2x.png",

            -- When the button is released, call the level1 transition function
           onRelease = Level4Transition
        } ) 

    -- Creating back Button
    backButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/8,
            y = display.contentHeight/2,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/BackbuttonUnpressedJosias@2x.png",
            overFile = "Images/BackButtonPressedJosias@2x.png",

            -- When the button is released, call the back transition function
           onRelease = BackTransition
        } )



    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( level3Button )
    sceneGroup:insert( level4Button )
    sceneGroup:insert( instructionButton )
    sceneGroup:insert( MuteButton )
    sceneGroup:insert( UnmuteButton )
    sceneGroup:insert( backButton )
   
    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then 
        if (soundOn == true) then
            MuteButton.isVisible = true
            UnmuteButton.isVisible = false
            soccerSoundChannel2 = audio.play( soccerSound, { channel=3, loops = -1} ) 
        else
            UnmuteButton.isVisible = true
            MuteButton.isVisible = false
            soccerSoundChannel2 = audio.play( soccerSound, { channel=3, loops = -1} ) 
            audio.pause( soccerSoundChannel2 )
        end
        MuteButton:addEventListener("touch", MuteListener) 
        UnmuteButton:addEventListener("touch", UnmuteListener)     
        

    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        audio.stop( soccerSoundChannel2 )
        
    

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        MuteButton:removeEventListener("touch", MuteListener)
        UnmuteButton:removeEventListener("touch", UnmuteListener)

    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
