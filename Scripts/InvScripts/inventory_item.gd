extends Control

var ID: int = 0
var item_name: String = "Conveyor"
var item_count: int = 1
var item_texture: CompressedTexture2D = CompressedTexture2D.new()

func assign(new_ID):
	var item_data=[
		{
			"Name":"Conveyor",
			"Texture Path":"res://Assets/conveyor.png"
		},
		{
			"Name":"Collectorr",
			"Texture Path":"res://Assets/collector.png"
		},
	]
	item_texture.load(item_data[new_ID]["Texture Path"])
	item_name=item_data[new_ID]["Name"]
	ID=new_ID
