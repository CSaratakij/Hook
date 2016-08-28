
extends Panel

const NEXT_SCENE = "res://level/level.tscn"
onready var tree = get_tree()

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("play"):
		tree.change_scene(NEXT_SCENE)

func _on_btnPlay_pressed():
	tree.change_scene(NEXT_SCENE)