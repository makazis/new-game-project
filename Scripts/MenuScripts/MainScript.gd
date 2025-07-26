extends Control

func _on_play_button_down() -> void:
	$Menu_container.move_to = "Play"

func _on_options_button_down() -> void:
	$Menu_container.move_to = "Options"

func _on_exit_button_down() -> void:
	$Menu_container.move_to = "Exit"
