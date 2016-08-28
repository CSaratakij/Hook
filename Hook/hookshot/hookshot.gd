
extends Sprite

const ROPE_LENGTH = 30
const PULL_FORCE = 240.0

var current_aim_box
var current_rigid_box
var current_collide_name = ""
var move_dir = Vector2()
var box_global_pos
var arrow_target_pos

onready var max_rope_point = get_node("max_rope_point")
onready var ropes = get_node("ropes")
onready var  arrow = get_node("arrow")

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action_released("hook"):
		arrow.set_pos(Vector2(0.0, 0.0))

func _fixed_process(delta):
	if Input.is_action_pressed("hook"):
		var hookshot_global_pos = get_global_pos()
				
		if current_aim_box != null:
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
				arrow_target_pos = max_rope_point.get_global_pos()
				arrow.move_to(arrow_target_pos)
			else:
				arrow.set_pos(Vector2(0.0, 0.0))

func _on_Area2D_body_enter( body ):
	current_collide_name = body.get_name()
	if body.get_groups().has("box"):
		current_aim_box = body

func _on_Area2D_body_exit( body ):
	current_collide_name = ""
	if body.get_groups().has("box"):
		current_aim_box = null
