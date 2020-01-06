-----------------------------------------------------------------------------------------
--
-- youWin.lua
-- Created by: Melody Berhane
-- Date: Nov. 25th, 2019
-- Description: This is the you win screen
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
sceneName = "youWin"

-- Creating Scene Object
local scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local instructionText

local homeButton
local bkg_image
local bottomLeft
local bottomMiddle1
local bottomMiddle2
local bottomRight
local middleleft
local middleMiddle
local middleRight
local topLeft
local topRight

local bottomLeftTouched = false
local bottomMiddle1Touched = false
local bottomMiddle2Touched = false
local bottomRightTouched = false
local middleleftTouched = false
local middleMiddleTouched = false
local middleRightTouched = false
local topLeftTouched = false
local topRightTouched = false

------------------------------------------------------------------------------------------
-- LOCAL SOUND
------------------------------------------------------------------------------------------
local Win = audio.loadSound("Sounds/youWinSound.mp3")
local WinChannel


----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
----------------------------------------------------------------------------------------
-- Creating Transition to play Screen
local function HomeTransition( )
    composer.gotoScene( "mainmenu", {effect = "slideDown", time = 500})
end 

local function MakeCakeVisible()
    -- makes all the ingredients visible
    bottomLeft.isVisible = true
    bottomMiddle1.isVisible = true
    bottomMiddle2.isVisible = true
    bottomRight.isVisible = true
    middleleft.isVisible = true
    middleMiddle.isVisible = true
    middleRight.isVisible = true
    topLeft.isVisible = true
    topRight.isVisible = true
end

local function CakePosition()
    topLeft.x = display.contentWidth * 4.20 / 10
    topLeft.y = display.contentHeight * 7 / 10
    topRight.x = display.contentWidth * 4.25 / 10
    topRight.y = display.contentHeight * 7 / 10
    middleleft.x = display.contentWidth * 4.6 / 10
    middleleft.y = display.contentHeight * 8 / 10
    middleMiddle.x = display.contentWidth * 4 / 10
    middleMiddle.y = display.contentHeight * 8 / 10
    middleRight.x = display.contentWidth * 3.85 / 10
    middleRight.y = display.contentHeight * 8 / 10
    bottomLeft.x = display.contentWidth *  5 / 10
    bottomLeft.y = display.contentHeight * 9 / 10
    bottomMiddle1.x = display.contentWidth * 4 / 10
    bottomMiddle1.y = display.contentHeight * 9 / 10
    bottomMiddle2.x = display.contentWidth * 4.5 / 10
    bottomMiddle2.y = display.contentHeight * 9 / 10
    bottomRight.x = display.contentWidth * 3.5 / 10
    bottomRight.y = display.contentHeight * 9 / 10
end

