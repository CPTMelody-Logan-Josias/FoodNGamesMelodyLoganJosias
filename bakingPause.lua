-----------------------------------------------------------------------------------------
--
-- SceneTemplate.lua
-- Scene Template (Composer API)
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Calling Composer Library
local composer = require( "composer" )

local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "bakingPause"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- FORWARD REFERENCES
-----------------------------------------------------------------------------------------
-- insert local variables
local bkg
local mainMenuButton
local instructionsButton
local resumeButton
-----------------------------------------------------------------------------------------

-- Functions for buttons
function InstructionsTransitionPause( )
    local options = {
            isModal = true,
            effect = "fromBottom",
            time = 400
    }
    composer.showOverlay( "instruction_pause", options )  
end 

function ResumeTransitionPause( )
    composer.hideOverlay( "fade", 100 )    
    ResumeGame()
end

function MainMenuTransitionPause( )      
    composer.gotoScene( "mainmenu", {effect = "fromRight", time = 500} )
end

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local parent = event.parent

    -- Insert background
    bkg = display.newImage("Images/Pause Box.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    --bkg_image.width = display.contentWidth
    --bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg )

    -- Send the background image to the back layer so all other objects can be on top
    bkg:toBack()    




    -----------------------------------------------------------------------------------------
    -- WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight/2,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = InstructionsTransitionPause         
        } )

    -- Create Resume button
    resumeButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*1/3,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Unpressed Resume Button.png",
            overFile = "Images/Pressed Resume Button.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = ResumeTransitionPause         
        } )

    -- Creating main menu button
    mainMenuButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*4/6,
            width = 200,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/HomeUnpressedMelody@2x.png",
            overFile = "Images/HomePressedMelody@2x.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = MainMenuTransitionPause         
        } )


    -- Initialize the scene here.
    -- Group the buttons to this scene
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( resumeButton )
    sceneGroup:insert( mainMenuButton )

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Call the ResumeGame function
        

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.    
        --parent:ResumeGame()    
    end

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

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

