extends Control

func demiload():
	for i in Global.Player_Inventory:
		if Global.Player_Inventory[i]==null:
			continue
		if i<9:
			$"BoxContainer/Inv Row 1".get_child(i).button.update_item(Global.Player_Inventory[i])
		elif i<18:
			$"BoxContainer/Inv Row 2".get_child(i-9).button.update_item(Global.Player_Inventory[i])
		else:
			$"BoxContainer/Inv Row 3".get_child(i-18).button.update_item(Global.Player_Inventory[i])
	for i in Global.Player_hotbar:
		if Global.Player_Inventory[i]==null:
			continue
		$BoxContainer/Hotbar.get_child(i).button.update_item(Global.Player_hotbar[i])
