
-- level1_question.lua
-- Created by: Melody Berhane
-- Date: December 5, 2019
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local randomQuestion

local questionText
local correctObject
local inCorrectObject


local letter1
local letter2
local letter3
local letter4

local correctLetter1 
local correctLetter2 
local correctLetter3 
local correctLetter4

local userLetter1
local userLetter2
local userLetter3
local userLetter4

local numLettersCompleted = 0
local points = 0
local lives = 3
local livesText
local pointsText
local totalSeconds = 10
local secondsLeft = 10


local letter1Touched = false
local letter2Touched = false
local letter3Touched = false
local letter4Touched = false

local letter1PreviousX
local letter2PreviousX
local letter3PreviousX
local letter4PreviousX

local letter1PreviousY
local letter2PreviousY
local letter3PreviousY
local letter4PreviousY

local placeholderL1
local placeholderL2
local placeholderL3
local placeholderL4

local placeholderL1Filled = false
local placeholderL2Filled = false
local placeholderL3Filled = false
local placeholderL4Filled = false

local answerPosition = 1
local bkg
local cover

local X1 = display.contentWidth*2/10
local X2 = display.contentWidth*4/10
local X3 = display.contentWidth*6/10
local X4 = display.contentWidth*8/10
local Y1 = display.contentHeight*1/3
local Y2 = display.contentHeight*2/3

local textTouched = false

--------------------------------------------------------------------------------------
-- SOUNDS
--------------------------------------------------------------------------------------
local wrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local wrongSoundChannel
local rightSound = audio.loadSound("Sounds/correctSound.mp3")
local rightSoundChannel

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--making transition to next scene
local function BackToLevel2Win() 
    composer.hideOverlay("crossFade", 400 )
    print ("***Calling ResumeLeve21Win")
  
    ResumeLevel2Win()
end 

local function BackToLevel2Lose() 
    composer.hideOverlay("crossFade", 400 )
    print ("***Calling ResumeLevel2Lose")
    ResumeLevel2Lose()
end 


