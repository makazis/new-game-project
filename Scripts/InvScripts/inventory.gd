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
	if first_load:
		load_element("Water")
		first_load=false
var first_load=true
var mouse_timer=0
var mouse_debounce = false
var animation={
	"Type":"None"
} #Only one animation at a time
var menu_pos=Vector2(0,0)
var menus=[
	Vector2(0,0),
	Vector2(1,0)
]
func _process(delta: float) -> void:
	
	if animation["Type"]!="None":
		if animation["Type"]=="Moving":
			animation["Time Left"]-=delta
			if animation["Time Left"]<=0:
				position=animation["New Pos"]
				animation={
					"Type":"None"
				}
			else:
				var pos_q=(cos(animation["Time Left"]/animation["Total Time"]*PI)+1)/2
				position=animation["Old Pos"]*(1-pos_q)+animation["New Pos"]*(pos_q)
	else:
		if menu_pos==Vector2(0,0):
			if Global.ctimer==2:
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
			Tbutton.position=get_viewport().get_mouse_position()+Vector2(0,20)+position
			
var numicon_containter=preload("res://Scenes/menu/num_icon_container.tscn")
func load_element(element):
	var element_ID=Global.liquid_map_name_to_id[element]
	if element in Global.known_liquids:
		$"Second Menu/Panel/Name".text=element
		$"Second Menu/Panel/Sprite2D".region_rect=Rect2(element_ID%16*16,(element_ID/16)*16,16,16)
	else:
		$"Second Menu/Panel/Name".text="???"
		$"Second Menu/Panel/Sprite2D".region_rect=Rect2(240,240,16,16)
	
	
	for child in $"Second Menu/Panel/Made By Container/VBoxContainer".get_children():
		child.queue_free()
	for reaction in Global.liquid_created_map[element]:
		var new_panel=numicon_containter.instantiate()
		$"Second Menu/Panel/Made By Container/VBoxContainer".add_child(new_panel)
		new_panel.setup(reaction)
	
	for child in $"Second Menu/Panel/Makes Container/VBoxContainer".get_children():
		child.queue_free()
	for reaction in Global.liquid_makes_map[element]:
		var new_panel=numicon_containter.instantiate()
		$"Second Menu/Panel/Makes Container/VBoxContainer".add_child(new_panel)
		new_panel.setup(reaction)
		
		

func _input(event: InputEvent) -> void:
	if animation["Type"]=="None" and Global.drag_locked:
		if event.is_action_pressed("menu_right"):
			if menu_pos+Vector2(1,0) in menus:
				menu_pos+=Vector2(1,0)
				animation={
				"Type":"Moving",
				"Old Pos":position,
				"New Pos":position-Vector2(640,0),
				"Time Left":0.2,
				"Total Time":0.2
			}
		if event.is_action_pressed("menu_left"):
			if menu_pos+Vector2(-1,0) in menus:
				menu_pos+=Vector2(-1,0)
				animation={
				"Type":"Moving",
				"Old Pos":position,
				"New Pos":position-Vector2(-640,0),
				"Time Left":0.2,
				"Total Time":0.2
			}
		if event.is_action_pressed("menu_down"):
			if menu_pos+Vector2(0,1) in menus:
				menu_pos+=Vector2(0,1)
				animation={
				"Type":"Moving",
				"Old Pos":position,
				"New Pos":position-Vector2(0,360),
				"Time Left":0.2,
				"Total Time":0.2
			}
		if event.is_action_pressed("menu_up"):
			if menu_pos+Vector2(0,-1) in menus:
				menu_pos+=Vector2(0,-1)
				animation={
				"Type":"Moving",
				"Old Pos":position,
				"New Pos":position-Vector2(0,-360),
				"Time Left":0.2,
				"Total Time":0.2
			}
	
