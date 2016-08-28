
extends Panel

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/scripts/global")

func _on_btnBackToMainMenu_pressed():
	global.change_to_mainmenu()
