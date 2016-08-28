
extends Panel

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/scripts/global")

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("play"):
		_next_scene()

func _on_btnPlay_pressed():
	_next_scene()
	
func _next_scene():
	global.change_level(0)