-----------------------------------------------------------------------------------------
--
-- game_level1.lua
-- Created by: Daniel
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------


-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level3_screen"

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- sounds
local soccerSound = audio.loadStream( "Sounds/soccerSound.mp3")
local soccerSoundChannel
local correctSound = audio.loadSound( "Sounds/correctSound.mp3")
local correctSoundChannel
local wrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local wrongSoundChannel

-- hearts 
local lives = 4 
local heart1 
local heart2 
local heart3 
local heart4 

-- The background image and soccer ball for this scene
local bkg_image
local soccerball

--the text that displays the question
local questionText 
local correctObject
local incorrectObject
--the alternate numbers randomly generated
local correctAnswer
local alternateAnswer1
local alternateAnswer2    

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box was touched
local answerBoxAlreadyTouched = false
local alternateAnswerBox1AlreadyTouched = false
local alternateAnswerBox2AlreadyTouched = false

--create textboxes holding answer and alternate answers 
local answerBox
local alternateAnswerBox1
local alternateAnswerBox2

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
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
local points = 0


--scroll speed for the ball to Score
local scrollXSpeedCorrect = 14.5
local scrollYSpeedCorrect = -17
local scrollXSpeedIncorrect = -8
local scrollYSpeedIncorrect = -20
local ballPosition



-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function BackTransition()
    composer.gotoScene( "mainmenu", {effect = "flipFadeOutIn", time = 500})
end 

local function DisplayQuestion()
    local randomOperator 
    local randomNumber1
    local randomNumber2
    local tempRandomNumber

    --set random numbers
    randomNumber1 = math.random(2, 15)
    randomNumber2 = math.random(2, 15)
    randomOperator = math.random(1, 2)
    print ("***randomOperator = " .. randomOperator)

    if (randomOperator == 1) then
       soccerball.x = ballPosition.x
       soccerball.y = ballPosition.y
       

        --calculate answer
        correctAnswer = randomNumber1 + randomNumber2

        --change question text in relation to answer
        questionText.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 

        -- put the correct answer into the answerbox
        answerBox.text = correctAnswer

        

    elseif (randomOperator == 2) then
       soccerball.x = ballPosition.x
       soccerball.y = ballPosition.y

        if (randomNumber1 < randomNumber2)then
            tempRandomNumber = randomNumber1
            randomNumber1 = randomNumber2
            randomNumber2 = tempRandomNumber
        end          
    
        -- calculate answer 
        correctAnswer = randomNumber1 - randomNumber2

        -- change the question text in relation to answer 
        questionText.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

        -- put the correct answer intio the answerbox
        answerBox.text = correctAnswer       
    end 
    -- make it possible to click on the answers again
    answerBoxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2AlreadyTouched = false

end

local function HideCorrect()
    correctObject.isVisible = false
end

local function Hideincorrect()
    incorrectObject.isVisible = false
end    


--function to move the soccer ball once they get the answer right
local function MovesoccerballCorrect()
    if (soccerball.y < 100) then
        Runtime:removeEventListener("enterFrame", MovesoccerballCorrect)
    else
        soccerball.x = soccerball.x + scrollXSpeedCorrect
        soccerball.y = soccerball.y + scrollYSpeedCorrect
    end
end

local function MovesoccerballIncorrect()
    if (soccerball.y < 0) then
        Runtime:removeEventListener("enterFrame", MovesoccerballIncorrect)
    else
        soccerball.x = soccerball.x + scrollXSpeedIncorrect
        soccerball.y = soccerball.y + scrollYSpeedIncorrect
    end
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

        --alternateAnswerBox1AlreadyTouched
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


-- Function to Restart Level 1
local function RestartLevel3()
    print ("***Called RestartLevel3")
    DisplayQuestion()
    DetermineAlternateAnswers()
    PositionAnswers()    
end

