module(..., package.seeall)

local MoleGenerator={}

    function MoleGenerator.newMole()
    	local newMole=display.newImageRect("images/mole_1.png",178,200)
		newMole.x=display.contentCenterX
		newMole.y=display.contentHeight
		
        
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
        
        --a function to move the mole up
        local function moveMoleUp()
            newMole.transition=transition.to(newMole,{
                                                        time=travelTime,
                                                        y=display.contentCenterY,
                                                        onComplete=moveMoleDown
                                                    }
                                            )   
        end
        
        function randomMoveMole()
           local randomSeconds=math.random(1000,5000)
           timer.performWithDelay(randomSeconds,moveMoleUp)
        end
        randomMoveMole() 
        
        return newMole
	end
    
return MoleGenerator