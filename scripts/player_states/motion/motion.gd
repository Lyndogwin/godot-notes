extends "../state.gd"

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
