extends Node2D

#This is only for the buildings that require actual 

func _process(delta: float) -> void:
	for i in Global.buildings_2:
		i.per_frame(delta)
var inv_open=true
func _input(event):
	if event.is_action_pressed("inventory"):
		inv_open=not inv_open
		$CanvasLayer/GUI.visible=inv_open
		$CanvasLayer/Inventory.visible=not inv_open
		Global.drag_locked=not inv_open
		$CanvasLayer/Inventory.demiload()
		$CanvasLayer/GUI.demiload()
