extends KinematicBody2D

# class member variables go here, for example:

const gravity = 500
const speed = 250
var velocity = Vector2()
var force = Vector2()
var airtime = 20
var grounded 

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
	
func getinput():
	velocity.x = 0
	#velocity.y = 0
	var jump = Input.is_action_pressed("JUMP") 
	var right = Input.is_action_pressed("RIGHT")
	var left = Input.is_action_pressed("LEFT")
	
	# inputs work
	if jump and grounded:
		velocity.y -= 1 
		airtime = 0
		print("jump")
	if right:
		velocity.x += 1
		print("right")
	if left:
		velocity.x -= 1
		print("left")
	# look up normalized
	velocity = velocity.normalized() * speed
	
	
func _physics_process(delta):
	# the second arguement in the mov_and_slide function
	# call is the normal vector of collision bodies considered
	# by the programmer to be a floor
	force = Vector2(0, gravity)
	getinput()
	move_and_slide(velocity, Vector2(0,-1))
	
	grounded = is_on_floor()
	# simulated gravity
	
	#if grounded:
		#velocity.y = 0.1
	#else:
		#airtime += 1
		#velocity.x *= 10
		#if airtime > 20:
			#velocity.y += 1 * speed
	
	#print("X-axis velocity is " + str(velocity.x))
	print("Y-axis velocity is " + str(velocity.y))
	print(str(is_on_floor()))

