-----------------------------------------------------------------------------------------
--
-- levle1_screen.lua
-- Created by: Melody Berhane
-- Date: Nov 14, 2019
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
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
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- Objects used to bake 
local egg
local egg2
local bakingSoda
local sugar
local milk
local flour
local butter
local bowl
local bowlFilled

-- Objects used to bake 
local eggSmall
local egg2Small
local bakingSodaSmall
local sugarSmall
local milkSmall
local flourSmall
local butterSmall

local instructionText
local instruction2Text

-- The background and the mute and unmute buttons
local bkg_image
local MuteButton
local UnmuteButton

-- Keeps track of how many ingredients are in the bowl
local numIngredients = 0

-- This tells use if the ingredients have been touched or not
local eggTouched = false
local egg2Touched = false
local bakingSodaTouched = false
local sugarTouched = false
local milkTouched = false
local flourTouched = false
local butterTouched = false
local bowlFilled = false

--takes the ingredients to there previous locations
local eggPreviousX
local egg2PreviousX
local bakingSodaPreviousX
local sugarPreviousX
local milkPreviousX
local flourPreviousX
local butterPreviousX
local bowlFilledPreviousX

--takes the ingredients to there previous locations
local eggPreviousY
local egg2PreviousY
local bakingSodaPreviousY
local sugarPreviousY
local milkPreviousY
local flourPreviousY
local butterPreviousY
local bowlFilledPreviousY

-- place holders
local BowlPlaceholder
local fire

----------------------------------------------------------------------------------------
--SOUND
----------------------------------------------------------------------------------------
-- level 1 backgroundsound
local level2Sound = audio.loadSound("Sounds/level1Sound.mp3")
local level2SoundChannel4

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------------------------- 

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO BACK SCREEN\

local function MakeIgredientsVisible()
    -- makes all the ingredients visible
    fire.isVisible = true
    milk.isVisible = false
    egg.isVisible = false
    eggSmall.isVisible = false
    egg2Small.isVisible = false
    bakingSodaSmall.isVisible = false
    sugarSmall.isVisible = false
    milkSmall.isVisible = false
    flourSmall.isVisible = false
    butterSmall.isVisible = false
    egg2.isVisible = false
    bowl.isVisible = true
    flour.isVisible = true
    butter.isVisible = false
    sugar.isVisible = true
    bakingSoda.isVisible = true
    bowlFilled.isVisible = false
end

local function MakeDryIgredientsInvisible()
    -- makes all the ingredients visible
    milk.isVisible = true
    egg.isVisible = true
    egg2.isVisible = true
    flour.isVisible = false
    butter.isVisible = true
    sugar.isVisible = false
    bakingSoda.isVisible = false
    instruction2Text.isVisible = true
    instructionText.isVisible = false

end

local function IngredientsPosition()
    -- puts ingredients in  original position
    egg.x = display.contentWidth * 3 / 10
    egg.y = display.contentHeight * 2 / 4
    eggSmall.x = display.contentWidth * 1.25 / 10
    eggSmall.y = display.contentHeight * 5 / 10
    egg2Small.x = display.contentWidth * 1.35 / 10
    egg2Small.y = display.contentHeight * 5 / 10
    bakingSodaSmall.x = display.contentWidth * 1.25 / 10
    bakingSodaSmall.y = display.contentHeight * 5.25 / 10
    sugarSmall.x = display.contentWidth * 1.15 / 10
    sugarSmall.y = display.contentHeight * 5.5 / 10
    milkSmall.x = display.contentWidth * 1 / 10
    milkSmall.y = display.contentHeight * 5.15 / 10
    flourSmall.x = display.contentWidth * 0.75 / 10
    flourSmall.y = display.contentHeight * 5 / 10
    butterSmall.x = display.contentWidth * 1 / 10
    butterSmall.y = display.contentHeight * 5.5 / 10
    egg2.x = display.contentWidth * 2 / 10
    egg2.y = display.contentHeight * 2 / 4
    butter.x = display.contentWidth * 5 / 10
    butter.y = display.contentHeight * 2 / 4
    sugar.x = display.contentWidth * 2 / 10
    sugar.y = display.contentHeight * 2 / 4
    milk.x = display.contentWidth * 4 / 10
    milk.y = display.contentHeight * 2 / 4
    flour.x = display.contentWidth * 3 / 10
    flour.y = display.contentHeight * 2 / 4
    bakingSoda.x = display.contentWidth * 4 / 10
    bakingSoda.y = display.contentHeight * 2 / 4
    bowlFilled.x = display.contentWidth * 1 / 10
    bowlFilled.y = display.contentHeight * 2 / 4
    bowl.x = display.contentWidth * 1 / 10
    bowl.y = display.contentHeight * 2 / 4

