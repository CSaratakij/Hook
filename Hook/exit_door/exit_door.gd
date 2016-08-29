
extends KinematicBody2D

const GRAVITY = 100.0

export var current_level_id = 0

var velocity = Vector2()
var motion = Vector2()

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/scripts/global")
onready var _audio_player = get_node("SamplePlayer")
onready var _timer = get_node("Timer")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	velocity.y += GRAVITY * delta
	motion = velocity * delta
	move(motion)
	
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func _on_Timer_timeout():
	global.change_to_next_level(current_level_id)

func _on_Area2D_body_enter( body ):
	if body.get_groups().has("player"):
		_audio_player.play("next_level")
		_timer.start()
