extends Control

var item_stack : int = 0 #how many items in slot
var item_type : String = "" #item name like emmiter or collector
var inventory_sopt : int = -1
var hotbar_spot : int = -1

func initilise_slot(i_type : String):
	item_type = i_type
	#loads texture XD
	load_texture()

func load_texture():
	var t_texture = AtlasTexture.new()
	t_texture.region = Buildings.BUILDINGS[item_type]["Textures"][0]["Offset"]
	var t_compresed_texture = Image.load_from_file(Buildings.BUILDINGS[item_type]["Textures"][0]["Path"])
	t_texture.atlas = t_compresed_texture
	# $TextureRect.texture = t_texture

func get_texture():
	return Image.load_from_file(Buildings.BUILDINGS[item_type]["Textures"][0]["Path"])

