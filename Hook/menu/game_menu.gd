
extends Panel

const MAINMENU_PATH = "res://menu/mainmenu.tscn"

onready var tree = get_tree()
onready var player_cameras = tree.get_nodes_in_group("player_camera")

func _ready():
	hide()
	set_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action("quit") and event.is_pressed() and not event.is_echo():
		tree.set_pause(!tree.is_paused())
		if is_hidden() and not player_cameras.empty():
			var half_rect_size = get_size() / 2
			var offset = player_cameras[0].get_camera_screen_center() - half_rect_size
			set_global_pos(offset)
			show()
		else:
			hide()

func _on_btnResume_pressed():
	hide()
	tree.set_pause(false)

func _on_btnRestart_pressed():
	tree.reload_current_scene()
	tree.set_pause(false)

func _on_btnBackToMainMenu_pressed():
	tree.set_pause(false)
	tree.change_scene(MAINMENU_PATH)

func _on_btnQuit_pressed():
	tree.quit()
