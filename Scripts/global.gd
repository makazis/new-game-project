extends Node

var drag_locked=false

var bigest_id = 0
func getNewId() -> int:
	bigest_id += 1
	return bigest_id - 1

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
			"Black Water":1
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
	},{
		"Req":{
			"Holy Water":3,
			"Nightmare Fuel":1
		},
		"Result":{
			19:4
		}
	},{
		"Req":{
			"Human Blood":1,
			"Unholy Water":4
		},
		"Result":{
			20:1
		}
	},{
		"Req":{
			"Sinners Flesh":2,
			"Holy Milk":4
		},
		"Result":{
			21:1
		}
	},{
		"Req":{
			"Flesh":2,
			"Ichor": 4
		},
		"Result":{
			22:1
		}
	},{
		"Req":{
			"Flesh": 1
		},
		"Result":{
			3:4
		}
	},{
		"Req":{
			"Sinners Flesh": 1,
			"Cheese" : 8
		},
		"Result":{
			23:1
		}
	},{
		"Req":{
			"Pure Water" : 5,
			"Necrotic Slime" : 1
		},
		"Result":{
			24:1
		}
	},{
		"Req":{
			"Fuel" : 10,
			"Arionite": 1
		},
		"Result":{
			25:1
		}
	},{
		"Req":{
			"Fuel": 4,
			"Reality Anomaly": 2
		},
		"Result":{
			8:1
		}
	},{
		"Req":{
			"Flesh": 2,
			"Acid": 1
		},
		"Result":{
			24:2
		}
	},{
		"Req":{
			"Acid": 2,
			"Lythosine": 2
		},
		"Result":{
			25:1
		}
	},{
		"Req":{
			"Reality Anomaly": 1,
			"Gods Flesh": 1,
			"Blood Cheese":1,
			"Human Blood":10,
			"Ichor":5,
			"Nightmare Fuel":5
		},
		"Result":{
			27:1
		}
	},{
		"Req":{
			"Water": 4,
			"Heart of Prometheus": 1,
		},
		"Result":{
			28:2,
			27:1
		}
	}
	
]
var camera_zoom=1
var camera_pos=Vector2(0,0)
var directional_vectors=[Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)]
var game=null 
var transition_instance = null
var liquid_map_name_to_id={} 
var liquid_map_id_to_name={}
var liquid_created_map={}
var liquid_makes_map={}

var known_liquids=["Water"]
@onready var item_loaded = preload("res://Scenes/inventory_item.tscn")

var menu_open = false
var Player_Inventory = []
var Player_hotbar = [] #Epic inventory management system

var ctimer=0
var click=false
var hands_free = true

var camera_shake=0

var speedrun_timer=0
var clocked_timer=""
var show_speedrun_timer=true
func _process(delta: float) -> void:
	var hours=str(int(speedrun_timer)/3600)
	if len(hours)==1:
		hours="0"+hours
	var minutes=str(int(speedrun_timer)/60%60)
	if len(minutes)==1:
		minutes="0"+minutes
	var seconds=str(int(speedrun_timer)%60)
	if len(seconds)==1:
		seconds="0"+seconds
	var miliseconds=str(int(speedrun_timer*1000)%1000)
	while len(miliseconds)<3:
		miliseconds="0"+miliseconds
	clocked_timer=hours+":"+minutes+":"+seconds+"."+miliseconds
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		ctimer+=1
	else:
		ctimer=0
	click=ctimer==1

var selecting_hotbar = false
func create_and_add_item(i_building_type, count):
	if has_item_in_inventory(i_building_type):
		get_item_in_inventory(i_building_type).stack += count
	else:
		var new_item = item_loaded.instantiate()
		new_item.stack = count
		new_item.initilise_slot(i_building_type)
		_add_item_to_inv(new_item)

func setup_player_inventory():
	#initilises inv slots
	for i in range(27):
		Player_Inventory.append(null)
		if i<8:
			Player_hotbar.append(null)
	#10 items each row, useful for adding items to inventory later
	#Bro, u will go insane after while creating these systems XD
	var starting_items=[]
	if Dev.mode=="Normal":
		starting_items=[
			["conveyor", 5],
			["collector", 2],
			["emmiter", 1],
			["storer", 1]
		]
	if Dev.mode=="Sandbox":
		starting_items=[
			["conveyor", 1],
			["collector", 1],
			["emmiter", 1],
			["fuser", 1],
			["storer", 1],
			["barrel", 1],
			["extractor", 1],
			["assembler", 1],
			["blood_barrel",1]
		]
	for i in starting_items:
		create_and_add_item(i[0],i[1])

#DEPRICATED, and reused so i added _ so it breaks whenever it is called not in the new way
#use create_and_add_item() instead :P
func _add_item_to_inv(added_item):
	for slot in Player_hotbar.size():
		if Player_hotbar[slot]: continue
		Player_hotbar[slot] = added_item
		added_item.hotbar_spot = slot
		return
	for slot in Player_Inventory.size():
		if Player_Inventory[slot]: continue
		Player_Inventory[slot] = added_item
		added_item.hotbar_spot = slot
		return

func remove_singleton_type_from_inventory(i_item_type):
	remove_singleton_from_inventory(get_item_in_inventory(i_item_type))

func remove_singleton_from_inventory(i_item):
	i_item.i_item_stack -= 1
	if i_item.i_item_stack <= 0:
		if i_item.inventory_sopt != -1: Player_Inventory[i_item.inventory_sopt] = null
		if i_item.hotbar_spot != -1: Player_hotbar[i_item.hotbar_spot] = null
		i_item.queue_free()

func remove_from_inventory(i_item_type,i_count):
	while i_count > 0:
		var t_item = get_item_in_inventory(i_item_type)
		if not t_item: return
		var t_count = t_item.item_stack
		i_count -= t_item.item_stack - t_count
		t_item.item_stack = t_count

	print("Fuck, something's wrong if you see this")

func get_item_in_inventory(i_item_type):
	for slot in Player_hotbar:
		if not slot: continue
		if slot.type == i_item_type:
			return slot
	for slot in Player_Inventory:
		if not slot: continue
		if slot.type == i_item_type:
			return slot
	return null

func has_item_in_inventory(i_item_type) -> bool:
	if get_item_in_inventory(i_item_type):
		return true
	else:
		return false
	

var first_animator=null
