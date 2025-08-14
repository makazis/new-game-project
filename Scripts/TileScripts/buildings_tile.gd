extends Node2D

#Set by buildings.gd
var ID : int

#Set on init
var NAME : String # also just the type ;P
var CELLS : Array #Occupied cells pre rot
var STORAGE : Dictionary
var POSITION : Vector2 #In building coords
var ROTATION : int #In 0123 where 0 is right 
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

func load_texture(pIndex : int):
	var t_texture = AtlasTexture.new()
	t_texture.region = Buildings.BUILDINGS[NAME]["Textures"][pIndex]["Offset"]
	t_texture.atlas = load(Buildings.BUILDINGS[NAME]["Textures"][pIndex]["Path"])
	BUILDING_SPRITE.texture = t_texture
	BUILDING_SPRITE.position = Buildings.BUILDINGS[NAME]["Textures"][pIndex]["Offset"].size/2
func tick(delta) -> void:
	pass

func delete() -> void:
	Buildings.fRemove_building(self)
	#reles liquid
	print("ADD RELESE LIQUID")
	queue_free()
