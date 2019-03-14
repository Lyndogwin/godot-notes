# Understanding Godot

### First things first - Viewport
Make sure the project is utilizing the viewport under the project settings in the godot editor

### Utilized signal connections, emmitions, and such
This is the primary method of getting game objects to communicate with eachother 

### 2D move_and_slide
move_and_slide is the engine standard for simulating 2D physics. Utilizing the method is one of the bigger learning curves if you want to make a responsive game. The function will simulate friction so having large movement forces on a kinematic body is going to save some frustration in the long run.