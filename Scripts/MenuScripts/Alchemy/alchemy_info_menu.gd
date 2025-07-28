extends Node2D

func _input(event):
	if event.is_action_pressed("Alchemy Menu"):
		get_tree().current_scene=Global.game
