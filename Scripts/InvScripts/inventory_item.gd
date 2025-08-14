extends Control

var stack : int = 0 #how many items in slot
var type : String = "" #item name like emmiter or collector
var inventory_sopt : int = -1
var hotbar_spot : int = -1

func initilise_slot(i_type : String):
	type = i_type

func get_texture():
	var t_texture = AtlasTexture.new()
	t_texture.region = Buildings.BUILDINGS[type]["Textures"][0]["Offset"]
	t_texture.atlas = load(Buildings.BUILDINGS[type]["Textures"][0]["Path"])
	return t_texture
