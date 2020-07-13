extends "physics_traits.gd"

export(float) var AIR_ACCELERATION = 1000.0
export(float) var AIR_DECELERATION = 2000.0
export(float) var AIR_STEERING_POWER = 50.0

export(float) var JUMP_HEIGHT = 120.0
export(float) var JUMP_DIRATION = 0.8

export(float) var BASE_MAX_HORIZONTAL_SPEED = 400.0

export(float) var max_horizontal_speed = 0.0
export(float) var horizontal_speed = 0.0
export var horizontal_velocity = Vector2()

export(float) var vertical_speed = 0.0
export(float) var height = 0.0

export var velocity = Vector2()

export(float) var speed = 0.0