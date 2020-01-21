--hide status bar
display.setStatusBar (display.HiddenStatusBar)

--display the soccer field
---------------------------------------------------------------------------------
--
-- FoodNGames Level 4 - soccer
-- Created by: Logan
-- Date: Nov. 22nd, 2014
-- Description: This is the level 3 screen of the game.
----------------------------------------------------------------------------------------


-- Use Composer Library
local composer = require( "composer" )

----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

----------------------------------------------------------------------------------------

 --Naming Scene
sceneName = "level6_screen"

 --Creating Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
----------------------------------------------------------------------------------------

-- The background image, soccer ball and player/character for this scene+local bkg_image
local soccerBall
local player
local bkg_image
local backButton

--the text that displays the question
local questionText
local points = 0
local pointsText
local lives = 2
local livesText

--the alternate numbers randomly generated
local correctAnswer = 0
local alternateAnswer1
local alternateAnswer2
local correctText
local incorrectText

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box wa touched
local answerBoxAlreadyTouched = false
local alternateAnswerBox1AlreadyTouched = false
local alternateAnswerBox2AlreadyTouched = false

--create textboxes holding answer and alternate ansers 
local answerBox
local alternateAnswerBox1
local alternateAnswerBox2

-- create variables that will hold the previous x- nd y-positions so that 
-- each answer will return back to its previous postion after it is moved
local answerBoxPreviousY
local alternateAnswerBox1PreviousY
local alternateAnswerBox2PreviousY

local answerBoxPreviousX
local alternateAnswerBox1PreviousX
local alternateAnswerBox2PreviousX

-- the black box where the user will drag the answer
local userAnswerBoxPlaceholder

-- sound effects
local correctSound
local booSound

--scroll speed for the ball to Score
local scrollXSpeedCorrect = 14.5
local scrollYSpeedCorrect = -17
local scrollXSpeedIncorrect = -8
local scrollYSpeedIncorrect = -20

-----------------------------------------------------------------------------------------
--SOUNDS
-----------------------------------------------------------------------------------------

local soccerSound = audio.loadStream("Sounds/soccerSound.mp3")
local soccerSoundChannel

local correctSound = audio.loadSound( "Sounds/correctSound.mp3")
local correctSoundChannel

local wrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local wrongSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------- 

local function BackTransition()
    composer.gotoScene("mainmenu", {effect = "fade", time = 500})
end

local function BackTransition()
    composer.gotoScene("level5&6", {effect="flipFadeOutIn", time=500})
end
local function DisplayQuestion()
    local randomNumber1
    local randomNumber2

    --set random numbers
    randomNumber1 = math.random(1, 9)
    randomNumber2 = math.random(1, 9)

    --calculate answer
    correctAnswer = randomNumber1 * randomNumber2

    --change question text in relation to answer
    questionText.text = randomNumber1 .. " x " .. randomNumber2 .. " = " 

    -- put the correct answer into the answerbox
    answerBox.text = correctAnswer

    -- make it possible to click on the answers again
    answerBoxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2AlreadyTouched = false

end

local function DetermineAlternateAnswers()    

        
    -- generate incorrect answer and set it in the textbox
    alternateAnswer1 = correctAnswer + math.random(3, 5)
    alternateAnswerBox1.text = alternateAnswer1
    

    -- generate incorrect answer and set it in the textbox
    alternateAnswer2 = correctAnswer - math.random(1, 2)
    alternateAnswerBox2.text = alternateAnswer2

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    answerBox.x = display.contentWidth * 0.9
    alternateAnswerBox1.x = display.contentWidth * 0.9
    alternateAnswerBox2.x = display.contentWidth * 0.9


end

local function PositionAnswers()
    local randomPosition

    -------------------------------------------------------------------------------------------
    --ROMDOMLY SELECT ANSWER BOX POSITIONS
    -----------------------------------------------------------------------------------------
    randomPosition = math.random(1,3)

    -- random position 1
    if (randomPosition == 1) then
        -- set the new y-positions of each of the answers
        answerBox.y = display.contentHeight * 0.4

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.70

        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.55

        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        answerBoxPreviousY = answerBox.y 

    -- random position 2
    elseif (randomPosition == 2) then

        answerBox.y = display.contentHeight * 0.55
        
        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.4

        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.7

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        answerBoxPreviousY = answerBox.y 

    -- random position 3
    elseif (randomPosition == 3) then
        answerBox.y = display.contentHeight * 0.70

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.55

        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.4

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        answerBoxPreviousY = answerBox.y 
    end
end

--hide the correct text
local function HideCorrectText()
    correctText.isVisible = false
end

--hide the incorrect answer text
local function HideIncorrectText()
    incorrectText.isVisible = false
