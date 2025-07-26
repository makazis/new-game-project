extends Node

var drag_locked=false

var bigest_id = 0
func getNewId() -> int:
	bigest_id += 1
	return bigest_id - 1

var buildings = [
	{
		"Name" = "Conveyor",
		"ToolTip" = "Transports Items",
		"ModelPath" = "res://Assets/Models/Conveyor.tscn",
	},
	{
		"Name" = "Collector",
		"ToolTip" = "Collects Items",
		"ModelPath" = "res://Assets/Models/Collector.tscn",
	},
	{
		"Name" = "Turn",
		"ToolTip" = "Transports Items to another direction",
		"ModelPath" = "res://Assets/Models/Turn.tscn",
	},
	{
		"Name" = "Emmiter",
		"ToolTip" = "Emmits Extractium",
		"ModelPath" = "res://Assets/Models/Emiter.tscn",
	},{}, #Saved for the delete item
	{
		"Name" = "Fuser",
		"ToolTip" = "Fuses liquids together into new ones",
		"ModelPath" = "res://Assets/Models/Merger.tscn",
	}
]
var crafting_tree=[
	{ #This is cursed, but oh well
		"Req":{
			"Neothol":4
		},
		"Result":{
			1:1,
			0:1
		}
	}
]
var camera_zoom=1
var camera_pos=Vector2(0,0)
var taken_squares={}
var buildings_2=[]
var directional_vectors=[Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)]
var game=null 
@onready var item_loaded=preload("res://Scenes/inventory_item.tscn")

var Player_Inventory = []
var Player_hotbar = [] #Epic inventory management system

func _ready():
	#initilises inv slots
	for i in range(27):
		Player_Inventory.append(null)
		if i<8:
			Player_hotbar.append(null)

	#gives 100 items?
	for i in range(100):
		var new_item= item_loaded.instantiate()
		new_item.assign(randi_range(0,3))
		add_item_to_inv(new_item)
	var new_item= item_loaded.instantiate()
	new_item.assign(5)
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
