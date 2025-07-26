extends RigidBody2D

@onready var sprite=$Sprite2D

var ID: int = 0
var liquid_name: String = "Unobtainium"
var liquid_data=[
	{
		"Name":"Neothol", #The basic liquid, used in pretty much anything. 
		"Color":Color.from_hsv(0.7,1,1)
	},
	{
		"Name":"Compressed Neothol", #Created by adding neothol to neothol, more reactive, but not overly so
		"Color":Color.from_hsv(0.6,0.8,1),
		"Friction":0.5,
		"Bouncy":0.3
	}
]
func assign(new_ID):
	ID=new_ID
	liquid_name=liquid_data[new_ID]["Name"]
	#sprite.texture=GradientTexture2D.new()
	#sprite.texture.width=6
	#sprite.texture.height=6
	#sprite.texture.fill_from=Vector2(0.5,0.5)
	#sprite.texture.fill="radial"
	#sprite.texture.gradient.offsets=PackedFloat32Array([0.519,0.857])
	
	sprite.texture.gradient.set_color(0,liquid_data[new_ID]["Color"])
	if "Bouncy" in liquid_data[new_ID]:
		physics_material_override.bounce=liquid_data[new_ID]["Bouncy"]
	if "Friction" in liquid_data[new_ID]:
		#physics_material_override.bounce=liquid_data[new_ID]["Friction"]
		linear_damp=0.1*(1-liquid_data[new_ID]["Friction"])