local function DisplayQuestion()
    --creating random numbers
    randomQuestion = math.random(1,14)

    -- reset the number of letters completed to 0
    numLettersCompleted = 0

    -- reset the placeholders to be unfilled
    placeholderL1Filled = false
    placeholderL2Filled = false
    placeholderL3Filled = false
    placeholderL4Filled = false

    -- display a new random question
    if (randomQuestion == 1) then

        letter1.text = "L"
        letter2.text = "Y"
        letter3.text = "U"
        letter4.text = "J"

        correctLetter1 = letter4
        correctLetter2 = letter3
        correctLetter3 = letter1
        correctLetter4 = letter2

    elseif (randomQuestion == 2) then

        letter1.text = "A"
        letter2.text = "V"
        letter3.text = "Y"
        letter4.text = "N"


        correctLetter1 = letter4
        correctLetter2 = letter1
        correctLetter3 = letter2
        correctLetter4 = letter3

    elseif (randomQuestion == 3) then

        letter1.text = "E"
        letter2.text = "N"
        letter3.text = "A"
        letter4.text = "R"

        correctLetter1 = letter2
        correctLetter2 = letter1
        correctLetter3 = letter3
        correctLetter4 = letter4

    elseif (randomQuestion == 4) then

        letter1.text = "I"
        letter2.text = "N"
        letter3.text = "A"
        letter4.text = "M"

        correctLetter1 = letter4
        correctLetter2 = letter3
        correctLetter3 = letter1  
        correctLetter4 = letter2

    elseif (randomQuestion == 5) then

        letter1.text = "Y"
        letter2.text = "S"
        letter3.text = "A"
        letter4.text = "T"

        correctLetter1 = letter2
        correctLetter2 = letter4
        correctLetter3 = letter3 
        correctLetter4 = letter1

    elseif (randomQuestion == 6) then

        letter1.text = "E"
        letter2.text = "F"
        letter3.text = "A"
        letter4.text = "M"

        correctLetter1 = letter2
        correctLetter2 = letter3
        correctLetter3 = letter4
        correctLetter4 = letter1   

    elseif (randomQuestion == 7) then

        letter1.text = "A"
        letter2.text = "P"
        letter3.text = "N"
        letter4.text = "I"

        correctLetter1 = letter2
        correctLetter2 = letter1
        correctLetter3 = letter4
        correctLetter4 = letter3

    elseif (randomQuestion == 8) then

        letter1.text = "A"
        letter2.text = "M"
        letter3.text = "Y"
        letter4.text = "R"

        correctLetter1 = letter1
        correctLetter2 = letter4
        correctLetter3 = letter2
        correctLetter4 = letter3

    elseif (randomQuestion == 9) then

        letter1.text = "L"
        letter2.text = "U"
        letter3.text = "E"
        letter4.text = "R"

        correctLetter1 = letter4
        correctLetter2 = letter2
        correctLetter3 = letter1
        correctLetter4 = letter3

    elseif (randomQuestion == 10) then

        letter1.text = "Y"
        letter2.text = "U"
        letter3.text = "O"
        letter4.text = "R"


        correctLetter1 = letter1
        correctLetter2 = letter3
        correctLetter3 = letter2
        correctLetter4 = letter4

    elseif (randomQuestion == 11) then

        letter1.text = "M"
        letter2.text = "A"
        letter3.text = "O"
        letter4.text = "F"


        correctLetter1 = letter4
        correctLetter2 = letter3
        correctLetter3 = letter2
        correctLetter4 = letter1

    elseif (randomQuestion == 12) then

        letter1.text = "A"
        letter2.text = "N"
        letter3.text = "E"
        letter4.text = "C"


        correctLetter1 = letter4
        correctLetter2 = letter1
        correctLetter3 = letter2
        correctLetter4 = letter3

    elseif (randomQuestion == 13) then

        letter1.text = "E"
        letter2.text = "N"
        letter3.text = "L"
        letter4.text = "I"


        correctLetter1 = letter3
        correctLetter2 = letter4
        correctLetter3 = letter2
        correctLetter4 = letter1

    elseif (randomQuestion == 14) then

        letter1.text = "L"
        letter2.text = "A"
        letter3.text = "I"
        letter4.text = "N"


        correctLetter1 = letter4
        correctLetter2 = letter2
        correctLetter3 = letter3
        correctLetter4 = letter1

    elseif (randomQuestion == 15) then

        letter1.text = "Y"
        letter2.text = "R"
        letter3.text = "A"
        letter4.text = "E"


        correctLetter1 = letter1
        correctLetter2 = letter4
        correctLetter3 = letter3
        correctLetter4 = letter2

    elseif (randomQuestion == 16) then

        letter1.text = "O"
        letter2.text = "K"
        letter3.text = "J"
        letter4.text = "E"


        correctLetter1 = letter3
        correctLetter2 = letter1
        correctLetter3 = letter2
        correctLetter4 = letter4

    elseif (randomQuestion == 17) then

        letter1.text = "N"
        letter2.text = "G"
        letter3.text = "L"
        letter4.text = "O"


        correctLetter1 = letter3
        correctLetter2 = letter4
        correctLetter3 = letter1
        correctLetter4 = letter2

    elseif (randomQuestion == 18) then

        letter1.text = "E"
        letter2.text = "S"
        letter3.text = "A"
        letter4.text = "L"

        correctLetter1 = letter2
        correctLetter2 = letter1
        correctLetter3 = letter3
        correctLetter4 = letter4

    elseif (randomQuestion == 19) then

        letter1.text = "I"
        letter2.text = "P"
        letter3.text = "K"
        letter4.text = "C"

        correctLetter1 = letter2
        correctLetter2 = letter1
        correctLetter3 = letter4
        correctLetter4 = letter3

    elseif (randomQuestion == 20) then

        letter1.text = "K"
        letter2.text = "A"
        letter3.text = "C"
        letter4.text = "P"

        correctLetter1 = letter4
        correctLetter2 = letter2
        correctLetter3 = letter3
        correctLetter4 = letter1

    end
    
    letter1PreviousX = X1
    letter1PreviousY = Y1
    letter2PreviousX = X2
    letter2PreviousY = Y1
    letter3PreviousX = X3
    letter3PreviousY = Y1
    letter4PreviousX = X4
    letter4PreviousY = Y1