end

local function TouchEgg(touch)
    --only work if none of the other boxes have been touched
    if (egg2Touched == false) and 
        (bakingSodaTouched == false) and
        (sugarTouched == false) and
        (milkTouched == false) and
        (flourTouched == false) and
        (butterTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            eggTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            egg.x = touch.x
            egg.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            eggTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < egg.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > egg.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < egg.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > egg.y ) ) then

                -- setting the position of the number to be in the center of the box
                egg.x = BowlPlaceholder.x
                egg.y = BowlPlaceholder.y

                --makes the egg invisible
                egg.isVisible = false
                eggSmall.isVisible = true

                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1
                print ("***numIngredients = " .. numIngredients)
                
                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.

                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    BowlPlaceholder.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false

                end

                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                egg.x = eggPreviousX 
                egg.y = eggPreviousY

            end
        end
    end                
end 

local function TouchEgg2(touch)
    --only work if none of the other boxes have been touched
    if (eggTouched == false) and 
        (bakingSodaTouched == false) and
        (sugarTouched == false) and
        (milkTouched == false) and
        (flourTouched == false) and
        (butterTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            egg2Touched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            egg2.x = touch.x
            egg2.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            egg2Touched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < egg2.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > egg2.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < egg2.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > egg2.y ) ) then

                -- setting the position of the number to be in the center of the box
                egg2.x = BowlPlaceholder.x
                egg2.y = BowlPlaceholder.y
                --makes the egg2 invisible
                egg2.isVisible = false
                egg2Small.isVisible = true
                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1

                print ("***numIngredients = " .. numIngredients)
                
                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.

                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false
                    BowlPlaceholder.isVisible = false

                end
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                egg2.x = egg2PreviousX 
                egg2.y = egg2PreviousY

            end
        end
    end                
end 

local function TouchFlour(touch)
    --only work if none of the other boxes have been touched
    if (eggTouched == false) and 
        (bakingSodaTouched == false) and
        (sugarTouched == false) and
        (milkTouched == false) and
        (egg2Touched == false) and
        (butterTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            flourTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            flour.x = touch.x
            flour.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            flourTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < flour.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > flour.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < flour.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > flour.y ) ) then

                -- setting the position of the number to be in the center of the box
                flour.x = BowlPlaceholder.x
                flour.y = BowlPlaceholder.y
                --makes the flour invisible
                flour.isVisible = false
                flourSmall.isVisible = true
                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1
                
                print ("***numIngredients = " .. numIngredients)

                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.

                if (numIngredients == 3)  then
                    MakeDryIgredientsInvisible()
                end

                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false
                    BowlPlaceholder.isVisible = false

                end
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                flour.x = flourPreviousX
                flour.y = flourPreviousY

            end
        end
    end                
end 

local function TouchMilk(touch)
    --only work if none of the other boxes have been touched
    if (eggTouched == false) and 
        (bakingSodaTouched == false) and
        (sugarTouched == false) and
        (flourTouched == false) and
        (egg2Touched == false) and
        (butterTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            milkTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            milk.x = touch.x
            milk.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            milkTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < milk.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > milk.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < milk.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > milk.y ) ) then

                -- setting the position of the number to be in the center of the box
                milk.x = BowlPlaceholder.x
                milk.y = BowlPlaceholder.y
                --makes the milk invisible
                milk.isVisible = false
                milkSmall.isVisible = true
                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1

                print ("***numIngredients = " .. numIngredients)
                
                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.
                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false
                    BowlPlaceholder.isVisible = false

                end
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                milk.x = milkPreviousX
                milk.y = milkPreviousY

            end
        end
    end                
