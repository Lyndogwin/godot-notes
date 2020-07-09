extends "../state.gd"

func handle_input(event):
    return

func get_input_direction():
    var input_direction() = Vector2()
    input_direction.x = int(Input.is_action_pressed("RIGHT")) - int(Input.is_action_pressed("LEFT"))

func update_look_dirrection(direction):
    if direction and owner.look_direction != direction:
        owner.look_direction = direction

    if not direction.x in [-1, 1]:
        return

    owner.get_node("ForwardPivot").set_scale(Vector2(direction.x,1))