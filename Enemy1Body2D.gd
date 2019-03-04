extends KinematicBody2D

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
var anim


#bitmap player state
var state = 0000

# movement calculation variables
var velocity = Vector2()
var on_air_time = 100
var force = Vector2()



# -----------------------------------------
# movemnet control variables
var walk_left
var walk_right
var jump

func _get_input():
	walk_left = Input.is_action_pressed("LEFT")
	walk_right = Input.is_action_pressed("RIGHT")
	jump = Input.is_action_pressed("JUMP")
# ------------------------------------------

#------------------------------------------
func animator(request):
	var held = anim.current_animation
	if request != held:
		anim.play(request)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _ready():
	anim = get_node("AnimationPlayer")
	pass

func _physics_process(delta): # delta represents the time in which one frame executes (seconds) 
	
	# Create forces
	force = Vector2(0, GRAVITY)

	stop = true
	
	if stop:
		animator("idle")
		var vsign = sign(velocity.x) # sign returns polarity of argument 
		var vlen = abs(velocity.x) # we're calling the abs of the x's magnitude the length
		
		# multiply 
		vlen -= STOP_FORCE * delta
		
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign # use the sign to convert back to original
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1)) # second argument is the decided floor normal 
	                                                    # i.e. up vector of what should be consider
	
	if is_on_floor():
		# zero out air time when on floor
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	on_air_time += delta
	
	print(str(delta))