end

local function LetterPosion()
    letter1.x = X1
    letter1.y = Y1
    letter2.x = X2
    letter2.y = Y1
    letter3.x = X3
    letter3.y = Y1
    letter4.x = X4
    letter4.y = Y1

end

local function HideCorrectObject()
    -- body
    correctObject.isVisible = false
    inCorrectObject.isVisible = false
end


local function CheckUserAnswerInput()

    print ("***userLetter1.text = " .. userLetter1.text)
    print ("***userLetter2.text = " .. userLetter2.text)
    print ("***userLetter3.text = " .. userLetter3.text)
    print ("***correctLetter1.text = " .. correctLetter1.text)
    print ("***correctLetter2.text = " .. correctLetter2.text)
    print ("***correctLetter3.text = " .. correctLetter3.text)


    -- compare the text part of the user answer to the correct answer
    if (userLetter1.text == correctLetter1.text) and
        (userLetter2.text == correctLetter2.text) and
        (userLetter3.text == correctLetter3.text) and
        (userLetter4.text == correctLetter4.text) then
        print ("****correct")
        -- They got it right
        points = points + 1
        pointsText.text = "Points = " .. points
        rightSoundChannel = audio.play( rightSound )
        correctObject.isVisible = true
        timer.performWithDelay(700, HideCorrectObject)
        
       
        if (points == 5)then
            BackToLevel2Win()
        else
            -- reset the total seconds
            secondsLeft = totalSeconds 
            -- ask another question
            AskQuestionLevel2()
        end
    
    -- otherwise they did not match up the letters correctly
    else
        -- they got it wrong so lose a life
        lives = lives - 1
        AskQuestionLevel2()
        livesText.text = "lives = " .. lives 
        wrongSoundChannel = audio.play( wrongSound )
        inCorrectObject.isVisible = true
        inCorrectObject.text = ("Sorry, the right answer is "..correctLetter1.text..correctLetter2.text..correctLetter3.text..correctLetter4.text)
        timer.performWithDelay(700, HideCorrectObject)

        if (lives == 0) then
            BackToLevel2Lose()
        else 
            secondsLeft = totalSeconds
            
        end
    end
end

local function UpdateTime()
    -- decrement the number of seconds 
    secondsLeft = secondsLeft - 1

    -- display the number of seconds left in the clock object
    clockText.text = "secondsLeft = " .. secondsLeft

    if(secondsLeft == 0 )then
        --reset the number of seconds left
        secondsLeft = totalSeconds
        lives = lives - 1
        livesText.text = "lives = " .. lives
        audio.play( wrongSoundChannel )
        inCorrectObject.isVisible = true
        timer.performWithDelay(700, HideCorrectObject)
        --update it in the display object
        

        if (lives == 0 ) then
            BackToLevel2Lose()
        end
    end
end

