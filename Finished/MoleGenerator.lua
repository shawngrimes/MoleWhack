module(..., package.seeall)

local movieclip = require("movieclip")

local MoleGenerator={}

    function MoleGenerator.newMole()
    	local newMole=movieclip.newAnim{"images/mole_1.png", 
            "images/mole_laugh3.png", 
            "images/mole_thump4.png"}
		newMole.x=display.contentCenterX
		newMole.y=display.contentHeight
		
        newMole:stopAtFrame(1)
        
        local whackSound = audio.loadSound( "whack.wav" )
        local laughSound = audio.loadSound("laugh.wav")
        
        --Configure how fast our mole will move
        local moleSpeed=5
        local distanceToTravel=newMole.y - display.contentCenterY
        local travelTime=distanceToTravel/(1/moleSpeed)
        
        local randomMoveMole
        --a function to move the mole down
        local function moveMoleDown()
            newMole.transition=transition.to(newMole,{
                                                        time=travelTime,
                                                        y=display.contentHeight,
                                                         onComplete=randomMoveMole
                                                    }
                                            )
        end
        
        local function moleLaugh()
            newMole:stopAtFrame( 2 )
            audio.play(laughSound)
            moveMoleDown()
        end
        
        --a function to move the mole up
        local function moveMoleUp()
            local function delayMoveDown()
                newMole.currentTimer=timer.performWithDelay( 1000,moleLaugh,1)  
            end
            newMole.transition=transition.to(newMole,{
                                                        time=travelTime,
                                                        y=display.contentCenterY,
                                                        onComplete=delayMoveDown
                                                    }
                                            )   
        end
        
        local function didTouchMole(event)
            if ( event.phase == "began" ) then
                audio.play(whackSound)
                newMole:stopAtFrame( 3 )
                timer.cancel(newMole.currentTimer)
                transition.cancel(newMole.transition)
                moveMoleDown()
            end
            return true  --prevents propagation to underlying objects
        end
        newMole:addEventListener( "touch", didTouchMole )
        
        function randomMoveMole()
            --reset mole frame
            newMole:stopAtFrame( 1 )
            
            --randomly select hole
            local randomHole=math.random(1,3)
            if(randomHole==1) then
                newMole.x=200
            elseif(randomHole==2) then
                newMole.x=display.contentCenterX
            elseif(randomHole==3) then
                newMole.x=820
            end
            
            local randomSeconds=math.random(1000,5000)
            timer.performWithDelay(randomSeconds,moveMoleUp)
        end
        randomMoveMole() 
        
        return newMole
	end
    
return MoleGenerator