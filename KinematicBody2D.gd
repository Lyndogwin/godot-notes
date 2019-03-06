extends KinematicBody2D

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
# scene preloads
const SWORD = preload("res://swordattack.tscn")

# player states
var jumping = false
var on_air_time = 100
var prev_jump_pressed = false
var stop
var anim
var sprite 


#bitmap player state
var state = 0000

# position variables
var velocity = Vector2()
var force = Vector2()
var direction = 1
var forward 


# movement control variables
var walk_left
var walk_right
var jump
var attack

func _get_input():
	walk_left = Input.is_action_pressed("LEFT")
	walk_right = Input.is_action_pressed("RIGHT")
	jump = Input.is_action_pressed("JUMP")
	attack = Input.is_action_just_pressed("ATTACK")
# ------------------------------------------

func animator(request):
	var held = anim.current_animation
	if request != held:
		anim.play(request)
# ------------------------------------------

func _ready():
	sprite = get_node("Sprite")
	anim = get_node("AnimationPlayer")
	
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func move(delta):
	
	# ***while input is false***
	stop = true

	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			animator("run")
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			animator("run")
			force.x += WALK_FORCE
			stop = false
	
	# flip sprite based on direction
	if velocity.x > 0:
		direction = 1
		sprite.flip_h = false
	elif velocity.x < 0:
		direction = -1
		sprite.flip_h = true
	
	if stop:
		animator("idle")
		var vsign = sign(velocity.x) # sign returns polarity of argument (-1 or 1)
		var vlen = abs(velocity.x) # we're calling the abs of the x's magnitude the length
	
		# multiply 
		vlen -= STOP_FORCE * delta
		
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign # use the sign to convert back to original dir

func attack():
	forward = get_node("Position2D").global_position
	if attack:
		var sword = SWORD.instance()
		get_parent().add_child(sword)
		sword.direction(direction)
		sword.position = forward

func _physics_process(delta): # delta represents the time in which one frame executes (seconds) 
	
	# Create forces
	force = Vector2(0, GRAVITY)
	# grab input
	_get_input()

	move(delta)
	attack()
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1)) # second argument is the decided floor normal 
	                                                    # i.e. up vector of what should be considered floor
	
	if is_on_floor():
		# zero out air time when on floor
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
	
	#print(str(delta))