end 

local function TouchButter(touch)
    --only work if none of the other boxes have been touched
    if (eggTouched == false) and 
        (bakingSodaTouched == false) and
        (sugarTouched == false) and
        (flourTouched == false) and
        (egg2Touched == false) and
        (milkTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            butterTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            butter.x = touch.x
            butter.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            butterTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < butter.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > butter.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < butter.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > butter.y ) ) then

                -- setting the position of the number to be in the center of the box
                butter.x = BowlPlaceholder.x
                butter.y = BowlPlaceholder.y
                --makes the butter invisible
                butter.isVisible = false
                butterSmall.isVisible = true
                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1

                print ("***numIngredients = " .. numIngredients)
                
                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.
                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false
                    BowlPlaceholder.isVisible = false

                end
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                butter.x = butterPreviousX
                butter.y = butterPreviousY

            end
        end
    end                
end 

local function TouchSugar(touch)
    --only work if none of the other boxes have been touched
    if (eggTouched == false) and 
        (bakingSodaTouched == false) and
        (butterTouched == false) and
        (flourTouched == false) and
        (egg2Touched == false) and
        (milkTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            sugarTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            sugar.x = touch.x
            sugar.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            sugarTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < sugar.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > sugar.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < sugar.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > sugar.y ) ) then

                -- setting the position of the number to be in the center of the box
                sugar.x = BowlPlaceholder.x
                sugar.y = BowlPlaceholder.y
                --makes the sugar invisible
                sugar.isVisible = false
                sugarSmall.isVisible = true
                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1

                print ("***numIngredients = " .. numIngredients)
                
                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.

                if (numIngredients == 3)  then
                    MakeDryIgredientsInvisible()
                end

                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false
                    BowlPlaceholder.isVisible = false

                end
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                sugar.x = sugarPreviousX
                sugar.y = sugarPreviousY

            end
        end
    end                
end 


local function TouchBakingSoda(touch)
    --only work if none of the other boxes have been touched
    if (eggTouched == false) and 
        (sugarTouched == false) and
        (butterTouched == false) and
        (flourTouched == false) and
        (egg2Touched == false) and
        (milkTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            bakingSodaTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            bakingSoda.x = touch.x
            bakingSoda.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            bakingSodaTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((BowlPlaceholder.x - BowlPlaceholder.width/2) < bakingSoda.x ) and
                ((BowlPlaceholder.x + BowlPlaceholder.width/2) > bakingSoda.x ) and 
                ((BowlPlaceholder.y - BowlPlaceholder.height/2) < bakingSoda.y ) and 
                ((BowlPlaceholder.y + BowlPlaceholder.height/2) > bakingSoda.y ) ) then

                -- setting the position of the number to be in the center of the box
                bakingSoda.x = BowlPlaceholder.x
                bakingSoda.y = BowlPlaceholder.y
                --makes the bakingsoda invisible
                bakingSoda.isVisible = false
                bakingSodaSmall.isVisible = true
                --addes one to the number of ingredients inside the bowl
                numIngredients = numIngredients + 1

                print ("***numIngredients = " .. numIngredients)
                
                -- checks if there are 7 ingredientsin  the bowl, if there are then the following happens;
                --bowlFilled will be visible 
                -- both the bowl and the BowlPlaceholder will be invisible.

                if (numIngredients == 3)  then
                    MakeDryIgredientsInvisible()
                end

                if (numIngredients == 7)  then
                    bowlFilled.isVisible = true
                    bowl.isVisible = false
                    eggSmall.isVisible = false
                    egg2Small.isVisible = false
                    bakingSodaSmall.isVisible = false
                    sugarSmall.isVisible = false
                    milkSmall.isVisible = false
                    flourSmall.isVisible = false
                    butterSmall.isVisible = false
                    BowlPlaceholder.isVisible = false

                end
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                bakingSoda.x = bakingSodaPreviousX
                bakingSoda.y = bakingSodaPreviousY

            end
        end
    end                
