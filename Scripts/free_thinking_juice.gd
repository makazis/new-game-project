extends RigidBody2D

@onready var sprite=$Sprite2D

var ID: int = 0
var liquid_name: String = "Unobtainium"
var liquid_data=[
	{
		"Name":"Water", #The basic liquid, used in pretty much anything. 
		"Color":Color.from_hsv(0.7,1,1)
	},
	{
		"Name":"Pure Water", #Created by adding neothol to neothol, more reactive, but not overly so
		"Color":Color.from_hsv(0.6,0.8,1),
		"Friction":0.5,
		"Bouncy":0.3
	},
	{
		"Name":"Holy Water", #Created by adding neothol to neothol, more reactive, but not overly so
		"Color":Color.from_hsv(0.7,0.5,0.5),
		"Friction":0.2,
		"Bouncy":1.1,
		"Accelerating":{
			"Speed Needed":40,
			"To":9
		}
	},
	{ #We just have a way to buy human blood in crates from a shop, and we have some customers that want something else added to it
		"Name":"Human Blood",
		"Color":Color(0.29, 0.0, 0.0),
		"Bouncy":0.4,
		"Friction":1.0
	},
	{ #[4#6 Human blood + 2 holy water = 1 blood of the gods
		"Name":"Ichor",
		"Color":Color(0.363, 0.217, 0.414),
		"Bouncy":0.2,
		"Friction":0.5
	},{ # can be bought in the store
		"Name":"Milk",
		"Color":Color(0.865, 0.809, 0.79),
		"Bouncy":0.1,
		"Friction":0.7,
		#After is kept in the open for more seconds than the 
		"Aging":{
			"In":30,
			"To":6
		},
		"Accelerating":{
			"Speed Needed":40,
			"To":10
		}
	},{ # can be bought in the store #7th element
		"Name":"Evil Milk",
		"Color":Color(0.694, 0.605, 0.453),
		"Bouncy":0,
		"Friction":0.9,
	},{ #6 human blood + 6 evil milk = 6 nightmare fuel
		"Name":"Nightmare Fuel",
		"Color":Color(0.66, 0.0, 0.011),
		"Bouncy":0.9,
		"Friction":0.1
	},{ #[8#Starts somewhere on the map, needs to be transported into your factory, combining this with water makes 1 Lythosine and 1 milk (converts water to milk)
		"Name":"Lythosine",
		"Color":Color(0.796, 0.882, 0.877),
		"Bouncy":0.9,
		"Friction":0.1
	},{ #Created when holy water is accelerated to the maximum
		"Name":"Arionite", #[9]
		"Color":Color(0.543, 0.66, 0.781),
		"Bouncy":1,
		"Friction":0
	},{ #Created when milk is accelerated enough (can be achieved through a particle accelerator)
		"Name":"Cheese",
		"Color":Color(0.841, 0.594, 0.0),
		"Bouncy":0.6,
		"Friction":0.6
	},{  
		"Name": "Cursed Blood",  # Human Blood + Nightmare Fuel (1:1)  
		"Color": Color(0.45, 0.0, 0.1),  
		"Bouncy": 0.7,  
		"Friction": 0.3,  
		"Aging": {  
			"In": 45,  
			"To": 6  # Turns back into Human Blood  
		}  
	},  
	{  
		"Name": "Golden Milk",  # Milk + Arionite (3:1)  
		"Color": Color(0.9, 0.8, 0.4),  
		"Bouncy": 0.5,  
		"Friction": 0.4,  
		"Accelerating": {  
			"Speed Needed": 50,  
			"To": 10  # Becomes Cheese  
		}  
	},  
	{  
		"Name": "Black Water",  # Water + Nightmare Fuel (2:1)  
		"Color": Color(0.1, 0.1, 0.2),  
		"Bouncy": 0.1,  
		"Friction": 0.8,  
		"Aging": {  
			"In": 60,  
			"To": 0  # Reverts to Water  
		}  
	},  
	{  
		"Name": "Blood Cheese",  # Cheese + Human Blood (1:2)  
		"Color": Color(0.6, 0.3, 0.2),  
		"Bouncy": 0.4,  
		"Friction": 0.7  
	},  
	{  
		"Name": "Holy Milk",  # Milk + Holy Water (1:1)   #[15]
		"Color": Color(0.8, 0.85, 0.9),  
		"Bouncy": 0.3,  
		"Friction": 0.6,  
		"Aging": {  
			"In": 20,  
			"To": 5  # Spoils into Evil Milk  
		}  
	},  
	{  
		"Name": "Necrotic Slime",  # Ichor + Evil Milk (1:1)  
		"Color": Color(0.3, 0.4, 0.1),  
		"Bouncy": 0.2,  
		"Friction": 0.9  
	},  
	{  
		"Name": "Purified Ichor",  # Ichor + Pure Water (1:3)  
		"Color": Color(0.5, 0.3, 0.7),  
		"Bouncy": 0.6,  
		"Friction": 0.4  
	},    
	{  
		"Name": "Unholy Water",  # Holy Water + Evil Milk (1:1) #[18] 
		"Color": Color(0.4, 0.3, 0.5),  
		"Bouncy": 0.5,  
		"Friction": 0.5,  
		"Aging": {  
			"In": 15,  
			"To": 6  # Decays into Evil Milk  
		}  
	},
	{
		"Name": "Fuel",
		"Color": Color(0.2,0.2,0.2),
		"Bouncy": 0.2,
		"Friction" : 0.5,
	},
	{
		"Name": "Sinners Flesh", #[20]
		"Color": Color(0.5,0.1,0.1),
		"Bouncy": 0.5,
		"Friction" : 0.5,
	},
	{
		"Name": "Flesh", #[21]
		"Color": Color(0.8,0.1,0.1),
		"Bouncy": 0.5,
		"Friction" : 0.5,
	},
	{
		"Name": "Gods Flesh", #[22]
		"Color": Color(1.0,0.6,0.3),
		"Bouncy": 0.6,
		"Friction" : 0.3,
	},
	{
		"Name": "Abominations Flesh",
		"Color": Color(0.2,0.5,0.3),
		"Bouncy": 0.2,
		"Friction" : 0.7,
	},
	{
		"Name": "Acid",
		"Color": Color(0.3,0.8,0.3),
		"Bouncy": 0.5,
		"Friction" : 0.3,
	},
	{
		"Name": "Unstable Particle",
		"Color": Color(0.9,0.9,1),
		"Bouncy": 10,
		"Friction" : -10,
		"Accelerating": {  
			"Speed Needed": 100,  
			"To": 26  # Becomes Reality anomaly 
		}
	},
	{
		"Name": "Reality Anomaly",
		"Color": Color(0,0,0,0.9),
		"Bouncy": 0,
		"Friction" : 0,
	}
]
func _ready() -> void:
	if Global.liquid_map_id_to_name.size()==0:
		for i in liquid_data.size():
			Global.liquid_map_id_to_name[i]=liquid_data[i]["Name"]
			Global.liquid_map_name_to_id[liquid_data[i]["Name"]]=i
