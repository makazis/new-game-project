extends Control

@onready var box_container=$HBoxContainer
@onready var bSelector=$TextureButton
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
		bSelector.rotation_degrees=selected_rotation*90
		#print(selected_rotation,"  ",bSelector.rotation)
#Hate this mess so im gona comment the hell out of it >:(
var mouse_debounce = false
var global_mouse_pos=Vector2(0,0)
func _process(delta):
	if Global.menu_open:
		position.y += (440 - position.y) * delta * 10
	else:
		position.y += (360 - position.y) * delta * 10
	global_mouse_pos=get_viewport().get_camera_2d().get_global_mouse_position()
	if Input.is_action_just_pressed("deselect"):
		for iter_panel in box_container.get_children().size():
			Global.selecting_hotbar=false
			if bSelector.visible:
				i_pulled_this_from.update_item(bSelector.item)
				bSelector.clear_item()
				bSelector.visible = false
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
					if bSelector.visible:
						i_pulled_this_from.update_item(bSelector.item)
						deselect()
						if i_pulled_this_iter_from == iter_panel: break
						#TODO
						#some script that allows to swap items in hotbar but eh i ain't doing it as it is broken
						# this is used if it's placed in same cell
						# if i_pulled_this_iter_from == iter_panel:
						# 	panel.button.update_item(bSelector.item)
						# 	bSelector.clear_item()
						# 	bSelector.visible=false
						# 	break
						# #if placed in blank inv slot
						# if panel.button.item==null:
						# 	panel.button.update_item(bSelector.item)
						# 	bSelector.clear_item()
						# 	bSelector.visible=false
						# else:
						# 	#Transfers all items around a circle lol
						# 	var temp_item = item_class.instantiate()
						# 	temp_item = bSelector.item
						# 	panel.button.update_item(bSelector.item)
						# 	bSelector.update_item(temp_item)
						# break
					#No item and you try to pick up new item
					if not bSelector.visible:
						#there was no item in that inventory slot
						if panel.button.item==null:
							break
						bSelector.update_item(panel.button.item)
						i_pulled_this_from=panel.button
						i_pulled_this_iter_from=iter_panel
						panel.button.clear_item()
						bSelector.visible=true
							
					if panel.button.item!=null:
						selected_item=panel.button.item
			if (not Global.selecting_hotbar) and (not Global.drag_locked) and can_place_buildings:
				if bSelector.visible:
					if bSelector.item.type == "deletor":
						var tBuilding = Buildings.get_building_from_position(global_mouse_pos)
						if tBuilding:
							if Dev.mode!="Sandbox":
								Global.create_and_add_item(tBuilding.NAME, 1)
							tBuilding.delete()
							demiload()
					elif BuildingPosition.CheckPlacable(bSelector.item.type, global_mouse_pos, selected_rotation):
						#print("Triggered")
						Buildings.PlaceBuilding(bSelector.item.type, global_mouse_pos, selected_rotation)
						if Dev.mode != "Sandbox":
							bSelector.item.stack -= 1
							if bSelector.item.stack <= 0:
								Global.Player_hotbar[i_pulled_this_iter_from]=null
								i_pulled_this_from.clear_item()
								deselect()
	else:
		mouse_debounce = false
	Global.hands_free = not bSelector.visible				
	bSelector.position=get_viewport().get_mouse_position()+Vector2(-320,-360)+[Vector2(0,20),Vector2(40,40),Vector2(20,80),Vector2(-20,60)][selected_rotation]

func deselect() -> void:
	bSelector.clear_item()
	bSelector.visible = false

func demiload():
	#WTF does this does is it just to refreshh ?????????
	#yeah it does just refresh ;-;
	for i in Global.Player_hotbar.size():
		$HBoxContainer.get_child(i).button.clear_item()
		if Global.Player_hotbar[i]==null:
			continue

		$HBoxContainer.get_child(i).button.update_item(Global.Player_hotbar[i])
	var deletor_item=item_class.instantiate()
	deletor_item.initilise_slot("deletor")
	deletor.update_item(deletor_item)

func _ready() -> void:
	demiload()
