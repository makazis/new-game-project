extends Control
@onready var Tbutton=$TextureButton
func demiload():
	for i in Global.Player_Inventory.size():
		if Global.Player_Inventory[i]==null:
			continue
		if i<9:
			$"BoxContainer/Inv Row 1".get_child(i).button.update_item(Global.Player_Inventory[i])
		elif i<18:
			$"BoxContainer/Inv Row 2".get_child(i-9).button.update_item(Global.Player_Inventory[i])
		else:
			$"BoxContainer/Inv Row 3".get_child(i-18).button.update_item(Global.Player_Inventory[i])
	
	for i in Global.Player_hotbar.size():
		$BoxContainer/Hotbar.get_child(i).button.clear_item()
		if Global.Player_hotbar[i]==null:
			continue
		$BoxContainer/Hotbar.get_child(i).button.update_item(Global.Player_hotbar[i])
			
var mouse_timer=0
var mouse_debounce = false
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not mouse_debounce:
			mouse_debounce = true
			for container_iter in get_child(0).get_children().size():
				var container=get_child(0).get_children()[container_iter]
				for panel_iter in container.get_children().size():
					var panel=container.get_children()[panel_iter]
					if panel.button.button_pressed:
						if panel.button.item==null:
							if Tbutton.visible:
								panel.button.update_item(Tbutton.item)
								if container_iter<3:
									Global.Player_Inventory[container_iter*9+panel_iter]=Tbutton.item
								else:
									Global.Player_hotbar[panel_iter]=Tbutton.item
								Tbutton.clear_item()
								Tbutton.visible=false
						else:
							if not Tbutton.visible:
								Tbutton.update_item(panel.button.item)
								if container_iter<3:
									Global.Player_Inventory[container_iter*9+panel_iter]=null
								else:
									Global.Player_hotbar[panel_iter]=null
								
								panel.button.clear_item()
								Tbutton.visible=true
	else:
		mouse_debounce = false
	Tbutton.position=get_viewport().get_mouse_position()+Vector2(0,20)
