
extends Panel

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/scripts/global")
onready var _audio_player = get_node("SamplePlayer")
onready var _timer = get_node("Timer")

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("play"):
		_start_countdown()

func _start_countdown():
	if _timer.get_time_left() == 0:
		_audio_player.play("play")
		_timer.start()

func _next_scene():
	global.change_level(0)

func _on_btnPlay_pressed():
	_start_countdown()

func _on_Timer_timeout():
	_next_scene()

func _on_btnHowTo_pressed():
	global.change_to_how_to_play()