local function BottomLeftTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomMiddle1Touched == false) and 
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (middleMiddleTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleRightTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            bottomLeftTouched = true
            bottomLeft.isVisible = false
            bottomLeftTouched = false
        end
    end
end

local function BottomMiddle1Touched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (middleMiddleTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleRightTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            bottomMiddle1Touched = true
            bottomMiddle1.isVisible = false
            bottomMiddle1Touched = false
        end
    end
end

local function BottomMiddle2Touched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (middleMiddleTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleRightTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            bottomMiddle2Touched = true
            bottomMiddle2.isVisible = false
            bottomMiddle2Touched = false
        end
    end
end

local function BottomRightTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomMiddle2Touched == false) and
        (middleleftTouched == false) and
        (middleMiddleTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleRightTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            bottomRightTouched = true
            bottomRight.isVisible = false
            bottomRightTouched = false
        end
    end
end

local function MiddleLeftTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleMiddleTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleRightTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            middleleftTouched = true
            middleleft.isVisible = false
            middleleftTouched = false
        end
    end
end

local function MiddleMiddleTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleRightTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            middleMiddleTouched = true
            middleMiddle.isVisible = false
            middleMiddleTouched = false
        end
    end
end

local function MiddleRightTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (topLeftTouched == false) and
        (topRightTouched == false) and
        (middleMiddleTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            middleRightTouched = true
            middleRight.isVisible = false
            middleRightTouched = false
        end
    end
end

local function TopLeftTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (middleRightTouched == false) and
        (topRightTouched == false) and
        (middleMiddleTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            topLeftTouched = true
            topLeft.isVisible = false
            topLeftTouched = false
        end
    end
end

local function TopRightTouched(touch)
    --only work if none of the other boxes have been touched
    if (bottomLeftTouched == false) and 
        (bottomMiddle1Touched == false) and
        (bottomMiddle2Touched == false) and
        (bottomRightTouched == false) and
        (middleleftTouched == false) and
        (middleRightTouched == false) and
        (topLeftTouched == false) and
        (middleMiddleTouched == false) then

        -- this occurs when they release the mouse
        if (touch.phase == "ended") then
            topRightTouched = true
            topRight.isVisible = false
            topRightTouched = false
        end
    end
end


--adding the event listeners 
local function AddTextListeners ( )
    bottomMiddle1:addEventListener( "touch", BottomMiddle1Touched )
    bottomLeft:addEventListener( "touch", BottomLeftTouched)
    bottomMiddle2:addEventListener( "touch", BottomMiddle2Touched )
    bottomRight:addEventListener( "touch", BottomRightTouched )
    middleleft:addEventListener( "touch", MiddleLeftTouched )
    middleMiddle:addEventListener( "touch", MiddleMiddleTouched )
    middleRight:addEventListener( "touch", MiddleRightTouched )
    topLeft:addEventListener( "touch", TopLeftTouched )
    topRight:addEventListener( "touch", TopRightTouched )
end

--removing the event listeners
local function RemoveTextListeners()
    bottomMiddle1:removeEventListener( "touch", BottomMiddle1Touched )
    bottomLeft:removeEventListener( "touch", BottomLeftTouched)
    bottomMiddle2:removeEventListener( "touch", BottomMiddle2Touched )
    bottomRight:removeEventListener( "touch", BottomRightTouched )
    middleleft:removeEventListener( "touch", MiddleLeftTouched )
    middleMiddle:removeEventListener( "touch", MiddleMiddleTouched )
    middleRight:removeEventListener( "touch", MiddleRightTouched )
    topLeft:removeEventListener( "touch", TopLeftTouched )
    topRight:removeEventListener( "touch", TopRightTouched )
end


-----------------------------------------------------------------------------------------
-- DISPLAY OBJECTS
-----------------------------------------------------------------------------------------


-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/YouWinScreenBakingLogan.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- create the question text object
    instructionText = display.newText("Start eating from\nthe top please.", display.contentWidth*3/4, display.contentHeight*8/10, Arial, 50)
    instructionText:setFillColor(0,0,0)
    sceneGroup:insert( instructionText )

    
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Credits Button
    homeButton = widget.newButton( 
        {
            --Set its position on the screen relative to the screen size
            x = display.contentWidth*1/8,
            y = display.contentHeight*7/8,
            width = 200,
            height = 100,

            --Insert the images here
            defaultFile = "Images/HomeUnpressedMelody@2x.png",
            overFile = "Images/HomePressedMelody@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = HomeTransition
        } ) 

    sceneGroup:insert( homeButton )

     -- Insert the platforms
    topLeft = display.newImageRect("Images/CakeTopLeft.png", 100, 100)
    topLeft.x = display.contentWidth * 4.20 / 10
    topLeft.y = display.contentHeight * 7 / 10
    topLeft.isVisible = true
        
    sceneGroup:insert( topLeft)

    -- Insert the platforms
    topRight = display.newImageRect("Images/CakeTopRight.png", 100, 100)
    topRight.x = display.contentWidth * 4.25 / 10
    topRight.y = display.contentHeight * 7 / 10
    topRight.isVisible = true
        
    sceneGroup:insert( topRight )

    -- Insert the platforms
    middleleft = display.newImageRect("Images/CakeMiddleLeft.png", 100, 100)
    middleleft.x = display.contentWidth * 4.6 / 10
    middleleft.y = display.contentHeight * 8 / 10
    middleleft.isVisible = true
        
    sceneGroup:insert( middleleft )

    -- Insert the platforms
    middleMiddle = display.newImageRect("Images/CakeMiddleMiddle.png", 100, 100)
    middleMiddle.x = display.contentWidth * 4 / 10
    middleMiddle.y = display.contentHeight * 8 / 10
    middleMiddle.isVisible = true
        
    sceneGroup:insert( middleMiddle )

    -- Insert the platforms
    middleRight= display.newImageRect("Images/CakeMiddleRight.png", 100, 100)
    middleRight.x = display.contentWidth * 3.85 / 10
    middleRight.y = display.contentHeight * 8 / 10
    middleRight.isVisible = true
        
    sceneGroup:insert( middleRight )


    -- Insert the platforms
    bottomLeft = display.newImageRect("Images/CakeBottomLeft.png", 100, 100)
    bottomLeft.x = display.contentWidth *  5 / 10
    bottomLeft.y = display.contentHeight * 9 / 10
    bottomLeft.isVisible = true
        
    sceneGroup:insert( bottomLeft )

    -- Insert the platforms
    bottomMiddle1 = display.newImageRect("Images/CakeBottomMiddle1.png", 100, 100)
    bottomMiddle1.x = display.contentWidth * 4 / 10
    bottomMiddle1.y = display.contentHeight * 9 / 10
    bottomMiddle1.isVisible = true
        
    sceneGroup:insert( bottomMiddle1 )
    

    bottomMiddle2 = display.newImageRect("Images/CakeBottomMiddle2.png", 100, 100)
    bottomMiddle2.x = display.contentWidth * 4.5 / 10
    bottomMiddle2.y = display.contentHeight * 9 / 10
    bottomMiddle2.isVisible = true
   
    sceneGroup:insert(bottomMiddle2)

    -- Insert the platforms
    bottomRight = display.newImageRect("Images/CakeBottomRight.png", 100, 100)
    bottomRight.x = display.contentWidth * 3.5 / 10
    bottomRight.y = display.contentHeight * 9 / 10
    bottomRight.isVisible = true
        
    sceneGroup:insert( bottomRight )

   
   

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
        -- Called when the scene is still off screen (but is about to come on screen).
        

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc
        WinChannel = audio.play( Win )
        AddTextListeners ( )
        MakeCakeVisible()
        CakePosition()

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
        --gameOverChannel = audio.stop( win )

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        audio.stop( WinChannel )
        RemoveTextListeners()
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

end --function scene:destroy( event )

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