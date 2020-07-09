extends Area2D
const MAX_TIME = 0.02

var swingtime = 0
var direction 
var sprite
var collisionshape


func _ready():
	sprite = get_node("Sprite_container")
	collisionshape = get_node("CollisionShape2D")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func direction(dir):
	direction = dir
	if dir > 0:
		sprite.flip_h = false 
	elif dir < 0:
		sprite.flip_h = true


func _physics_process(delta):
	swingtime += delta 

	if swingtime > MAX_TIME:
		queue_free()

func _on_Swing_body_entered(body):
	if "Enemy1" in body.name:
		body.die()

