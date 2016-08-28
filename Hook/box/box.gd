
extends KinematicBody2D

const GRAVITY = 200.0
const PUSH_FORCE = 10.0

var velocity = Vector2()
var motion = Vector2()
var move_dir = Vector2()
var is_using_hook = false

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.y += GRAVITY * delta
	velocity.x = move_dir.x * PUSH_FORCE
	
	motion = velocity * delta
	move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func _on_left_body_enter( body ):
	if body.get_groups().has("player"):
		move_dir.x = 1.0

func _on_left_body_exit( body ):
	if body.get_groups().has("player"):
		move_dir.x = 0.0

func _on_right_body_enter( body ):
	if body.get_groups().has("player"):
		move_dir.x = -1.0

func _on_right_body_exit( body ):
	if body.get_groups().has("player"):
		move_dir.x = 0.0
