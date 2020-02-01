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
var state = 00000000       ##
const START = 00000000     ##
const IN_AIR = 00000001    ##
const JUMPING = 00000010   ##
const LAUNCHED = 10000000  ##
const DAMAGED = 01000000   ##
const STAGGERED = 00100000 ##
const DIR_LEFT = 00010000  ##
const DIR_RIGHT = 00001000 ##
#############################

# @ utility variables 
var  timer                 ##
#############################

# @ character attributes
var hp                     ## character hit points
var exp                    ## experience
var strength               ## character damage modifier for power weapons
var dexterity              ## character damage modifier for skill weapons
var endurance              ## character resistance to melee
var foresight              ## character resistence to range
var luck                   ## character probability modifier to land crits 
var instinct = 0           ## measure of player skill
#############################

# @ essential node (object) variables
var Anim                   ## to store animation player    
var Sprite                 ## 
var Forward                ## to store Position2D node
var MeleeRange             ## 
#############################

# @ character interaction
var characers_in_range = []
#------------------------------

 # @ Functionality 
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
func die():
    queue_free()

func take_damage(damage,type):
    var true_damage
    if type == "melee":
        true_damage = damage - endurance # *** Implement a better equation
    elif type == "range":
        true_damage = damage - foresight
	hp -= true_damage
	print(str(self.name) + " Took " + str(true_damage) + " points of damage!")
	if hp <= 0: 
        die()
        
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