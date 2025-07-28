extends Control

@onready var box_container=$HBoxContainer
@onready var Tbutton=$TextureButton
@onready var deletor=$HBoxContainer/Deletor/TextureButton

@onready var item_class=preload("res://Scenes/inventory_item.tscn")
var selected_item=null
var mouse_timer = 0
var i_pulled_this_from=null
var selected_rotation=0
var can_place_buildings=true
var i_pulled_this_iter_from=0
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Rotate Building"):
		selected_rotation=(selected_rotation+1)%4
		Tbutton.rotation_degrees=selected_rotation*90
		#print(selected_rotation,"  ",Tbutton.rotation)
#Hate this mess so im gona comment the hell out of it >:(
var mouse_debounce = false
func _process(delta):
	if Global.menu_open:
		position.y += (440 - position.y) * delta * 10
	else:
		position.y += (360 - position.y) * delta * 10
	var global_mouse_pos=get_viewport().get_camera_2d().get_global_mouse_position()
	if Input.is_action_just_pressed("deselect"):
		for iter_panel in box_container.get_children().size():
			Global.selecting_hotbar=false
			if Tbutton.visible:
				i_pulled_this_from.update_item(Tbutton.item)
				Tbutton.clear_item()
				Tbutton.visible = false
				break
	#Hotbar thingamajig who i dont fully understand... i think?
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not mouse_debounce:
			mouse_debounce = true
			Global.selecting_hotbar=false
			#Gets all inventory slot panel nodes
			for iter_panel in box_container.get_children().size():
				var panel=box_container.get_children()[iter_panel]
				#checks if panel is pressed
				if panel.button.is_pressed():
					#THX kazimir
					#sets that its selected
					Global.selecting_hotbar=true
					#used break instead of continue since only one button can be pressed at once
					#if you have item in hand it placed in hotbar
					if Tbutton.visible:
						i_pulled_this_from.update_item(Tbutton.item)
						Tbutton.clear_item()
						Tbutton.visible = false
						if i_pulled_this_iter_from == iter_panel: break
						#TODO
						#this is used if it's placed in same cell
						# if i_pulled_this_iter_from == iter_panel:
						# 	panel.button.update_item(Tbutton.item)
						# 	Tbutton.clear_item()
						# 	Tbutton.visible=false
						# 	break
						# #if placed in blank inv slot
						# if panel.button.item==null:
						# 	panel.button.update_item(Tbutton.item)
						# 	Tbutton.clear_item()
						# 	Tbutton.visible=false
						# else:
						# 	#Transfers all items around a circle lol
						# 	var temp_item = item_class.instantiate()
						# 	temp_item = Tbutton.item
						# 	panel.button.update_item(Tbutton.item)
						# 	Tbutton.update_item(temp_item)
						# break
					#No item and you try to pick up new item
					if not Tbutton.visible:
						#there was no item in that inventory slot
						if panel.button.item==null:
							break
						Tbutton.update_item(panel.button.item)
						i_pulled_this_from=panel.button
						i_pulled_this_iter_from=iter_panel
						panel.button.clear_item()
						Tbutton.visible=true
							
					if panel.button.item!=null:
						selected_item=panel.button.item
			if (not Global.selecting_hotbar) and not Global.drag_locked and can_place_buildings:
				if Tbutton.visible:
					if Tbutton.item.ID==4:
						if (global_mouse_pos/16).floor() in Global.taken_squares:
							
							var new_item=item_class.instantiate()
							new_item.assign(Global.taken_squares[(global_mouse_pos/16).floor()].classification_id)
							Global.add_item_to_inv(new_item)
							Global.taken_squares[(global_mouse_pos/16).floor()].release_liquid()
							Global.taken_squares[(global_mouse_pos/16).floor()].die()
							
							demiload()
					elif not (global_mouse_pos/16).floor() in Global.taken_squares:	
						#This line disproves the existance of god
						#why, WHY
						#I prayed, and god answered, this line is fixed now
						var additional_data={}
						if Tbutton.item.storage.size()>0:
							additional_data["Storage"]=Tbutton.item.storage
						var new_building=get_parent().get_parent().building.new(Tbutton.item.ID,selected_rotation,get_parent().get_parent().get_child(4),(global_mouse_pos/16).floor(),additional_data)
						if Tbutton.item.storage.size()>0:
							Global.Player_hotbar[i_pulled_this_iter_from]=null
							i_pulled_this_from.clear_item()
							Tbutton.clear_item()
							Tbutton.visible=false
						else:
							Global.remove_from_inventory(Tbutton.item.ID,1)
							if not Global.has_item_in_inventory(Tbutton.item.ID):
								Tbutton.clear_item()
								Tbutton.visible=false
	else:
		mouse_debounce = false
	Global.hands_free = not Tbutton.visible				
	Tbutton.position=get_viewport().get_mouse_position()+Vector2(-320,-360)+[Vector2(0,20),Vector2(40,40),Vector2(20,80),Vector2(-20,60)][selected_rotation]
func demiload():
	for i in Global.Player_hotbar.size():
		$HBoxContainer.get_child(i).button.clear_item()
		if Global.Player_hotbar[i]==null:
			continue
		
		$HBoxContainer.get_child(i).button.update_item(Global.Player_hotbar[i])
	var deletor_item=item_class.instantiate()
	deletor_item.assign(4)
	deletor.update_item(deletor_item)
func _ready() -> void:
	demiload()
