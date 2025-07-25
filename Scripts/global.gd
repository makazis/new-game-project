extends Node

var drag_locked=false

var bigest_id = 0
func getNewId() -> int:
	bigest_id += 1
	return bigest_id - 1

var buildings = [
	{
		"Name" = "Emmiter",
		"ToolTip" = "Emmits Extractium",
		"ModelPath" = "res://Assets/Models/Emiter.tscn",
	}
]

@onready var item_loaded=preload("res://Scenes/inventory_item.tscn")
var Player_Inventory={}
var Player_hotbar={} #Epic inventory management system
func _ready():
	for i in range(27):
		Player_Inventory[i]=null
		if i<9:
			Player_hotbar[i]=null

	for i in range(100):
		var new_item=item_loaded.instantiate()
		new_item.assign(randi_range(0,1))
		add_item_to_inv(new_item)
		
func add_item_to_inv(added_item):
	var item_is_in_inventory=false
	for iter_item_key in Player_Inventory:
		var iter_item=Player_Inventory[iter_item_key]
		if iter_item==null:
			continue
		if iter_item.ID==added_item.ID:
			iter_item.count+=added_item.count
			item_is_in_inventory=true
			return
	if not item_is_in_inventory:
		for iter_item_key in Player_Inventory:
			if Player_Inventory[iter_item_key]==null:
				Player_Inventory[iter_item_key]=added_item
				return