end 


local function TouchBowlFilled(touch)
    --only work if none of the other boxes have been touched
    if (numIngredients == 7) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            bowlFilledTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            bowlFilled.x = touch.x
            bowlFilled.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            bakingSodaTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((fire.x - fire.width/2) < bowlFilled.x ) and
                ((fire.x + fire.width/2) > bowlFilled.x ) and 
                ((fire.y - fire.height/2) < bowlFilled.y ) and 
                ((fire.y + fire.height/2) > bowlFilled.y ) ) then

                -- setting the position of the number to be in the center of the box
                bowlFilled.x = fire.x
                bowlFilled.y = fire.y
                composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})
                bowlFilled.isVisible = false
                
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                bowlFilled.x = bowlFilledPreviousX
                bowlFilled.y = bowlFilledPreviousY

            end
        end
    end                
end 

local function LoseScreenTransition( )        
    composer.gotoScene( "youLose", {effect = "zoomInOutFade", time = 1000})
end 

-- Function that transitions to Lose Screen
local function WinScreenTransition( )        
    composer.gotoScene( "youWin", {effect = "zoomInOutFade", time = 1000})
end 


-- making the music to pause when the mute button is clicked
local function MuteListener(touch)
    if (touch.phase == "ended") then
        UnmuteButton.isVisible = true
        MuteButton.isVisible = false
        soundOn = false
        -- Play the correct soud on any available channel
        audio.pause( level2SoundChannel4 )
    end
end

-- making the music to play when the unmute button is clicked
local function UnmuteListener(touch)
    if (touch.phase == "ended") then
        UnmuteButton.isVisible = false
        MuteButton.isVisible = true
        soundOn = true
        -- Play the correct soud on any available channel
        audio.resume( level2SoundChannel4)
    end
end 


local function AddAnswerBoxEventListeners()
    egg:addEventListener("touch", TouchEgg)
    egg2:addEventListener("touch", TouchEgg2)
    flour:addEventListener("touch", TouchFlour)
    milk:addEventListener("touch", TouchMilk)
    butter:addEventListener("touch", TouchButter)
    sugar:addEventListener("touch", TouchSugar)
    bakingSoda:addEventListener("touch", TouchBakingSoda)
    bowlFilled:addEventListener("touch", TouchBowlFilled)
    
end 



local function RemoveAnswerBoxEventListeners()
    egg:removeEventListener("touch", TouchEgg)
    egg2:removeEventListener("touch", TouchEgg2)
    flour:removeEventListener("touch", TouchFlour)
    milk:removeEventListener("touch", TouchMilk)
    butter:removeEventListener("touch", TouchButter)
    sugar:removeEventListener("touch", TouchSugar)
    bakingSoda:removeEventListener("touch", TouchBakingSoda)
    bowlFilled:removeEventListener("touch", TouchBowlFilled)

end 

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel2Win()
    timer.performWithDelay( 1000, WinScreenTransition )
end

