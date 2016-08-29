
extends StaticBody2D

var is_picked = false
onready var _audio_player = get_node("SamplePlayer")

func _on_Area2D_body_enter( body ):
	if body.get_groups().has("player"):
		if not is_picked:
			is_picked = true
			_audio_player.play("pickup_coin")
			hide()