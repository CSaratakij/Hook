
extends Panel

const NEXT_SCENE = "res://level/level.tscn"
onready var tree = get_tree()

func _on_btnPlay_pressed():
	tree.change_scene(NEXT_SCENE)