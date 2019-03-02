extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 250
var velocity = Vector2()
var gravity = .9
var grounded = is_on_floor()

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
	if jump and is_on_floor():
		velocity.y -= 1
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
	getinput()
	move_and_slide(velocity, Vector2(0,-1))
	
	# simulated gravity
	if grounded:
		velocity.y += 0.01
	else: 
		velocity.y = 1
	
	#print("X-axis velocity is " + str(velocity.x))
	print("Y-axis velocity is " + str(velocity.y))
	print(str(is_on_floor()))

