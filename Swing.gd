extends Area2D
const MAX_TIME = 0.02

var swingtime = 0

func _ready():
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	swingtime += delta 

	if swingtime > MAX_TIME:
		queue_free()
