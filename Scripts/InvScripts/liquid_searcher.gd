extends Control

@onready var num_icon=preload("res://Scenes/menu/num_icon.tscn")
func demiload() -> void:
	print(Global.liquid_map_name_to_id)
	for liquid in Global.liquid_map_name_to_id:
		var new_num_icon=num_icon.instantiate()
		new_num_icon.setup(liquid,1,1)
		$ScrollContainer/BoxContainer.add_child(new_num_icon)
		print(new_num_icon.ID)