function ResumeLevel2Lose()
    timer.performWithDelay( 1000, LoseScreenTransition )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------


    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/Level2ScreenMelody@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- create the question text object
    instructionText = display.newText("Put all the dry ingredients.", display.contentCenterX, display.contentCenterY*3/8, Arial, 50)
    sceneGroup:insert( instructionText )
    instructionText.isVisible = true

    -- create the question text object
    instruction2Text = display.newText("Now the other ingredients.", display.contentCenterX, display.contentCenterY*3/8, Arial, 50)
    sceneGroup:insert( instruction2Text )
    instruction2Text.isVisible = false



    -- Insert the platforms
    fire = display.newImageRect("Images/fire.png", 300, 200)
    fire.x = display.contentWidth *  7.75 / 10
    fire.y = display.contentHeight * 8.5 / 10
    fire.isVisible = true
        
    sceneGroup:insert( fire )

    -- Insert the platforms
    bowl = display.newImageRect("Images/BowlMelody@2x.png", 150, 150)
    bowl.x = display.contentWidth * 1 / 10
    bowl.y = display.contentHeight * 2 / 4
    bowl.isVisible = true
        
    sceneGroup:insert( bowl )
    

    BowlPlaceholder = display.newImageRect("Images/BowlMelody@2x.png", 150, 150)
    BowlPlaceholder.x = display.contentWidth * 1 / 10
    BowlPlaceholder.y = display.contentHeight * 2 / 4
    BowlPlaceholder.isVisible = false
   
    sceneGroup:insert(BowlPlaceholder)

    -- Insert the platforms
    bowlFilled = display.newImageRect("Images/BowlFilledMelody@2x.png", 150, 150)
    bowlFilled.x = display.contentWidth * 1 / 10
    bowlFilled.y = display.contentHeight * 2 / 4
    bowlFilledPreviousX = bowlFilled.x  
    bowlFilledPreviousY = bowlFilled.y
    bowlFilled.isVisible = false
        
    sceneGroup:insert( bowlFilled )

    -- Insert the platforms
    egg = display.newImageRect("Images/EggMelody@2x.png", 100, 100)
    egg.x = display.contentWidth * 3 / 10
    egg.y = display.contentHeight * 2 / 4
    eggPreviousX = egg.x  
    eggPreviousY = egg.y
    egg.isVisible = true
        
    sceneGroup:insert( egg )

    -- Insert the platforms
    eggSmall = display.newImageRect("Images/EggMelody@2x.png", 100, 100)
    eggSmall.x = display.contentWidth * 1.25 / 10
    eggSmall.y = display.contentHeight * 5 / 10
    eggSmall.isVisible = false
    eggSmall:scale(0.5,0.5)
        
    sceneGroup:insert( eggSmall )

    -- Insert the platforms
    egg2 = display.newImageRect("Images/EggMelody@2x.png", 100, 100)
    egg2.x = display.contentWidth * 2 / 10
    egg2.y = display.contentHeight * 2 / 4
    egg2PreviousX = egg2.x  
    egg2PreviousY = egg2.y
    egg2.isVisible = true
        
    sceneGroup:insert( egg2 )

    -- Insert the platforms
    egg2Small = display.newImageRect("Images/EggMelody@2x.png", 100, 100)
    egg2Small.x = display.contentWidth * 1.35 / 10
    egg2Small.y = display.contentHeight * 5 / 10
    egg2Small.isVisible = false
    egg2Small:scale(0.5,0.5)
        
    sceneGroup:insert( egg2Small )

    -- Insert the platforms
    butter= display.newImageRect("Images/ButterMelody@2x.png", 100, 100)
    butter.x = display.contentWidth * 5 / 10
    butter.y = display.contentHeight * 2 / 4
    butterPreviousX = butter.x  
    butterPreviousY = butter.y
    butter.isVisible = true
        
    sceneGroup:insert( butter )

    -- Insert the platforms
    butterSmall = display.newImageRect("Images/ButterMelody@2x.png", 100, 100)
    butterSmall.x = display.contentWidth * 1 / 10
    butterSmall.y = display.contentHeight * 5.5 / 10
    butterSmall.isVisible = true
    butterSmall:scale(0.5,0.5)
        
    sceneGroup:insert( butterSmall )

    -- Insert the platforms
    sugar = display.newImageRect("Images/SugarMelody@2x.png", 100, 100)
    sugar.x = display.contentWidth * 2 / 10
    sugar.y = display.contentHeight * 2 / 4
    sugarPreviousX = sugar.x  
    sugarPreviousY = sugar.y
    sugar.isVisible = true
        
    sceneGroup:insert( sugar)

    -- Insert the platforms
    sugarSmall = display.newImageRect("Images/SugarMelody@2x.png", 100, 100)
    sugarSmall.x = display.contentWidth * 1.15 / 10
    sugarSmall.y = display.contentHeight * 5.5 / 10
    sugarSmall.isVisible = false
    sugarSmall:scale(0.5,0.5)
        
    sceneGroup:insert( sugarSmall)

    -- Insert the platforms
    milk = display.newImageRect("Images/MilkMelody@2x.png", 100, 100)
    milk.x = display.contentWidth * 4 / 10
    milk.y = display.contentHeight * 2 / 4
    milkPreviousX = milk.x  
    milkPreviousY = milk.y
    milk.isVisible = true
        
    sceneGroup:insert( milk )

    -- Insert the platforms
    milkSmall = display.newImageRect("Images/MilkMelody@2x.png", 100, 100)
    milkSmall.x = display.contentWidth * 1 / 10
    milkSmall.y = display.contentHeight * 5.15 / 10
    milkSmall.isVisible = false
    milkSmall:scale(0.5,0.5)
        
    sceneGroup:insert( milkSmall )

    -- Insert the platforms
    flour = display.newImageRect("Images/FlourMelody@2x.png", 100, 100)
    flour.x = display.contentWidth * 3 / 10
    flour.y = display.contentHeight * 2 / 4
    flourPreviousX = flour.x  
    flourPreviousY = flour.y
    flour.isVisible = true
        
    sceneGroup:insert( flour )

    -- Insert the platforms
    flourSmall = display.newImageRect("Images/FlourMelody@2x.png", 100, 100)
    flourSmall.x = display.contentWidth * 0.75 / 10
    flourSmall.y = display.contentHeight * 5 / 10
    flourSmall:scale(0.5,0.5)
    flourSmall.isVisible = false
        
    sceneGroup:insert( flourSmall )


    -- Insert the platforms
    bakingSoda = display.newImageRect("Images/BakingSodaMelody@2x.png", 100, 100)
    bakingSoda.x = display.contentWidth * 4 / 10
    bakingSoda.y = display.contentHeight * 2 / 4
    bakingSodaPreviousX = bakingSoda.x  
    bakingSodaPreviousY = bakingSoda.y
    bakingSoda.isVisible = true

        
    sceneGroup:insert( bakingSoda )

    -- Insert the platforms
    bakingSodaSmall = display.newImageRect("Images/BakingSodaMelody@2x.png", 100, 100)
    bakingSodaSmall.x = display.contentWidth * 1.25 / 10
    bakingSodaSmall.y = display.contentHeight * 5.25 / 10
    bakingSodaSmall.isVisible = false
    bakingSodaSmall:scale(0.5,0.5)

        
    sceneGroup:insert( bakingSodaSmall )

    -- creating the unmute button
    UnmuteButton = display.newImageRect("Images/UnmuteButtonMelody@2x.png", 198, 98)
    UnmuteButton.x = display.contentWidth/2
    UnmuteButton.y = display.contentHeight*1/10
    UnmuteButton.isVisible = false

    sceneGroup:insert( UnmuteButton )

    --creating the mute button
    MuteButton = display.newImageRect("Images/MuteButtonMelody@2x.png", 198, 98)
    MuteButton.x = display.contentWidth/2
    MuteButton.y = display.contentHeight*1/10
    MuteButton.isVisible = true

    sceneGroup:insert( MuteButton )





    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene


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
        -- initialize the ingredients in the bowl
        numIngredients = 0

        if (soundOn == true) then
            MuteButton.isVisible = true
            UnmuteButton.isVisible = false
            level1SoundChannel4 = audio.play( level1Sound, { channel=3, loops = -1} ) 
        else
            UnmuteButton.isVisible = true
            MuteButton.isVisible = false
            level1SoundChannel4 = audio.play( level1Sound, { channel=3, loops = -1} ) 
            audio.pause( levelSoundChannel2 )
        end

        MuteButton:addEventListener("touch", MuteListener) 
        UnmuteButton:addEventListener("touch", UnmuteListener) 
        MakeIgredientsVisible()
        IngredientsPosition()

           
        
        AddAnswerBoxEventListeners()
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
        


    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveAnswerBoxEventListeners()
        MuteButton:removeEventListener("touch", MuteListener)
        UnmuteButton:removeEventListener("touch", UnmuteListener)
        audio.pause( level1SoundChannel4 )
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