var cached_assigned_ID=0
func assign(new_ID):
	ID=new_ID
	liquid_name=liquid_data[new_ID]["Name"]
	sprite.texture.gradient.set_color(0,liquid_data[new_ID]["Color"])
	if "Bouncy" in liquid_data[new_ID]:
		physics_material_override.bounce=liquid_data[new_ID]["Bouncy"]
	if "Friction" in liquid_data[new_ID]:
		#physics_material_override.bounce=liquid_data[new_ID]["Friction"]
		linear_damp=0.1*(liquid_data[new_ID]["Friction"])
	if "Aging" in liquid_data[new_ID]:
		var my_timer=Timer.new()
		add_child(my_timer)
		my_timer.start(liquid_data[new_ID]["Aging"]["In"]*randf_range(0.5,1.3))
		cached_assigned_ID=liquid_data[new_ID]["Aging"]["To"]
		my_timer.timeout.connect(cached_assign)
func cached_assign():
	assign(cached_assigned_ID)
func _physics_process(delta: float) -> void:
	var global_mouse_pos=get_viewport().get_camera_2d().get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Global.hands_free:
		if global_mouse_pos.distance_to(global_position)<75:
			var aangle=atan2(global_mouse_pos.y-global_position.y,global_mouse_pos.x-global_position.x)
			apply_force(Vector2(-cos(aangle),-sin(aangle))*delta*1200)
	if "Accelerating" in liquid_data[ID]:
		if linear_velocity.distance_to(Vector2(0,0))>liquid_data[ID]["Accelerating"]["Speed Needed"]:
			assign(liquid_data[ID]["Accelerating"]["To"])
	#if ID==9:
	#	linear_velocity*=1+delta*30
			