end

--function to move the soccer ball once they get the answer right
local function MoveSoccerBallCorrect()
    if (soccerBall.y < 100) then
        Runtime:removeEventListener("enterFrame", MoveSoccerBallCorrect)
    else
        soccerBall.x = soccerBall.x + scrollXSpeedCorrect
        soccerBall.y = soccerBall.y + scrollYSpeedCorrect
    end
end

local function MoveSoccerBallIncorrect()
    if (soccerBall.y < 0) then
        Runtime:removeEventListener("enterFrame", MoveSoccerBallIncorrect)
    else
        soccerBall.x = soccerBall.x + scrollXSpeedIncorrect
        soccerBall.y = soccerBall.y + scrollYSpeedIncorrect
    end
end

-- Function to Restart Level 1
local function RestartLevel1()
    soccerBall.x = display.contentWidth*0.385
    soccerBall.y = display.contentHeight * 12/20
    DisplayQuestion()
    DetermineAlternateAnswers()
    PositionAnswers()    
end


local function Lives()
    if (lives == 0) then
        composer.gotoScene("youLose", {effect = "fade", time = 500})
    end
end


-- Function to Check User Input
local function CheckUserAnswerInput()
    print("Executing CheckUserAnswerInput")
    
    if (userAnswer == correctAnswer) then
        points = points + 1
        pointsText.text = "Points: " .. points
        correctText.isVisible = true
        correctSoundChannel = audio.play ( correctSound )
        timer.performWithDelay(1600, HideCorrectText)

        Runtime:addEventListener("enterFrame", MoveSoccerBallCorrect) 
        
    else 
        lives = lives -1
        livesText.text = "Lives: " .. lives
        Lives()
        print("correctAnswer = ".. correctAnswer)
        incorrectText.isVisible = true
        incorrectText.text = "Incorrect! The correct answer is " .. correctAnswer .. "!"
        timer.performWithDelay(1600, HideIncorrectText)

        Runtime:addEventListener("enterFrame", MoveSoccerBallIncorrect)
    end

    if (points == 5) then
        composer.gotoScene("you_win", {effect = "fade", time = 500})
    else
       timer.performWithDelay(1800, RestartLevel1)
    end   
end


local function Lives()
    if (lives == 0) then
        composer.gotoScene("you_lose", {effect = "fade", time = 500})
    end
end



local function TouchListenerAnswerBox(touch)
    --only work if none of the other boxes have been touched
    if (alternateAnswerBox1AlreadyTouched == false) and 
        (alternateAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            answerBoxAlreadyTouched = true
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            answerBox.x = touch.x
            answerBox.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            answerBoxAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < answerBox.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > answerBox.x ) and
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < answerBox.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > answerBox.y ) ) then

                -- setting the position of the number to be in the center of the box
                answerBox.x = userAnswerBoxPlaceholder.x
                answerBox.y = userAnswerBoxPlaceholder.y
                userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                answerBox.x = answerBoxPreviousX
                answerBox.y = answerBoxPreviousY
            end
        end
    end                
end 

local function TouchListenerAnswerBox1(touch)
    --only work if none of the other boxes have been touched
    if (answerBoxAlreadyTouched == false) and 
        (alternateAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswerBox1.x = touch.x
            alternateAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox1.y ) ) then

                alternateAnswerBox1.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                alternateAnswerBox1.x = alternateAnswerBox1PreviousX
                alternateAnswerBox1.y = alternateAnswerBox1PreviousY
            end
        end
    end
end 

local function TouchListenerAnswerBox2(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (alternateAnswerBox1AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox2AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            alternateAnswerBox2.x = touch.x
            alternateAnswerBox2.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox2.y ) ) then

                alternateAnswerBox2.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox2.y = userAnswerBoxPlaceholder.y
                userAnswer = alternateAnswer2

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                alternateAnswerBox2.x = alternateAnswerBox2PreviousX
                alternateAnswerBox2.y = alternateAnswerBox2PreviousY
            end
        end
    end
end 

-- Function that Adds Listeners to each answer box
local function AddAnswerBoxEventListeners()
    answerBox:addEventListener("touch", TouchListenerAnswerBox)
    alternateAnswerBox1:addEventListener("touch", TouchListenerAnswerBox1)
    alternateAnswerBox2:addEventListener("touch", TouchListenerAnswerBox2)
end 

-- Function that Removes Listeners to each answer box
local function RemoveAnswerBoxEventListeners()
    answerBox:removeEventListener("touch", TouchListenerAnswerBox)
    alternateAnswerBox1:removeEventListener("touch", TouchListenerAnswerBox1)
    alternateAnswerBox2:removeEventListener("touch", TouchListenerAnswerBox2)
