Creating a Mole Whack Game with CoronaSDK
=====

This sample project uses the [Mole Whack artwork](http://www.vickiwenderlich.com/2011/05/game-pack-mole-whack/) provided [Vicki Wenderlich](http://www.vickiwenderlich.com).

1. Download the starter project from the [APPlied Club projects](http://www.appliedclub.org/projects/) page.  Unzip the project.

2. Let's start by exploring the contents of our new project.  Open the project folder and then open the `images` folder.  Just take a look at some of the images in there to get an idea for what we have.

3. Open the Corona Simulator and open the project.  Then open the `main.lua` file in **Notepad++**

4. Let's add one of the images to our simulator screen.  Let's start with our "friend" the Mole.  Add the following code in main.lua:
	
	````
	local myMole=display.newImageRect("images/mole_1.png",178,200)
	````

5.  Before I explain what this code means, save and relaunch the project.  You should see a brown speck in the top left of the simulator screen.  This is our mole.  
He's not really in a good place, so let's move him to the center of the screen for now so we can get a good look at him.

6. After the line we just added, let's add the two following lines to center our mole.

	````
	myMole.x=display.contentCenterX
	myMole.y=display.contentCenterY
	````

7.  Save and relaunch the project and you should get a much better look at our Mole.  Awww, isn't he cute?

8.  Go to Slides

9. Back to Code

10.  Ok our mole is pretty vulnerable out there with nothing to hide behind, so let's give him some cover…

11.  Let's add the upper part of our grass:
	````
	local grassUpper=display.newImageRect("images/grass_upper.png",1024,384)
    grassUpper.x=display.contentCenterX
    ````

12.  Save and relaunch the project now. The code above gets the top of our grass centered horizontally but we need to place it vertically now.  We don't want the upper grass to be centered vertically.  Instead we want the top edge of the grass to be lined up with the top edge of the screen.  
	By default, Corona moves the center point of an object around but you can change this.  This is called the object's **referencePoint**. Since I want to line up the top of the upper grass image, I would rather control where it is located by using the top of the image.
	
13. Here's how to change that reference point:
	````
	grassUpper:setReferencePoint(display.TopCenterReferencePoint)
    grassUpper.y=0
	````
14. Can you figure out how to add the bottom grass while I go back to the slides?

15. Go to Slides

16. Back to Code

16. Here is the code to add the bottom grass:

	````
	local grassLower=display.newImageRect("images/grass_lower.png",1024,384)
    grassLower.x=display.contentCenterX
    grassLower:setReferencePoint(display.BottomCenterReferencePoint)
    grassLower.y=display.contentHeight
	````

17.  If you've noticed, our mole is now completely hidden behind our grass. 
	
18.  We can think of each of these objects as layers and as we create new objects, they are placed on top of older objects. This is the current layout of our screen:
	* Layer 1: Mole
	* Layer 2: Upper Grass
	* Layer 3: Lower Grass 
	
19. It would look a little better if our layers were laid out like this:
	* Layer 1: Upper Grass
	* Layer 2: Mole
	* Layer 3: Lower Grass

21.  Let's rearrange our layers by adding the following lines of code:
	````
	grassUpper:toBack()
   	myMole:toFront()
   	grassLower:toFront()
   	````
   	
22. While I go to the slides, Vicki gave us one more piece of artwork to add in.  She gave us a file called `bg_dirt.png` that should go all the way in the back.  Do you think you can add that yourself?  Give it a shot.  

22. Back to Slides

23. Back to Code
````    
    local bgDirt=display.newImageRect("images/bg_dirt.png",1024,768)
    bgDirt.x=display.contentCenterX
    bgDirt.y=display.contentCenterY
    bgDirt:toBack()
````

2. We are going to move our Mole character to it's own file so we can separate all of the code related to the mole.  This will help us in the future to find any changes we need to make to the mole.

3. Create a new file called "MoleGenerator.lua" in the same folder as the main.lua file for MoleWhack.  This is going to be a text file but instead of having the .txt extension, it should have the .lua extension.  

4.  Now open up main.lua and remove the lines that created the "myMole" object.  **Remove this:**
	````
	local myMole=display.newImageRect("images/mole_1.png",178,200)
    myMole.x=display.contentCenterX
    myMole.y=display.contentCenterY
    ````
    
5.  For the time being, go down and find the following line and comment it out (that means add -- to the beginning of the line):
	````
	myMole:toFront()
	````

7.  Save and re-launch the project.  Your mole should be gone but also make sure you don't have any errors in the terminal window.

8. 	Now open up *MoleGenerator.lua* in **Notepad++**(Win) or **TextWrangler**(Mac)

9. MoleGenerator.lua is what is called a module or class.  To start a new module, add the following line to the top of the file:
	````
	module(..., package.seeall)
	````
	
10. Now, we will create an object that represents our module.  To do that, add the following:
	````
	local MoleGenerator={}
	
	return MoleGenerator
	````
	
11.  So far, this is simple enough.  What will eventually happen is, we will include MoleGenerator.lua into our main.lua file.  main.lua will read the contents of MoleGenerator.lua and include whatever it returns.

12.  Now that we have our MoleGenerator object defined, we are going to add a function to it that actually creates a new mole for us.  In fact, that sounds like a great name for our function "newMole".  Before the line ````return MoleGenerator```` add the following function:

	````
	function MoleGenerator.newMole()
		local newMole=display.newImageRect("images/mole_1.png",178,200)
		newMole.x=display.contentCenterX
		newMole.y=display.contentCenterY
		return newMole
	end
	`````

13.  This is just a super simple function to create our mole object and center him.  It probably looks very similar to the code you deleted in Step 5.  At this point, your MoleGenerator.lua file should look like this:
	````
	module(..., package.seeall)

    local MoleGenerator={}
    
        function MoleGenerator.newMole()
    	    local newMole=display.newImageRect("images/mole_1.png",178,200)
		    newMole.x=display.contentCenterX
		    newMole.y=display.contentCenterY
		    return newMole
	    end
        
    return MoleGenerator
    ````
    
14.  Switch back to the `main.lua` file and at the top, add the following lines:
	```
	local MoleGenerator=require("MoleGenerator")
	local myMole=MoleGenerator.newMole()
	```
	
15.  Save and re-launch your project and your friend the mole should be back.

16. To the slides
	
17.  The first thing we want to do is make the mole hidden when the game launches, so change his starting point from `newMole.y=display.contentCenterY` to `newMole.y=display.contentHeight`, this will put the mole's center point at the bottom of the screen (and hide him behind the grass in the front).  Hop over to MoleGenerator.lua and make that change on line 8.
	Change line 8:
	````
	newMole.y=display.contentHeight
	````

18.  Save and re-launch the app and you shouldn't see your mole anymore (you also shouldn't see any errors in the terminal).

19.  Go back to MoleGenerator.lua.  We are going to take this slow and in chunks.  Let's start with just animating the mole coming out of the hole.  After the line `newMole.y=display.contentHeight`, add the following code:
	```
	--Configure how fast our mole will move
    local moleSpeed=5
    local distanceToTravel=newMole.y - display.contentCenterY
    local travelTime=distanceToTravel/(1/moleSpeed)
    ````
    
24.  Okay, let's get this mole moving!  Below those three lines above, add the following code:
	```
	newMole.transition=transition.to(newMole,{
                                                    time=travelTime,
                                                    y=display.contentCenterY,
                                                    
                                                }
                                        )                     
	```
27.  Save and re-launch.  You should now see our little mole buddy pop his head up out of the ground.  

25.  To the slides

29.  Now we need to move the mole back down after he pokes his head up, otherwise he's going to get whacked all the time.  We are going to need to make some changes to our existing code.  First, we will want to put the code that makes the mole move up into a function, so we can call it anytime we need it (and we will need it).

30.  To create the function, wrap the code in the following:
	```
	--a function to move the mole up
    local function moveMoleUp()
        newMole.transition=transition.to(newMole,{
                                                    time=travelTime,
                                                    y=display.contentCenterY,
                                                }
                                        )   
    end
    ```
    
31. We are going to create an equivalent function to move the mole down.  I'm going to create this above the function to move him up and I will explain why in the next step.  So above our "moveMoleUp" function, add the following code:
	```
	--a function to move the mole down
    local function moveMoleDown()
        newMole.transition=transition.to(newMole,{
                                                    time=travelTime,
                                                    y=display.contentHeight
                                                }
                                        )
    end
    ```
    
32. This function creates a new transition object that is performed on `newMole` and sets newMole's y value to the bottom of the screen (also known as `display.contentHeight`)

33. We have two functions in our code now, one to move the mole up and one to move it down.  If you think about the order of things:
	1. Start Game
	2. Mole is hidden
	3. Move mole up
	4. Mole is visible
	5. Move mole down
	6. Repeat steps 2-5
	
34. We will call the moveMoleUp function first and then call the moveMoleDown function once the mole has been moved up.  But how do we know when the mole is visible?  There are two ways, first, we know how long the mole is going to be moving up (it's our variable `travelTime`), so we could call the moveMoleDown function after 2 seconds has passed.  And that would work okay.  But there is a better way.

36. The `transition.to` accepts another parameter called `onComplete`.  This allows you to tell the transition to call a certain function when the transition is done.  If we use that new knowledge we can change the `function moveMoleUp` to the following:
	```
	--a function to move the mole up
    local function moveMoleUp()
        newMole.transition=transition.to(newMole,{
                                                    time=travelTime,
                                                    y=display.contentCenterY,
                                                    onComplete=moveMoleDown
                                                }
                                        )   
    end
    ```
    
37.  Now all we need to do is call our moveMoleUp function and when it completes, it will move the mole back down.  You can do this by adding the line `moveMoleUp()` after the end of the moveMoleUp function.  	
38.  Save and re-launch.  Now our mole buddy is a little smarter.  He pops up and then ducks back down.  But that's it.  We want to repeat this behavior (and maybe randomize it a little).

39. To the slides

39. We are going to create a new function to control when our mole pops up.  Comment out the line that reads `moveMoleUp()` (should be line 35 from above).

40. Add the following function:
	```
	local function randomMoveMole()
          local randomSeconds=math.random(1000,5000)
          timer.performWithDelay(randomSeconds,moveMoleUp)
    end
    randomMoveMole()  
    ```
    
41. Let's talk about what this does.  The first line, `local function randomMoveMole()`, just declares our function, nothing new there.

42. The next line, `local randomSeconds=math.random(1000,5000)`,  uses the `math.random` function to generate a random number between 1,000 and 5,000 (inclusive, inclusive means that it is possible for the function to generate a number equal to 1,000 or equal to 5,000).  Why are these numbers so big?  Because the next line takes a value in miliseconds and there are 1,000 miliseconds in a second, so 1,000ms=1 second.

43. This line, `timer.performWithDelay(randomSeconds,moveMoleUp)`, creates a [timer object](http://docs.coronalabs.com/api/library/timer/performWithDelay.html) that performs a function after a certain delay.  In our case, we are calling our `moveMoleUp` function after the delay.

44. This line, `end` just closes our function from step 41.

45. To the slides!

45. This line, `randomMoveMole()`, calls our new function and causes the mole to start to move after a random number of seconds (between 1 and 5 seconds, inclusive).

46. This is great so far, but it will only happen once.  We need some way of calling our `randomMoveMole` function after the mole hides again. If only there was some argument or parameter we could send to do that after the mole moved down.  Hmmm… thoughts? ideas?  onComplete? Yes! Exactly!

47.  We need to change our `moveMoleDown` function.  But before we change it, it needs to know about our `randomMoveMole` function.  Lua reads from the top of the file to the bottom so when it reads the lines about our `moveMoleDown` function, it has no idea that `randomMoveMole` is further down.  To fix this, above our line that reads `local function moveMoleDown()` we need to add: `local randomMoveMole`:
	```
	 local randomMoveMole
    --a function to move the mole down
    local function moveMoleDown()
    ```
    
48. Now lets add that onComplete parameter to our transition in the `moveMoleDown` function, (**NOTE** Don't forget to add a comma at the end of the line `y=display.contentHeight` to let lua know there is another parameter):
	```
	newMole.transition=transition.to(newMole,{
                                                        time=travelTime,
                                                        y=display.contentHeight,
                                                         onComplete=randomMoveMole
                                                    }
                                            )
	```
	
49. And one last thing before we save, because we told lua about randomMoveMole above `moveMoleDown`, we don't need to call it local when we create the function, so go find the line that looks like this: `local function randomMoveMole()` and change it to this: `function randomMoveMole()`

50.  Save and relaunch and your mole should be moving up and down at random intervals between 1 and 5 seconds. 

51. For fun and feel good points, how do you think you would make the mole change the hole he came out of?  I will give some hints:
	* It should be done in the `function randomMoveMole`.
	* You will need to change the .x value of the newMole object.
                                            

52. To make the mole move to a random hole, add the following code to the `function randomMoveMole()`:
	```
	--randomly select hole
    local randomHole=math.random(1,3)
    if(randomHole==1) then
        newMole.x=200
    elseif(randomHole==2) then
        newMole.x=display.contentCenterX
    elseif(randomHole==3) then
        newMole.x=820
    end
    ```
53. Changing frames, and movie clips.  There is an external library/module called "movieclip.lua" that is included with this project.  This is a library that is available in the Corona forums.  

54. To use this module, we first need to add it to our MoleGenerator.lua so on line 3 add the following line:
	```
	local movieclip = require("movieclip")
	```
	
55. Now we want to replace our mole with a collection of frames:
	```
	local newMole=movieclip.newAnim{"images/mole_1.png", 
            "images/mole_laugh3.png", 
            "images/mole_thump4.png"}
    ```
    
56. The lines above will add three images to our newMole object.  We want to set the initial frame so I'm going to use the `stopAtFrame()` command:
	```
	newMole:stopAtFrame(1)
	```

57. Now we want to detect when we "hit" the mole.  We are going to add a function to detect a "touch" event on the newMole object:
	```
	local function didTouchMole(event)
        if ( event.phase == "began" ) then
            newMole:stopAtFrame( 3 ) -- change to the `mole_thump4.png` frame
            transition.cancel(newMole.transition) --cancel any transition about to happen
            moveMoleDown() --move the mole down immediately
        end
        return true  --prevents propagation to underlying objects
    end
    newMole:addEventListener( "touch", didTouchMole ) --Listen for a "touch" event on the newMole object and then call the function `didTouchMole`
  ```

58. If we change the frame when the mole is whacked, we will want to reset it before he pops back up.  In randomMoveMole(), add the following line:
	```
	--reset mole frame
   newMole:stopAtFrame( 1 )
   ```
  
58. The `event.phase =="began"` checks to make sure we are only working when the touch happens initially, so it won't run when the touch ends (when they lift their finger) or if they hold their finger down, this ensures that it only runs once.

59. Save and re-launch.

59.  Let's add a whacking sound, towards the top of our "newMole()" function, let's load the sound file.  I'm also going to add a laughing sound too for use later:
	```
	local whackSound = audio.loadSound( "whack.wav" )
	local laughSound = audio.loadSound("laugh.wav")
	```
	
60. To play the sound, let's go to our "didTouchMole()" function and add it:
	```
	audio.play(whackSound)
	```
	
61. This is looking really good but I want to add one final touch, I want to add inspiration for whacking this mole.  

62. Let's create a new function that changes the mole's frame to the laughing frame and plays the laughing sound:
	```
	local function moleLaugh()
        newMole:stopAtFrame( 2 ) --go to the laughing frame
        audio.play(laughSound)
        moveMoleDown()
    end
   ```
   
63. Now I'm going to create a timer with a delay so that 'moveMoleDown' isn't called until the mole has been up for 1 second.  Inside 'moveMoleUp()', add the following code at the top:
	```
	local function delayMoveDown()
        newMole.currentTimer=timer.performWithDelay( 1000,moleLaugh,1)  
    end
    ```

64. Then change the call of `onComplete` to `delayMoveDown`:
	```
	newMole.transition=transition.to(newMole,{
                time=travelTime,
                y=display.contentCenterY,
                onComplete=delayMoveDown
            }
    )
    ```
    
65.  One last thing, since we are creating a timer on the mole, we will want to cancel it if we whack the mole, so in `didTouchMole()` add:
	```
	timer.cancel(newMole.currentTimer)
	```