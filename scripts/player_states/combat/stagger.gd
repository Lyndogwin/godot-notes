extends "../state.gd"

var knockback_direction = Vector2()

func enter():
	owner.get_node("AnimationPlayer").play("idle")

func _on_animation_finished(anim_name):
	emit_signal("finished", "previous")