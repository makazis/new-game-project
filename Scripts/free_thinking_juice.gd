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
		"Bouncy":0.8
	},
	{ #We just have a way to buy human blood in crates from a shop, and we have some customers that want something else added to it
		"Name":"Human Blood",
		"Color":Color(0.29, 0.0, 0.0),
		"Bouncy":0.4
	},
	{ #6 Human blood + 2 holy water = 1 blood of the gods
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
	},
]
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
		my_timer.start(liquid_data[new_ID]["Aging"]["In"])
		cached_assigned_ID=liquid_data[new_ID]["Aging"]["To"]
		my_timer.timeout.connect(cached_assign)
func cached_assign():
	assign(cached_assigned_ID)
		
