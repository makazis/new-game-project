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

var Player_Inventory = []
var Player_hotbar = [] #Epic inventory management system

func _ready():
	#initilises inv slots
	for i in range(27):
		Player_Inventory.append(null)
		if i<9:
			Player_hotbar.append(null)

	#gives 100 items?
	for i in range(100):
		var new_item= item_loaded.instantiate()
		new_item.assign(randi_range(0,1))
		add_item_to_inv(new_item)
		
func add_item_to_inv(added_item):
	var item_is_in_inventory=false
	#check if item exists
	for iter_item_key in Player_Inventory.size():
		var iter_item=Player_Inventory[iter_item_key]
		#Checks if item exists
		if iter_item==null:
			continue
		#Stacks items
		if iter_item.ID==added_item.ID:
			iter_item.item_count+=added_item.item_count
			item_is_in_inventory=true
			return
	#Adds item to inventory
	if not item_is_in_inventory:
		for iter_item_key in Player_Inventory.size():
			if Player_Inventory[iter_item_key]==null:
				Player_Inventory[iter_item_key]=added_item
				return
