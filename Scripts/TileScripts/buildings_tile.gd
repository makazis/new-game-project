extends Node2D

#Set by buildings.gd
var ID : int

#Set on init
var NAME : String # also just the type ;P
var CELLS : Array #Occupied cells pre rot
var STORAGE : Dictionary
var POSITION : Vector2 #In building coords
var ROTATION : int #In 0123 where 0 is right 
var liquid=preload("res://Scenes/free_thinking_juice.tscn")
var init_FUNCTIONS : Array
var tick_FUNCTIONS : Array
var dele_FUNCTIONS : Array
@onready var BUILDING_SPRITE : Sprite2D = $Building 

#Set on place or later
var CELL_POS : Array #Occupied cells after rotation and position


func init(i_params, i_position, i_rotation) -> void:
	NAME = i_params["Name"]
	CELLS = i_params["Occupied_cells"]
	POSITION = i_position
	ROTATION = i_rotation
	load_texture(0)
	BUILDING_SPRITE.rotation_degrees = i_rotation * 90
	#Adds function to function lists
	for iFunc in Buildings.BUILDINGS[NAME]["Functions"]:
		if has_method("proc_init_" + iFunc["Name"]):
			init_FUNCTIONS.append(Callable(self,"proc_init_" + iFunc["Name"]))
		if has_method("proc_tick_" + iFunc["Name"]):
			tick_FUNCTIONS.append(Callable(self,"proc_tick_" + iFunc["Name"]))
		if has_method("proc_dele_" + iFunc["Name"]):
			dele_FUNCTIONS.append(Callable(self,"proc_dele_" + iFunc["Name"]))
	for iFunc in init_FUNCTIONS:
		iFunc.call()

func load_texture(pIndex : int):
	var t_texture = AtlasTexture.new()
	t_texture.region = Buildings.BUILDINGS[NAME]["Textures"][pIndex]["Offset"]
	t_texture.atlas = load(Buildings.BUILDINGS[NAME]["Textures"][pIndex]["Path"])
	BUILDING_SPRITE.texture = t_texture
	var tPos = BuildingPosition.PossitionRotation(Buildings.BUILDINGS[NAME]["Textures"][pIndex]["Offset"].size/2 - Vector2(8,8), ROTATION)
	BUILDING_SPRITE.position = tPos + Vector2(8,8)

func tick(delta) -> void:
	for iFunc in tick_FUNCTIONS:
		iFunc.call()

func delete() -> void:
	Buildings.fRemove_building(self)
	for iFunc in dele_FUNCTIONS:
		iFunc.call()
	queue_free()
 

func create_liquid(liquid_ID, pPos, pVel):
	var new_particle=liquid.instantiate()
	Global.game.add_child(new_particle)
	new_particle.assign(liquid_ID)
	new_particle.position=pPos
	new_particle.apply_force(pVel)

## THIS IS THE FUNCTIONS LIST
func proc_dele_Delete_relese() -> void:
	print("IT WPORKS")
