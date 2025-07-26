extends Control

@onready var box_container=$HBoxContainer
@onready var Tbutton=$TextureButton
@onready var deletor=$HBoxContainer/Deletor/TextureButton

@onready var item_class=preload("res://Scenes/inventory_item.tscn")
var selected_item=null
var mouse_timer = 0
var i_pulled_this_from=null
var selected_rotation=0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Rotate Building"):
		selected_rotation=(selected_rotation+1)%4
		Tbutton.rotation_degrees=selected_rotation*90
		#print(selected_rotation,"  ",Tbutton.rotation)
func _process(delta):
	var global_mouse_pos=get_viewport().get_camera_2d().get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_timer+=1
	else:
		mouse_timer=0
	if mouse_timer==2:
		Global.selecting_hotbar=false
		for panel in box_container.get_children():
			if panel.button.is_pressed():
				
				#THX kazimir
				Global.selecting_hotbar=true
				if Tbutton.visible:
					i_pulled_this_from.update_item(Tbutton.item)
					Tbutton.clear_item()
					Tbutton.visible=false
				else:	
					if not Tbutton.visible:
						if panel.button.item==null:
							continue
						Tbutton.update_item(panel.button.item)
						i_pulled_this_from=panel.button
						panel.button.clear_item()
						Tbutton.visible=true
						
				if panel.button.item!=null:
					selected_item=panel.button.item
					pass
		if (not Global.selecting_hotbar) and not Global.drag_locked:
			if Tbutton.visible:
				if Tbutton.item.ID==4:
					if (global_mouse_pos/16).floor() in Global.taken_squares:
						Global.taken_squares[(global_mouse_pos/16).floor()].die()
						
				elif not (global_mouse_pos/16).floor() in Global.taken_squares:	
				#This line disproves the existance of god
				#why, WHY
				#I prayed, and god answered, this line is fixed now
					var new_building=get_parent().get_parent().building.new(Tbutton.item.ID,selected_rotation,get_parent().get_parent().get_child(4),(global_mouse_pos/16).floor())
			pass
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
