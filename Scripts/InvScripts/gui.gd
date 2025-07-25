extends Control

@onready var box_container=$HBoxContainer

func _process(delta):
	for panel in box_container.get_children():
		if panel.button.is_pressed:
			if panel.button.item!=null:
				pass
				#print(panel.button.item.item_name)

func demiload():
	for i in Global.Player_hotbar:
		$HBoxContainer.get_child(i).button.clear_item()
		if Global.Player_hotbar[i]==null:
			continue
		
		$HBoxContainer.get_child(i).button.update_item(Global.Player_hotbar[i])
