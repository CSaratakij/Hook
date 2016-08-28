
extends Sprite

const PULL_FORCE = 240.0

var move_dir = Vector2()
var current_aim_box
var current_collide_name = ""
var box_global_pos
var arrow_target_pos

onready var max_rope_point = get_node("max_rope_point")
onready var ropes = get_node("ropes").get_children()
onready var  arrow = get_node("arrow")

func _ready():
	for rope in ropes:
		rope.hide()
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action_released("hook"):
		_hide_ropes()
		arrow.set_pos(Vector2(0.0, 0.0))

func _fixed_process(delta):
	if Input.is_action_pressed("hook"):
		var hookshot_global_pos = get_global_pos()
		
		if current_aim_box != null:
			_show_ropes()
			box_global_pos = current_aim_box.get_global_pos()
			arrow_target_pos = current_aim_box.get_pos()
			
			if hookshot_global_pos.x > box_global_pos.x:
				move_dir.x = 1.0
				arrow_target_pos.x -= 24.0
			else:
				move_dir.x = -1.0
				arrow_target_pos.x += 24.0
			
			arrow_target_pos.y = arrow.get_global_pos().y
			arrow.move_to(arrow_target_pos)
			
			current_aim_box.move(move_dir * PULL_FORCE * delta)
		else:
			if current_collide_name != "TileMap":
				_show_ropes()
				arrow_target_pos = max_rope_point.get_global_pos()
				arrow.move_to(arrow_target_pos)
			else:
				_hide_ropes()
				arrow.set_pos(Vector2(0.0, 0.0))

func _show_ropes():
	for rope in ropes:
		if rope.is_hidden():
			rope.show()
		else:
			continue

func _hide_ropes():
	for rope in ropes:
		if not rope.is_hidden():
			rope.hide()
		else:
			continue

func _on_Area2D_body_enter( body ):
	current_collide_name = body.get_name()
	if body.get_groups().has("box"):
		current_aim_box = body

func _on_Area2D_body_exit( body ):
	current_collide_name = ""
	if body.get_groups().has("box"):
		current_aim_box = null
