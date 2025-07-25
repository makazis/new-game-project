extends Control

@onready var box_container=$HBoxContainer

var mouse_timer = 0
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_timer+=1
	else:
		mouse_timer=0
	if mouse_timer==2:
		for panel in box_container.get_children():
			if panel.button.is_pressed():
				#THX kazimir
					if panel.button.item!=null:

						print(panel.button.item.ID)
						pass

func demiload():
	for i in Global.Player_hotbar.size():
		$HBoxContainer.get_child(i).button.clear_item()
		if Global.Player_hotbar[i]==null:
			continue
		
		$HBoxContainer.get_child(i).button.update_item(Global.Player_hotbar[i])
