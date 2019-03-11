extends Position2D

var direction = 1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func direction(dir):
	if direction != dir:
		direction = dir
		position.x *= -1 
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
