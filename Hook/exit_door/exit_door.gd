
extends Area2D

export var current_level_id = 0

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/scripts/global")

func _on_exit_door_body_enter( body ):
	if body.get_groups().has("player"):
		global.change_to_next_level(current_level_id)
