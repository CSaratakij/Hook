
extends Panel

onready var tree = get_tree()
onready var player_camera = tree.get_nodes_in_group("player_camera")

func _ready():
	hide()
	set_process(true)

func _process(delta):
	if tree.is_paused():
		if not player_camera.empty():
			var half_rect_size = get_size() / 2
			var offset = player_camera[0].get_camera_screen_center() - half_rect_size
			set_global_pos(offset)
			show()
	else:
		hide()