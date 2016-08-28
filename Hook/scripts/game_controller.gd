
extends Node

onready var tree = get_tree()

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("quit"):
		tree.set_pause(!tree.is_paused())
