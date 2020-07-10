extends Position2D

var direction = 1
var previous_dir = 1

var attack_range
var sprite

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	attack_range = get_node("SwordRange")
	sprite = owner.get_node("Sprite")
	pass

func sprite_flip(previous_dir):
	if previous_dir != direction:
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true

func direction(dir):
	if direction != dir:
		direction = dir
		position.x *= -1 

	attack_range.direction(dir)
	
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	sprite_flip(previous_dir)
	previous_dir = direction
