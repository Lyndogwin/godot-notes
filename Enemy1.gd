extends KinematicBody2D

const GRAVITY = 1000.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const FLOOR = Vector2()
const WALK_FORCE = 10
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const STOP_FORCE = 3000
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = 0.2
# not used yet
const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

# movement variables
var velocity = Vector2()
var force = Vector2()
var dir = 1

# sprite visual
var sprite


func move():
	var fall_check = get_node("ledgeCheck")
	print(str(fall_check.is_colliding()))
	
	if fall_check.is_colliding() == false:
		dir *= -1
		sprite.flip_h = true
		fall_check.position.x *= -1
		print(str(fall_check.position.x))

		velocity.x = 0
	
	force.x += WALK_FORCE * dir

	if dir == 1:
		sprite.flip_h = false
	

func _ready():
	sprite = get_node("Sprite")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	force = Vector2(0, GRAVITY)
	move()
	#TODO: ADD MOVEMENT FUNTION

	velocity += force * delta

	velocity = move_and_slide(velocity,FLOOR)

