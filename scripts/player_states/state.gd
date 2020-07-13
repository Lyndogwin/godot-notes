extends "../player_traits.gd"

signal finished(next_state_name)

# Initialize the state. E.g. change the animation
func enter():
    print("entering new state")
    return

# clean up ther state. Reinitialize values like a timer
func exit():
    print("exiting state")
    return

func handle_input(event):
    return

func update(delta):
    return

func _on_animation_finished(anime_name):
    return