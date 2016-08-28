
extends KinematicBody2D

const GRAVITY = 1000.0
const MOVE_SPEED = 220.0
const JUMP_FORCE = 380.0

var is_facing_right = true
var is_grounded = false
var is_climbing = false
var is_using_hook = false

var motion = Vector2()
var velocity = Vector2()
var move_dir = Vector2()

onready var _raycast = get_node("RayCast2D")

func _ready():
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action_pressed("hook"):
		is_using_hook = true
	elif event.is_action_released("hook"):
		is_using_hook = false

func _process(delta):
	if Input.is_action_pressed("move_left"):
		move_dir.x = -1.0
		if not is_using_hook and is_facing_right:
			is_facing_right = !is_facing_right
			set_scale(Vector2(-1.0, 1.0))
	elif Input.is_action_pressed("move_right"):
		move_dir.x = 1.0
		if not is_using_hook and not is_facing_right:
			is_facing_right = !is_facing_right
			set_scale(Vector2(1.0, 1.0))
	else:
		move_dir.x = 0.0
	
	if Input.is_action_pressed("move_up"):
		move_dir.y = -1.0
	elif Input.is_action_pressed("move_down"):
		move_dir.y = 1.0
	else:
		move_dir.y = 0.0

func _fixed_process(delta):
	is_grounded = _raycast.is_colliding()
	velocity.x = move_dir.x * MOVE_SPEED
	
	if is_climbing:
		velocity.y = 0.0
	else:
		velocity.y += GRAVITY * delta
	
	if is_grounded and Input.is_action_pressed("jump"):
		velocity.y = -JUMP_FORCE
	
	motion = velocity * delta
	move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		velocity = n.slide(velocity)
		motion = n.slide(motion)
		move(motion)
