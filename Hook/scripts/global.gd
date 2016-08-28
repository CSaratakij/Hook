
extends Node2D

const HOW_TO_PLAY = "res://menu/control_menu.tscn"
const MAINMENU = "res://menu/mainmenu.tscn"
const THANK_YOU_FOR_PLAYING = "res://menu/gameover.tscn"
const LEVELS = [
	"res://level/level.tscn"
	]

var is_over = false

onready var tree = get_tree()

func game_start():
	is_over = false

func game_over():
	is_over = true

func is_game_over():
	return is_over

func change_to_how_to_play():
	tree.change_scene(HOW_TO_PLAY)

func change_to_mainmenu():
	tree.change_scene(MAINMENU)

func change_level(level_id):
	tree.change_scene(LEVELS[level_id])
	
func change_to_next_level(current):
	if current < LEVELS.size() -1:
		tree.change_scene(LEVELS[current - 1])
	else:
		tree.change_scene(THANK_YOU_FOR_PLAYING)