end 

----------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
----------------------------------------------------------------------------------


----------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
----------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ----------------------------------------------------------------------------------
    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth/1.13,
        y = display.contentHeight/1.12,
        x = display.contentWidth/1.12,
        y = display.contentHeight/1.13,
        -- sets the size of the button
        width = 190,
        height = 100,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/HomeUnpressedMelody@2x.png",
        overFile = "Images/HomePressedMelody@2x.png",

        -- Setting Functional Properties
        onRelease = BackTransition
        defaultFile = "Images/BackButtonUnpressedJosias@2x.png",
        overFile = "Images/BackButtonPressedJosias@2x.png",

        -- Setting Functional Properties
        onRelease = BackTransition
    } )
    ----------------------------------------------------------------------------------
    --Inserting backgroud image and lives
    ----------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level3ScreenLogan.png", 1024, 768)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    --the text that displays the question
    questionText = display.newText( "" , 0, 0, nil, 100)
    questionText.x = display.contentWidth * 0.3
    questionText.y = display.contentHeight * 0.9
    questionText:setTextColor(1/255, 1/255, 1/255)

    -- create the soccer ball and place it on the scene
    soccerBall = display.newImageRect("Images/soccerball.png", 60, 60, 0, 0)
    soccerBall.x = display.contentWidth*0.385
    soccerBall.y = display.contentHeight * 12/20

    --insert the character into the scene of the game
    player = display.newImageRect("Images/SoccerCharacterLogan@2x.png", 200, 300, 0, 0)
    player.x = display.contentWidth/3
    player.y = display.contentHeight/1.9

    -- boolean variables stating whether or not the answer was touched
    answerBoxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2AlreadyTouched = false

    --create answerbox alternate answers and the boxes to show them
    answerBox = display.newText("", display.contentWidth * 0.9, 0, nil, 100)
    answerBox:setTextColor(1/255, 1/255, 1/255)
    alternateAnswerBox1 = display.newText("", display.contentWidth * 0.9, 0, nil, 100)
    alternateAnswerBox1:setTextColor(1/255, 1/255, 1/255)
    alternateAnswerBox2 = display.newText("", display.contentWidth * 0.9, 0, nil, 100)
    alternateAnswerBox2:setTextColor(1/255, 1/255, 1/255)

    -- set the x positions of each of the answer boxes
    answerBoxPreviousX = display.contentWidth * 0.9
    alternateAnswerBox1PreviousX = display.contentWidth * 0.9
    alternateAnswerBox2PreviousX = display.contentWidth * 0.9


    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/userAnswerBoxPlaceholder.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.6
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.9

    --the amounts of points shown on the screen
    pointsText = display.newText("Points: " .. points .. "", 0, 0, nil, 70)
    pointsText.x = display.contentWidth/6
    pointsText.y = display.contentHeight/22
    pointsText:setTextColor(1/255, 1/255, 1/255)

    livesText = display.newText("Lives: " .. lives .. "", 0, 0, nil, 55)
    livesText.x = display.contentWidth/1.12
    livesText.y = display.contentHeight/22
    livesText:setTextColor(1/255, 1/255, 1/255)

    --correct answer text
    correctText = display.newText("Correct! Great Job!", 0, 0, nil, 50)
    correctText.x = display.contentWidth/2
    correctText.y = display.contentHeight/3
    correctText:setTextColor(1/255, 1/255, 1/255)
    correctText.isVisible = false

    incorrectText = display.newText("Incorrect! The correct answer was " .. correctAnswer .. "!", 0, 0, nil, 50)
    incorrectText.x = display.contentWidth/2
    incorrectText.y = display.contentHeight/3
    incorrectText:setTextColor(1/255, 1/255, 1/255)
    incorrectText.isVisible = false

    ----------------------------------------------------------------------------------
    --adding objects to the scene group
    ----------------------------------------------------------------------------------

    sceneGroup:insert( bkg_image ) 
    sceneGroup:insert( questionText ) 
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( answerBox )
    sceneGroup:insert( alternateAnswerBox1 )
    sceneGroup:insert( alternateAnswerBox2 )
    sceneGroup:insert( soccerBall )
    sceneGroup:insert( player )
    sceneGroup:insert( pointsText )
    sceneGroup:insert( correctText )
    sceneGroup:insert( livesText )
    sceneGroup:insert( backButton )


end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).    

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        RestartLevel1()
        AddAnswerBoxEventListeners()
        soccerSoundChannel = audio.play ( soccerSound, {loops = -1})

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
        

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        audio.stop(soccerSoundChannel)
        RemoveAnswerBoxEventListeners()
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