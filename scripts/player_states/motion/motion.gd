extends "../state.gd"

export(float) var BASE_MAX_HORIZONTAL_SPEED = 400.0

export(float) var AIR_ACCELERATION = 1000.0
export(float) var AIR_DECELERATION = 2000.0
export(float) var AIR_STEERING_POWER = 50.0

export(float) var JUMP_HEIGHT = 120.0
export(float) var JUMP_DIRATION = 0.8

export(float) var GRAVITY = 1600.0

var FLOOR_NORMAL = Vector2(0,-1)

var speed = 0.0

var force = Vector2(0, GRAVITY)
var velocity = Vector2()


onready var pivot = owner.get_node("ForwardPivot")


func handle_input(event):
	if event.is_action_pressed("SIMULATE_DAMAGE"):
		emit_signal("finished", "stagger")

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("RIGHT")) - int(Input.is_action_pressed("LEFT"))
	return input_direction

func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction

	if not direction.x in [-1, 1]:
		return
	
	pivot.set_scale(Vector2(direction.x, 1))
	#owner.get_node("ForwardPivot").set_scale(Vector2(direction.x,1))

func _physics_process(delta):
	velocity += force * delta
	velocity = owner.move_and_slide(velocity, FLOOR_NORMAL)
