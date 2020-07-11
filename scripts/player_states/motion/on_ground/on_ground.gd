extends "../motion.gd"

func handle_input(event):
	if event.is_action_pressed("JUMP"):
		emit_signal("finished", "jump")

	return .handle_input(event)
