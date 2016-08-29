
extends Area2D

export var current_level_id = 0

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/scripts/global")
onready var _audio_player = get_node("SamplePlayer")
onready var _timer = get_node("Timer")

func _on_exit_door_body_enter( body ):
	if body.get_groups().has("player"):
		_audio_player.play("next_level")
		_timer.start()

func _on_Timer_timeout():
	global.change_to_next_level(current_level_id)
