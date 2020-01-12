-----------------------------------------------------------------------------------------
--
-- mainmenu.lua
-- Created by: Melody Berhane
-- Date: Nov 14, 2019
-- Description: This is the main menu, displaying the credits, soccer, back & bake buttons.
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
sceneName = "mainmenu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
soundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local MuteButton
local UnmuteButton
local creditsButton
local instructionsButton
local level3Button
local level4Button
local instructionbakingButton
local level1Button
local level2Button
local extraButton
-----------------------------------------------------------------------------------------
-- LOCAL SOUND
-----------------------------------------------------------------------------------------
local mainmenuSound = audio.loadStream("Sounds/mainmenuSound.mp3")
local mainmenuSoundChannel3

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "flip", time = 500})
end 

-- Creating Transition to instruction Screen
local function Instructions2ScreenTransition( )
    composer.gotoScene( "instruction2_screen", {effect = "slideDown", time = 1000})
end    

-- Creating Transition to play Screen
local function Level3Transition( )
    composer.gotoScene( "level3_screen", {effect = "slideDown", time = 500})
end 

-- Creating Transition to play Screen
local function Level4Transition( )
    composer.gotoScene( "level4_screen", {effect = "slideDown", time = 500})
end 

-- Creating Transition to instruction Screen
local function InstructionsScreenTransition( )
    composer.gotoScene( "instruction_screen", {effect = "slideDown", time = 1000})
end    

-- Creating Transition to play Screen
local function Level1Transition( )
    composer.gotoScene( "level1_screen", {effect = "slideDown", time = 500})
end 

-- Creating Transition to play Screen
local function Level2Transition( )
    composer.gotoScene( "level2_screen", {effect = "slideDown", time = 500})
end 

-- Creating Transition to play Screen
local function ExtraLevelTransition( )
    composer.gotoScene( "level5&6", {effect = "slideDown", time = 500})
end 


-----------------------------------------------------------------------------------------   

-- making the music to pause when the mute button is clicked
local function MuteListener(touch)
    if (touch.phase == "ended") then
        UnmuteButton.isVisible = true
        MuteButton.isVisible = false
        soundOn = false
        print("***Soccer: soundOn is false")
        -- Play the correct soud on any available channel
        audio.pause( mainmenuSoundChannel3 )
    end
end

-- making the music to play when the unmute button is clicked
local function UnmuteListener(touch)
    if (touch.phase == "ended") then
        UnmuteButton.isVisible = false
        MuteButton.isVisible = true
        soundOn = true
        -- Play the correct soud on any available channel
       audio.resume( mainmenuSoundChannel3 )
    end
end 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    --creating the unmute button
    UnmuteButton = display.newImageRect("Images/UnmuteButtonMelody@2x.png", 198, 98)
    UnmuteButton.x = display.contentWidth/2
    UnmuteButton.y = display.contentHeight*3/10
    UnmuteButton.isVisible = false

    -- creating the mute button
    MuteButton = display.newImageRect("Images/MuteButtonMelody@2x.png", 198, 98)
    MuteButton.x = display.contentWidth/2
    MuteButton.y = display.contentHeight*3/10
    MuteButton.isVisible = true

    -----------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenuLogan@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            --Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight/2,
            width = 200,
            height = 100,

            --Insert the images here
            defaultFile = "Images/CreditsButtonUnPressedJosias@2x.png",
            overFile = "Images/CreditsButtonPressedJosias@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 

    -- Creating Credits Button
    extraButton = widget.newButton( 
        {
            --Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/10,
            width = 200,
            height = 100,

            --Insert the images here
            defaultFile = "Images/ExtraLevelsUnpressedLogan.png",
            overFile ="Images/ExtraLevelsPressedLogan.png",



            -- When the button is released, call the Credits transition function
            onRelease = ExtraLevelTransition
        } ) 


     -- Creating instruction Button
    instructionButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/5,
            y = display.contentHeight*8/10,
            width = 200,
            height = 100,

            --Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the instruction screen transition function
            onRelease = Instructions2ScreenTransition          
        } )


    -----------------------------------------------------------------------------------------
    
    -- Creating level 3 Button
    level3Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/5,
            y = display.contentHeight*4/10,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/level3ButtonUnpressedMelody@2x.png",
            overFile = "Images/level3ButtonPressedMelody@2x.png",

            -- When the button is released, call the level1 transition function
           onRelease = Level3Transition
        } ) 

    -- Creating level 4 Button
    level4Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4/5,
            y = display.contentHeight*6/10,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/level4ButtonUnpressedMelody@2x.png",
            overFile = "Images/level4ButtonPressedMelody@2x.png",

            -- When the button is released, call the level1 transition function
           onRelease = Level4Transition
        } ) 

    -- Creating instructions Button
    instructionbakingButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
             x = display.contentWidth*1/5,
            y = display.contentHeight*8/10,
            width = 200,
            height = 100,

            --Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the instructions screen transition function
            onRelease = InstructionsScreenTransition          
        } )

    -----------------------------------------------------------------------------------------
    
     -- Creating Play Button
    level1Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/5,
            y = display.contentHeight*4/10,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/level1ButtonUnpressedMelody@2x.png",
            overFile = "Images/level1ButtonPressedMelody@2x.png",

            -- When the button is released, call the level1 transition function
           onRelease = Level1Transition
        } ) 

    -- Creating Play Button
    level2Button = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1/5,
            y = display.contentHeight*6/10,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/level2ButtonUnpressedMelody@2x.png",
            overFile = "Images/level2ButtonPressedMelody@2x.png",

            -- When the button is released, call the level1 transition function
           onRelease = Level2Transition
        } ) 

    

    ----------------------------------------------------------------------------------------


    -- Associating button widgets with this scene
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( MuteButton )
    sceneGroup:insert( UnmuteButton )
    sceneGroup:insert( level3Button )
    sceneGroup:insert( level4Button )
    sceneGroup:insert( instructionButton )
    sceneGroup:insert( level1Button )
    sceneGroup:insert( level2Button )
    sceneGroup:insert( instructionbakingButton )
    sceneGroup:insert( extraButton)
   
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
            mainmenuSoundChannel3 = audio.play( mainmenuSound, { channel=1, loops = -1} )
        else
            UnmuteButton.isVisible = true
            MuteButton.isVisible = false
            audio.pause( mainmenuSoundChannel3 ) 
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
        audio.stop( mainmenuSoundChannel3 ) 

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
----------------------------------------------------------------------------------------
return scene
