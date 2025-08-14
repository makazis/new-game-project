extends Control

var item_stack : int = 0 #how many items in slot
var item_type : String = "" #item name like emmiter or collector
var inventory_sopt : int = -1
var hotbar_spot : int = -1

func initilise_slot(i_type : String):
	item_type = i_type

func get_texture():
	var t_texture = AtlasTexture.new()
	t_texture.region = Buildings.BUILDINGS[item_type]["Textures"][0]["Offset"]
	t_texture.atlas = load(Buildings.BUILDINGS[item_type]["Textures"][0]["Path"])
	return t_texture
