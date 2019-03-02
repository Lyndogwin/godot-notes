extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

# This demo shows how to build a kinematic controller.

# Member variables
const GRAVITY = 1000.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 400
const STOP_FORCE = 3000
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = 0.2
# not used yet
const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

# player states
var jumping = false
var prev_jump_pressed = false
var stop
var state

var ani = {walking : "walking", idle : "idle", jumping : "jumping"}

# movement variables
var velocity = Vector2()
var on_air_time = 100
var force = Vector2()



# -----------------------------------------
# input variables
var walk_left
var walk_right
var jump

func _get_input():
	walk_left = Input.is_action_pressed("LEFT")
	walk_right = Input.is_action_pressed("RIGHT")
	jump = Input.is_action_pressed("JUMP")
# ------------------------------------------

func _physics_process(delta): # delta represents the time in which one frame executes (seconds) 
	# Create forces
	force = Vector2(0, GRAVITY)
	
	_get_input()
	
	stop = true
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		# multiply 
		vlen -= STOP_FORCE * delta
		
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1)) # second argument is the decided floor normal 
	                                                    # i.e. up vector of what should be consider
	
	if is_on_floor():
		
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump
	
	print(str(delta))