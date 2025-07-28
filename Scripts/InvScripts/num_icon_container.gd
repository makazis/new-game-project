extends Container

@onready var nic=$"Num Icon Container"
var num_icon=preload("res://Scenes/menu/num_icon.tscn")
var icon=preload("res://Scenes/menu/liquid_display_icon.tscn")
func setup(list_of_liquids):
	if list_of_liquids["Type"]=="Aging":
		var new_icon=icon.instantiate()
		new_icon.setup("res://Assets/Icons/Aging Reaction.png")
		nic.add_child(new_icon)
	if list_of_liquids["Type"]=="Accelerating":
		var new_icon=icon.instantiate()
		new_icon.setup("res://Assets/Icons/Accelerating Reaction.png")
		nic.add_child(new_icon)
	
	for l_data in list_of_liquids["Ingredients"]:
		var new_numicon=num_icon.instantiate()
		new_numicon.setup(l_data[0],l_data[1])
		nic.add_child(new_numicon)
	var new_icon=icon.instantiate()
	new_icon.setup("res://Assets/Icons/Turns Into.png")
	nic.add_child(new_icon)
	for l_data in list_of_liquids["Result"]:
		var new_numicon=num_icon.instantiate()
		new_numicon.setup(l_data[0],l_data[1])
		nic.add_child(new_numicon)