-- Function to Check User Input
local function CheckUserAnswerInput()

    if (userAnswer == correctAnswer)then
        print ("***Answer is correct")
        correctObject.isVisible = true

        correctSoundChannel = audio.play(correctSound)
        Runtime:addEventListener("enterFrame", MovesoccerballCorrect) 
        timer.performWithDelay(2000, HideCorrect)
        
        points = points + 1

        -- update it in the display object
        pointsText.text = "Points = " .. points 
        print ("***points = " .. points)

        if ( points == 5 ) then              
            
            composer.gotoScene ("you_win", {effect = "fade", time = 500}) 
        else 
            timer.performWithDelay(1600, RestartLevel3)        
        end 
             
    else     
        print ("***Answer is wrong")  
        lives = lives - 1
        secondsLeft = totalSeconds
        incorrectObject.isVisible = true 
        wrongSoundChannel = audio.play(wrongSound)
        Runtime:addEventListener("enterFrame", MovesoccerballIncorrect) 
        timer.performWithDelay(2000, Hideincorrect)


        if (lives == 3) then
            heart4.isVisible = false
            timer.performWithDelay(1600, RestartLevel3)   
        elseif (lives == 2) then
            heart3.isVisible = false
            timer.performWithDelay(1600, RestartLevel3)  
        elseif (lives == 1) then
            heart2.isVisible = false
            timer.performWithDelay(1600, RestartLevel3)  
        elseif (lives == 0) then 
            heart1.isVisible = false 
            composer.gotoScene("youLose", {effect = "fade", time = 500})
        end
  

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

                soccerball.x = ballPosition.x
                soccerball.y = ballPosition.y

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

                soccerball.x = ballPosition.x
                soccerball.y = ballPosition.y


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
    if (answerBoxAlreadyTouched == false) and 
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

                soccerball.x = ballPosition.x
                soccerball.y = ballPosition.y



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

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level3ScreenLogan.png", 2048, 1536)
    bkg_image.anchorX = 0
    bkg_image.anchorY = 0
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    ----------------------------------------------------------------------------------
    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth/1.12,
        y = display.contentHeight/1.13,
        -- sets the size of the button
        width = 190,
        height = 100,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        
        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedJosias@2x.png",
        overFile = "Images/BackButtonPressedJosias@2x.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    --the text that displays the question
    questionText = display.newText( "" , 0, 0, nil, 100)
    questionText.x = display.contentWidth * 0.3
    questionText.y = display.contentHeight * 0.9
    questionText:setTextColor(1/255, 1/255, 1/255)

    -- create the soccer ball and place it on the scene
    soccerball = display.newImageRect("Images/soccerball.png", 60, 60, 0, 0)
    soccerball.x = display.contentWidth*0.385
    soccerball.y = display.contentHeight * 12/20

    -- create Character 
    character = display.newImageRect("Images/SoccerCharacterLogan@2x.png", 250, 250, 100, 100)
    character.x = display.contentWidth*0.300
    character.y = display.contentHeight * 10/18

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
    -- create the lives to display ont the screen 
    heart1 = display.newImageRect("Images/heart.png", 50, 50)
    heart1.x = display.contentWidth  * 7.8/8
    heart1.y = display.contentHeight * 1/7

    heart2 = display.newImageRect("Images/heart.png", 50, 50)
    heart2.x = display.contentWidth * 7.4/8
    heart2.y = display.contentHeight * 1/7

    heart3 = display.newImageRect("Images/heart.png", 50, 50)
    heart3.x = display.contentWidth * 7/8
    heart3.y = display.contentHeight * 1/7

    heart4 = display.newImageRect("Images/heart.png", 50, 50)
    heart4.x = display.contentWidth * 6.6/8
    heart4.y = display.contentHeight * 1/7
    
    correctObject = display.newText( "Correct", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
    correctObject.isVisible = false
    correctObject:setTextColor(1/255, 1/255, 1/255)

    -- Create the incorrect text object and make it visible
    incorrectObject = display.newText( "Incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
    incorrectObject.isVisible = false
    incorrectObject:setTextColor(1/255, 1/255, 1/255)

    -- display the amount of points as text object
    pointsText = display.newText("Points = " .. points, display.contentWidth/3, display.contentHeight/3, nil,50)
    pointsText:setTextColor(1/255, 1/255, 1/255)


    ballPosition = display.newImageRect("Images/soccerball.png", 60, 60, 0, 0)
    ballPosition.x = display.contentWidth*0.385 
    ballPosition.y = display.contentHeight * 12/20
    ballPosition.isvisible = false

    ----------------------------------------------------------------------------------
    sceneGroup:insert( bkg_image ) 
    sceneGroup:insert( ballPosition )
    ----------------------------------------------------------------------------------

    
    sceneGroup:insert( questionText ) 
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( answerBox )
    sceneGroup:insert( alternateAnswerBox1 )
    sceneGroup:insert( alternateAnswerBox2 )
    sceneGroup:insert( soccerball )
    sceneGroup:insert( backButton )
    sceneGroup:insert( character )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart4 )
    sceneGroup:insert( pointsText )
    sceneGroup:insert(incorrectObject)
    sceneGroup:insert(correctObject)
    sceneGroup:insert(ballPosition)
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
        points = 0 
        lives = 4 
        heart1.isVisible = true 
        heart2.isVisible = true
        heart3.isVisible = true 
        heart4.isVisible = true 
        RestartLevel3()
        AddAnswerBoxEventListeners() 
        soccerSoundChannel = audio.play(soccerSound)

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