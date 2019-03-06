extends KinematicBody2D

const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 400
const STOP_FORCE = 3000
const JUMP_SPEED = 400
const JUMP_MAX_AIRBORNE_TIME = 0.2
# not used yet
const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel