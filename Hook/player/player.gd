
extends KinematicBody2D

const GRAVITY = 1000.0
const MOVE_SPEED = 180.0
const JUMP_FORCE = 380.0

var is_grounded = false
var is_climbing = false

var motion = Vector2()
var velocity = Vector2()
var move_dir = Vector2()

onready var _sprite = get_node("Sprite")
onready var _raycast = get_node("RayCast2D")

func _ready():
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	if Input.is_action_pressed("move_left"):
		move_dir.x = -1.0
		if not _sprite.is_flipped_h():
			_sprite.set_flip_h(true)
			
	elif Input.is_action_pressed("move_right"):
		move_dir.x = 1.0
		if _sprite.is_flipped_h():
			_sprite.set_flip_h(false)
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
