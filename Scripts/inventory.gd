extends Control

func demiload():
	for i in Global.Player_Inventory:
		print(i.ID," ",i.item_count)