local function StartTimer()
    --create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLetter1(touch)
    print ("***TouchListenerLetter1 was called")
    --only work if none of the other boxes have been touched
   if (letter2Touched == false) and (letter3Touched == false) and (letter4Touched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            letter1Touched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            letter1.x = touch.x
            letter1.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            letter1Touched = false

              -- allow  the letter to be dragged into any place holder 
            if (((placeholderL1.x - placeholderL1.width/2) < letter1.x ) and
                ((placeholderL1.x + placeholderL1.width/2) > letter1.x ) and 
                ((placeholderL1.y - placeholderL1.height/2) < letter1.y ) and 
                ((placeholderL1.y + placeholderL1.height/2) > letter1.y ) and 
                (placeholderL1Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter1.x = placeholderL1.x
                letter1.y = placeholderL1.y

                -- set the first placeholder to be filled
                placeholderL1Filled = true

                -- increment number of letters completed
                numLettersCompleted = numLettersCompleted + 1
                userLetter1 = letter1

                -- remove the event listener so that the user can't move the letter
                letter1:removeEventListener( "touch", TouchListenerLetter1 )
                print ("***TouchListenerLetter1: placeholderL1Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end

            --else make box go back to where it was
            elseif (((placeholderL2.x - placeholderL2.width/2) < letter1.x ) and
                ((placeholderL2.x + placeholderL2.width/2) > letter1.x ) and 
                ((placeholderL2.y - placeholderL2.height/2) < letter1.y ) and 
                ((placeholderL2.y + placeholderL2.height/2) > letter1.y ) and 
                (placeholderL2Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter1.x = placeholderL2.x
                letter1.y = placeholderL2.y

                placeholderL2Filled = true
                
                numLettersCompleted = numLettersCompleted + 1
                
                userLetter2 = letter1
                letter1:removeEventListener( "touch", TouchListenerLetter1 )
                
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end

            --else make box go back to where it was
            elseif (((placeholderL3.x - placeholderL3.width/2) < letter1.x ) and
                ((placeholderL3.x + placeholderL3.width/2) > letter1.x ) and 
                ((placeholderL3.y - placeholderL3.height/2) < letter1.y ) and 
                ((placeholderL3.y + placeholderL3.height/2) > letter1.y ) and 
                (placeholderL3Filled == false) ) then

                -- setting the position of the number to be in the center of the box
                letter1.x = placeholderL3.x
                letter1.y = placeholderL3.y
                placeholderL3Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter3 = letter1
                letter1:removeEventListener( "touch", TouchListenerLetter1 )
                print ("***TouchListenerLetter1: placeholderL3Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end

            --else make box go back to where it was
            elseif (((placeholderL4.x - placeholderL4.width/2) < letter1.x ) and
                ((placeholderL4.x + placeholderL4.width/2) > letter1.x ) and 
                ((placeholderL4.y - placeholderL4.height/2) < letter1.y ) and 
                ((placeholderL4.y + placeholderL4.height/2) > letter1.y ) and 
                (placeholderL4Filled == false) ) then

                -- setting the position of the number to be in the center of the box
                letter1.x = placeholderL4.x
                letter1.y = placeholderL4.y
                placeholderL4Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter4 = letter1
                letter1:removeEventListener( "touch", TouchListenerLetter1 )
                print ("***TouchListenerLetter1: placeholderL3Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end


            --else make box go back to where it was
            else
                letter1.x = letter1PreviousX
                letter1.y = letter1PreviousY
                print ("***Moving letter 1 back to original position")

            end
        end
    end                
 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLetter2(touch)
    print ("***TouchListenerLetter2 was called")
--only work if none of the other boxes have been touched
    if (letter1Touched == false) and (letter3Touched == false) and (letter4Touched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            letter2Touched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            letter2.x = touch.x
            letter2.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            letter2Touched = false

              -- allow  the letter to be dragged into any place holder 
            if (((placeholderL1.x - placeholderL1.width/2) < letter2.x ) and
                ((placeholderL1.x + placeholderL1.width/2) > letter2.x ) and 
                ((placeholderL1.y - placeholderL1.height/2) < letter2.y ) and 
                ((placeholderL1.y + placeholderL1.height/2) > letter2.y ) and 
                (placeholderL1Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter2.x = placeholderL1.x
                letter2.y = placeholderL1.y
                placeholderL1Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter1 = letter2
                letter2:removeEventListener( "touch", TouchListenerLetter2 )
                print ("***TouchListenerLetter2: placeholderL1Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end

            --else make box go back to where it was
            elseif (((placeholderL2.x - placeholderL2.width/2) < letter2.x ) and
                ((placeholderL2.x + placeholderL2.width/2) > letter2.x ) and 
                ((placeholderL2.y - placeholderL2.height/2) < letter2.y ) and 
                ((placeholderL2.y + placeholderL2.height/2) > letter2.y ) and 
                (placeholderL2Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter2.x = placeholderL2.x
                letter2.y = placeholderL2.y
                placeholderL2Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter2 = letter2
                letter2:removeEventListener( "touch", TouchListenerLetter2 )
                print ("***TouchListenerLetter2: placeholderL2Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end

            --else make box go back to where it was
            elseif (((placeholderL3.x - placeholderL3.width/2) < letter2.x ) and
                ((placeholderL3.x + placeholderL3.width/2) > letter2.x ) and 
                ((placeholderL3.y - placeholderL3.height/2) < letter2.y ) and 
                ((placeholderL3.y + placeholderL3.height/2) > letter2.y ) and 
                (placeholderL3Filled == false) ) then
                

                -- setting the position of the number to be in the center of the box
                letter2.x = placeholderL3.x
                letter2.y = placeholderL3.y
                placeholderL3Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter3 = letter2            
                letter2:removeEventListener( "touch", TouchListenerLetter2 )
                print ("***TouchListenerLetter2: placeholderL3Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end

            --else make box go back to where it was
            elseif (((placeholderL4.x - placeholderL4.width/2) < letter2.x ) and
                ((placeholderL4.x + placeholderL4.width/2) > letter2.x ) and 
                ((placeholderL4.y - placeholderL4.height/2) < letter2.y ) and 
                ((placeholderL4.y + placeholderL4.height/2) > letter2.y ) and 
                (placeholderL4Filled == false) ) then
                

                -- setting the position of the number to be in the center of the box
                letter2.x = placeholderL4.x
                letter2.y = placeholderL4.y
                placeholderL4Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter4 = letter2            
                letter2:removeEventListener( "touch", TouchListenerLetter2 )
                print ("***TouchListenerLetter2: placeholderL3Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                end


            --else make box go back to where it was
            else
                letter2.x = letter2PreviousX
                letter2.y = letter2PreviousY
                print ("***Moving letter 2 back to original position")

            end
        end
        
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLetter3(touch)
    print ("***TouchListenerLetter3 was called")
  --only work if none of the other boxes have been touched
    if (letter1Touched == false) and (letter2Touched == false) and (letter4Touched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            letter3Touched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            letter3.x = touch.x
            letter3.y = touch.y
        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            letter3Touched = false

              -- allow  the letter to be dragged into any place holder 
            if (((placeholderL1.x - placeholderL1.width/2) < letter3.x ) and
                ((placeholderL1.x + placeholderL1.width/2) > letter3.x ) and 
                ((placeholderL1.y - placeholderL1.height/2) < letter3.y ) and 
                ((placeholderL1.y + placeholderL1.height/2) > letter3.y ) and 
                (placeholderL1Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter3.x = placeholderL1.x
                letter3.y = placeholderL1.y

                placeholderL1Filled = true
                
                numLettersCompleted = numLettersCompleted + 1
                
                userLetter1 = letter3
                
                letter3:removeEventListener( "touch", TouchListenerLetter3 )
                print ("***TouchListenerLetter3: placeholderL1Filled is true")
                
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                    
                end
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            elseif (((placeholderL2.x - placeholderL2.width/2) < letter3.x ) and
                ((placeholderL2.x + placeholderL2.width/2) > letter3.x ) and 
                ((placeholderL2.y - placeholderL2.height/2) < letter3.y ) and 
                ((placeholderL2.y + placeholderL2.height/2) > letter3.y ) and 
                (placeholderL2Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter3.x = placeholderL2.x
                letter3.y = placeholderL2.y
                placeholderL2Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter2 = letter3
                letter3:removeEventListener( "touch", TouchListenerLetter3 )
                print ("***TouchListenerLetter3: placeholderL2Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
       
                end
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            elseif (((placeholderL3.x - placeholderL3.width/2) < letter3.x ) and
                ((placeholderL3.x + placeholderL3.width/2) > letter3.x ) and 
                ((placeholderL3.y - placeholderL3.height/2) < letter3.y ) and 
                ((placeholderL3.y + placeholderL3.height/2) > letter3.y ) and 
                (placeholderL3Filled == false) ) then
                

                -- setting the position of the number to be in the center of the box
                letter3.x = placeholderL3.x
                letter3.y = placeholderL3.y
                placeholderL3Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter3 = letter3
                letter3:removeEventListener( "touch", TouchListenerLetter3 )
                print ("***TouchListenerLetter3: placeholderL3Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                    
                end

            --else make box go back to where it was
            elseif (((placeholderL4.x - placeholderL4.width/2) < letter3.x ) and
                ((placeholderL4.x + placeholderL4.width/2) > letter3.x ) and 
                ((placeholderL4.y - placeholderL4.height/2) < letter3.y ) and 
                ((placeholderL4.y + placeholderL4.height/2) > letter3.y ) and 
                (placeholderL4Filled == false) ) then
                

                -- setting the position of the number to be in the center of the box
                letter3.x = placeholderL4.x
                letter3.y = placeholderL4.y
                placeholderL4Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter4 = letter3
                letter3:removeEventListener( "touch", TouchListenerLetter3 )
                print ("***TouchListenerLetter3: placeholderL3Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                    
                end
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                letter3.x = letter3PreviousX
                letter3.y = letter3PreviousY
                print ("***Moving letter 3 back to original position")

            end
        end
        
    end  
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerLetter4(touch)
    print ("***TouchListenerLetter4 was called")
  --only work if none of the other boxes have been touched
    if (letter1Touched == false) and (letter2Touched == false) and (letter3Touched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            letter4Touched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            letter4.x = touch.x
            letter4.y = touch.y
        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            letter4Touched = false

              -- allow  the letter to be dragged into any place holder 
            if (((placeholderL1.x - placeholderL1.width/2) < letter4.x ) and
                ((placeholderL1.x + placeholderL1.width/2) > letter4.x ) and 
                ((placeholderL1.y - placeholderL1.height/2) < letter4.y ) and 
                ((placeholderL1.y + placeholderL1.height/2) > letter4.y ) and 
                (placeholderL1Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter4.x = placeholderL1.x
                letter4.y = placeholderL1.y

                placeholderL1Filled = true
                
                numLettersCompleted = numLettersCompleted + 1
                
                userLetter1 = letter4
                
                letter4:removeEventListener( "touch", TouchListenerLetter4 )
                print ("***TouchListenerLetter4: placeholderL1Filled is true")
                
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                    
                end
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            elseif (((placeholderL2.x - placeholderL2.width/2) < letter4.x ) and
                ((placeholderL2.x + placeholderL2.width/2) > letter4.x ) and 
                ((placeholderL2.y - placeholderL2.height/2) < letter4.y ) and 
                ((placeholderL2.y + placeholderL2.height/2) > letter4.y ) and 
                (placeholderL2Filled == false)) then

                -- setting the position of the number to be in the center of the box
                letter4.x = placeholderL2.x
                letter4.y = placeholderL2.y
                placeholderL2Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter2 = letter4
                letter4:removeEventListener( "touch", TouchListenerLetter4 )
                print ("***TouchListenerLetter4: placeholderL2Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
       
                end
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            elseif (((placeholderL3.x - placeholderL3.width/2) < letter4.x ) and
                ((placeholderL3.x + placeholderL3.width/2) > letter4.x ) and 
                ((placeholderL3.y - placeholderL3.height/2) < letter4.y ) and 
                ((placeholderL3.y + placeholderL3.height/2) > letter4.y ) and 
                (placeholderL3Filled == false) ) then
                

                -- setting the position of the number to be in the center of the box
                letter4.x = placeholderL3.x
                letter4.y = placeholderL3.y
                placeholderL3Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter3 = letter4
                letter4:removeEventListener( "touch", TouchListenerLetter4 )
                print ("***TouchListenerLetter4: placeholderL4Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                    
                end

            --else make box go back to where it was
            elseif (((placeholderL4.x - placeholderL4.width/2) < letter4.x ) and
                ((placeholderL4.x + placeholderL4.width/2) > letter4.x ) and 
                ((placeholderL4.y - placeholderL4.height/2) < letter4.y ) and 
                ((placeholderL4.y + placeholderL4.height/2) > letter4.y ) and 
                (placeholderL4Filled == false) ) then
                

                -- setting the position of the number to be in the center of the box
                letter4.x = placeholderL4.x
                letter4.y = placeholderL4.y
                placeholderL4Filled = true
                numLettersCompleted = numLettersCompleted + 1
                userLetter4 = letter4
                letter4:removeEventListener( "touch", TouchListenerLetter4 )
                print ("***TouchListenerLetter4: placeholderL4Filled is true")
                if (numLettersCompleted == 4) then
                    CheckUserAnswerInput()
                    
                end
                -- call the function to check if the user's input is correct or not
                --CheckUserAnswerInput()

            --else make box go back to where it was
            else
                letter4.x = letter4PreviousX
                letter4.y = letter4PreviousY
                print ("***Moving letter 4 back to original position")

            end
        end
        
    end  
end


--adding the event listeners 
local function AddTextListeners ( )
    print ("***Adding touch listeners back to each letter")
    letter1:addEventListener( "touch", TouchListenerLetter1 )
    letter2:addEventListener( "touch", TouchListenerLetter2)
    letter3:addEventListener( "touch", TouchListenerLetter3)
    letter4:addEventListener( "touch", TouchListenerLetter4)

end

--removing the event listeners
local function RemoveTextListeners()
    letter1:removeEventListener( "touch", TouchListenerLetter1 )
    letter2:removeEventListener( "touch", TouchListenerLetter2)
    letter3:removeEventListener( "touch", TouchListenerLetter3)
    letter4:removeEventListener( "touch", TouchListenerLetter4)
end


-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function AskQuestionLevel2()
    DisplayQuestion()
    LetterPosion()
    AddTextListeners()
end
   
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0.5)

    -----------------------------------------------------------------------------------------
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)

    -- create the question text object
    questionText = display.newText("Drag the letters into the\nboxes to make a word.", display.contentCenterX, display.contentCenterY*3/8, Arial, 50)
    correctObject = display.newText("Correct!!:)",display.contentCenterX, display.contentCenterY*7/8, Arial, 50)
    correctObject.isVisible = false

    inCorrectObject = display.newText("", display.contentCenterX, display.contentCenterY*7/8, Arial, 50)
    inCorrectObject.isVisible = false

    -- create the answer text object & wrong answer text objects
    letter1 = display.newText("", X1, Y1, Arial, 100)
    letter1:setTextColor(0,0,0)
    letter2 = display.newText("", X2, Y1, Arial, 100)
    letter2:setTextColor(0,0,0)
    letter3 = display.newText("", X3, Y1, Arial, 100)
    letter3:setTextColor(0,0,0)
    letter4 = display.newText("", X4, Y1, Arial, 100)
    letter4:setTextColor(0,0,0)
    pointsText = display.newText("Points = " .. points, display.contentWidth*4/7, display.contentHeight*6/7, Arial, 50)
    pointsText:setTextColor(0,0,0)

    livesText = display.newText("lives = " .. lives, display.contentWidth*2/7, display.contentHeight*6/7, Arial, 50)
    livesText:setTextColor(0,0,0)

    -- Insert the platforms
    placeholderL1 = display.newImageRect("Images/LetterPlaceHolderMelody@2x.png", 100, 100)
    placeholderL1.x = X1
    placeholderL1.y = Y2

    -- Insert the platforms
    placeholderL2 = display.newImageRect("Images/LetterPlaceHolderMelody@2x.png", 100, 100)
    placeholderL2.x = X2
    placeholderL2.y = Y2

    -- Insert the platforms
    placeholderL3 = display.newImageRect("Images/LetterPlaceHolderMelody@2x.png", 100, 100)
    placeholderL3.x = X3
    placeholderL3.y = Y2
    -- Insert the platforms
    placeholderL4 = display.newImageRect("Images/LetterPlaceHolderMelody@2x.png", 100, 100)
    placeholderL4.x = X4
    placeholderL4.y = Y2

    --create the tome to display on the screen
    clockText = display.newText("secondsLeft = ".. secondsLeft, 100, 100, nil, 50)
    clockText:setTextColor(168/255, 255/255, 5/255)
    clockText.x= 500
    clockText.y= 65

    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(placeholderL1)
    sceneGroup:insert(placeholderL2)
    sceneGroup:insert(placeholderL3)
    sceneGroup:insert(placeholderL4)
    sceneGroup:insert(letter1)
    sceneGroup:insert(letter2)
    sceneGroup:insert(letter3)
    sceneGroup:insert(letter4)
    sceneGroup:insert(livesText)
    sceneGroup:insert(pointsText)
    sceneGroup:insert(clockText)
    sceneGroup:insert(correctObject)
    sceneGroup:insert(inCorrectObject)




end --function scene:create( event 150

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        lives = 3
        points = 0
        StartTimer()
        AskQuestionLevel2()

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveTextListeners()
        timer.cancel(countDownTimer)
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