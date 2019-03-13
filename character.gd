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

# @ essential node variables
var anim                   ##
var sprite                 ##
#############################

 # @ Functionality references
func animator(request):
    var held = anim.current_animation
    if request != held:
        anim.play(request)
# -----------------------------


# @ Functions to execute at runtime

func _ready():
    # use default node names for essential nodes 
    var anim = get_node("AnimationPlayer")
    var sprite = get_node("Sprite")