var look_direction =  Vector2(1,0) setget set_look_direction

var states_stack = []
var current_state = null

onready var states_map {
    "idle" : $States/Idle,
    "move": $States/Move,
    "jump": $States/Jump,
    "attack": $States/Attack,
    "falling": $States/Falling
}

func_ready():
    for state_node in $states.get_children():
        state.node.connect("finished", self, "_change_state")

    states_stack.push_front($States/Idle)
    current_state = states_stack[0]
    _change_state("idle")

# the state machine delegates process and input callbacks to the current state
# the state object  3e.g. Moce, then handles input, calcylates velocity
# and move what I callled its "host", the player node (KinematicBody2D) in this case.
func _physics_process(delta):
    current_state.update(delta)

func _input(event):
    if event.is_action_pressed("ATTACK"):
        if current_state ==  $States/Attack:
            return
        _change_state("attack")
        return

    current_state.handle_input(event)

func _on_animation_finished(anim_name):
    current_state._on_animation_finished(anim_name)

func _change_state(state_name):
    """
        1. clean up current state with its exit method
        2. manage the flow and the history of states
        3. Initialize the new state with its enter method
    """

    current_state.exit()

    if state_name == "previous":
        states_stack.pop_front()
    elif state_name in ["jump", "attack", "falling"]:
        states_stack.push_front(states_map[state_name])
    elif state_name == "dead":
        queue_free()
        return
    else:
        var new_state = states_map[state_name]
        states_stack[0] = new_state
    
    if state_name == "jump":
        $States/Jump.initialize(current_state.speed, current_state.velocity)

    current_state = states_stack[0]
    if state_name != "previous":
        #we don't want to reinitialize the state if we're goin back to the previous state
        current_state.enter()
    emit_signal("state_changed", states_stack)

    func take_damage(attacker, amount, effect=null):
        pass

    func set_dead(value):
        pass
    
    func set_look_direction(value):
        look_direction =  value
        emit_signal("direction_changed", value)

