extends KinematicBody2D

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

# @ bitmap player state

const IDLE : int =        0
const RUNNING : int =     1     
const IN_AIR : int =      2   
const JUMPING : int =     4  
const LAUNCHED : int =    8 
const DAMAGED : int =     16    
const STAGGERED : int =   32
const DODGE : int =       64  
const DIR : int =         128 # a binary definition for the direction  

var state = IDLE      
#############################

# @ utility variables 
var  timer                 ##
#############################

# @ character attributes
var hp                     ## character hit points
var strength               ## character damage modifier for power weapons
var dexterity              ## character damage modifier for skill weapons
var endurance              ## character resistance to melee
var resist                 ## character resistence to range
var luck                   ## character probability modifier to land crits 
var instinct = 0           ## measure of player skill
var exp                    ## experience of the player
#############################

# @ essential node (object) variables
var Anim                   ## to store animation player    
var Sprite                 ## 
var Forward                ## to store Position2D node
var MeleeRange             ## 
#############################

 # @ Functionality 
#------------------------------------
func _get_input():
	walk_left = Input.is_action_pressed("LEFT")
	walk_right = Input.is_action_pressed("RIGHT")
	jump = Input.is_action_pressed("JUMP")
	attack = Input.is_action_just_pressed("ATTACK")
	
func animator(request):
	var held = anim.current_animation
	if request != held:
		anim.play(request)
# -----------------------------
# @ utility functions
func print_timer(sub,delta):
	timer += delta
	if timer > 0.5:
		print(sub)
		timer = 0
# --------------------------------------------

# @ Functions to execute at runtime
func _ready():
	# use default node names for these essential nodes 
	Anim = get_node("AnimationPlayer")
	Sprite = get_node("Sprite")
	# use non-default node names for these essential nodes
	Forward = get_node("ForwadPosition2D") # Type: Position2D node
	MeleeRange = get_node("MeleeRange") # Type: Area2D
		# connect signals to from MeleeRange
	# connect signal => connect("signalname", object_to_listen, "full_signal_name")
	MeleeRange.connect("body_entered", self, "_on_MeleeRange_body_entered")
	MeleeRange.connect("body_exited", self, "_on_MeleeRange_body_exited")

func move(delta):
	var prev_dir &= DIR 
	state &= IDLE 
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			state |= RUNNING
		state |= (DIR ^ DIR)
		animator("run")
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			state |= RUNNING 
		state |= DIR 
		animator("run")
