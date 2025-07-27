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
	},
	{
		"Name" = "Storer",
		"ToolTip" = "Puts Liquids into production",
		"ModelPath" = "res://Assets/Models/Storer.tscn",
	},
	{
		"Name" = "Rubble",
		"ToolTip" = "Does absolutely nothing and dies",
		"ModelPath" = "res://Assets/Models/Rubble.tscn",
	},{
		"Name" = "Barrel",
		"ToolTip" = "Stores Certain items",
		"ModelPath" = "res://Assets/Models/Barrel.tscn",
	}
	
]
var crafting_tree=[
	{ #This is cursed, but oh well
		"Req":{
			"Water":6
		},
		"Result":{
			1:1
		}
	},
	{ 
		"Req":{
			"Pure Water":6
		},
		"Result":{
			2:1
		}
	},
	{
		"Req":{
			"Human Blood":6,
			"Holy Water":2
		},
		"Result":{
			4:1
		}
	},
	{
		"Req":{
			"Human Blood":6,
			"Evil Milk":6
		},
		"Result":{
			7:6
		}
	},
	{
		"Req":{
			"Water":1,
			"Lythosine":1
		},
		"Result":{
			8:1,
			5:1
		}
	},
	{
		"Req":{
			"Human Blood":3,
			"Nightmare Fuel":1
		},
		"Result":{
			11:3
		}
	},
	{
		"Req":{
			"Milk":5,
			"Arionite":1
		},
		"Result":{
			12:5
		}
	},
	{
		"Req":{
			"Water":25,
			"Nightmare Fuel":1
		},
		"Result":{
			13:5
		}
	},
	{
		"Req":{
			"Cheese":1,
			"Human Blood":2
		},
		"Result":{
			14:1
		}
	},{
		"Req":{
			"Milk":2,
			"Holy Water":1
		},
		"Result":{
			15:2
		}
	},{
		"Req":{
			"Ichor":1,
			"Evil Milk":12
		},
		"Result":{
			16:12
		}
	},{
		"Req":{
			"Ichor":2,
			"Holy Water":2
		},
		"Result":{
			17:1
		}
	},{
		"Req":{
			"Evil Milk":2,
			"Holy Water":1
		},
		"Result":{
			18:1
		}
	},
]
var camera_zoom=1
var camera_pos=Vector2(0,0)
var taken_squares={}
var buildings_2=[]
var directional_vectors=[Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)]
var game=null 
var transition_instance = null
var liquid_map_name_to_id={} 
var liquid_map_id_to_name={}
@onready var item_loaded=preload("res://Scenes/inventory_item.tscn")

var menu_open = false
var Player_Inventory = []
var Player_hotbar = [] #Epic inventory management system

var ctimer=0
var click=false
var hands_free = true

var camera_shake=0

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		ctimer+=1
	else:
		ctimer=0
	click=ctimer==1
func getBuildingFromPos(in_position):
	if taken_squares.has(floor(in_position/16)):
		return taken_squares[floor(in_position/16)]
	return null

var selecting_hotbar = false

func _ready():
	#initilises inv slots
	for i in range(27):
		Player_Inventory.append(null)
		if i<8:
			Player_hotbar.append(null)

	#gives 100 items?
	for i in range(1000):
		var new_item= item_loaded.instantiate()
		new_item.assign(randi_range(0,3))
		add_item_to_inv(new_item)
	var new_item= item_loaded.instantiate()
	new_item.assign(5)
	add_item_to_inv(new_item)
	new_item= item_loaded.instantiate()
	new_item.assign(6)
	add_item_to_inv(new_item)
func add_item_to_inv(added_item):
	var item_is_in_hotbar=false
	var item_is_in_inventory=false
	#check if item exists
	if added_item.storage.size()==0:
		for iter_item_key in Player_hotbar.size():
			var iter_item=Player_hotbar[iter_item_key]
			#Checks if item exists
			if iter_item==null:
				continue
			if iter_item.storage.size()>0:
				continue
			#Stacks items
			if iter_item.ID==added_item.ID:
				iter_item.item_count+=added_item.item_count
				item_is_in_hotbar=true
				return
		
		#check if item exists
		for iter_item_key in Player_Inventory.size():
			var iter_item=Player_Inventory[iter_item_key]
			#Checks if item exists
			if iter_item==null:
				continue
			if iter_item.storage.size()>0:
				continue
			#Stacks items
			if iter_item.ID==added_item.ID:
				iter_item.item_count+=added_item.item_count
				item_is_in_inventory=true
				return
	if not item_is_in_hotbar:
		for iter_item_key in Player_hotbar.size():
			if Player_hotbar[iter_item_key]==null:
				Player_hotbar[iter_item_key]=added_item
				return
	#Adds item to inventory
	if not item_is_in_inventory:
		
		for iter_item_key in Player_Inventory.size():
			if Player_Inventory[iter_item_key]==null:
				Player_Inventory[iter_item_key]=added_item
				return
func remove_singleton_from_inventory(item):
	for iter_item_key in Player_hotbar.size():
		if Player_hotbar[iter_item_key]==item:
			Player_hotbar[iter_item_key]=null
			return
	for iter_item_key in Player_Inventory.size():
		if Player_Inventory[iter_item_key]==item:
			Player_Inventory[iter_item_key]=null
			return
func remove_from_inventory(item_ID,count):
	for iter_item_key in Player_hotbar.size():
		if Player_hotbar[iter_item_key]==null:
			continue
		if Player_hotbar[iter_item_key].ID==item_ID:
			Player_hotbar[iter_item_key].item_count-=count
			if Player_hotbar[iter_item_key].item_count<=0:
				Player_hotbar[iter_item_key]=null
			return
	for iter_item_key in Player_Inventory.size():
		if Player_Inventory[iter_item_key]==null:
			continue
		if Player_Inventory[iter_item_key].ID==item_ID:
			Player_Inventory[iter_item_key].item_count-=count
			if Player_Inventory[iter_item_key].item_count<=0:
				Player_Inventory[iter_item_key]=null
			return
	print("Fuck, something's wrong if you see this")
func has_item_in_inventory(item_ID):
	for iter_item_key in Player_hotbar.size():
		if Player_hotbar[iter_item_key]==null:
			continue
		if Player_hotbar[iter_item_key].ID==item_ID:
			return true
	for iter_item_key in Player_Inventory.size():
		if Player_Inventory[iter_item_key]==null:
			continue
		if Player_Inventory[iter_item_key].ID==item_ID:
			return true
	return false
	
