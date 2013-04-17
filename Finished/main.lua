-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
    local MoleGenerator=require("MoleGenerator")
	local myMole=MoleGenerator.newMole()
    
    local grassUpper=display.newImageRect("images/grass_upper.png",1024,384)
    grassUpper.x=display.contentCenterX
    grassUpper:setReferencePoint(display.TopCenterReferencePoint)
    grassUpper.y=0

    local grassLower=display.newImageRect("images/grass_lower.png",1024,384)
    grassLower.x=display.contentCenterX
    grassLower:setReferencePoint(display.BottomCenterReferencePoint)
    grassLower.y=display.contentHeight
    
    local function didTouchGrass(event)
        return true  --prevents propagation to underlying objects
    end
    grassLower:addEventListener( "touch", didTouchGrass )

    grassUpper:toBack()
    --myMole:toFront()
    grassLower:toFront()

    local bgDirt=display.newImageRect("images/bg_dirt.png",1024,768)
    bgDirt.x=display.contentCenterX
    bgDirt.y=display.contentCenterY
    bgDirt:toBack()