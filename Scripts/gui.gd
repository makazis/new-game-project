extends Control

@onready var box_container=$HBoxContainer
func _process(delta):
	for panel in box_container.get_children():
		if panel.
