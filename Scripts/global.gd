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
var Player_Inventory=[]

func _ready():
	for i in range(100):
		var new_item=item_loaded.instantiate()
		new_item.assign(randi_range(0,1))
		add_item_to_inv(new_item)

func add_item_to_inv(added_item):
	var item_is_in_inventory=false
	for iter_item in Player_Inventory:
		if iter_item.ID==added_item.ID:
			iter_item.count+=added_item.count
			item_is_in_inventory=true
	if not item_is_in_inventory:
		Player_Inventory.append(added_item)