extends Control

@onready var num_icon=preload("res://Scenes/menu/num_icon.tscn")
@onready var lsl=preload("res://Scenes/Inventory/liquid_searcher_line.tscn")
func demiload() -> void:
	var total_liquids=Global.liquid_map_name_to_id.size()
	for i in range(ceil(total_liquids/5.)):
		var new_num_line=lsl.instantiate()
		$ScrollContainer/VBoxContainer.add_child(new_num_line)
		for ii in range(min(5,total_liquids-i*5)):
			var new_num_icon=num_icon.instantiate()
			
			new_num_line.add_child(new_num_icon)
			new_num_icon.setup(Global.liquid_map_id_to_name[i*5+ii],1,1)
signal chosen_element
var selected_liquid=null
func _process(delta: float) -> void:
	for i in $ScrollContainer/VBoxContainer.get_children():
		for ii in i.get_children():
			if ii.chosen:
				selected_liquid=ii.element_name
				chosen_element.emit()
				ii.chosen=false
