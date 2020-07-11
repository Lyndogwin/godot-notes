extends "../state.gd"

func enter():
    owner.get_node("AnimationPlayer").play("attack")

func _on_sword_attack_finished():
    emit_signal("finished", "previous")