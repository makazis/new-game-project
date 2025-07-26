extends Control

var ID: int = 0
var item_name: String = "Conveyor"
var item_count: int = 1
var item_texture: String = ""

func assign(new_ID):
	var item_data=[
		{
			"Name":"Conveyor",
			"Texture Path":"res://Assets/Icons/conveyor.png"
		},
		{
			"Name":"Collector",
			"Texture Path":"res://Assets/Icons/collector.png"
		},
		{
			"Name":"Turn",
			"Texture Path":"res://Assets/Icons/conveyor_turn.png"
		},
		{
			"Name":"Emitter",
			"Texture Path":"res://Assets/Icons/Emiter.png"
		},
		{
			"Name":"Deletor",
			"Texture Path":"res://Assets/Icons/Delete.png"
		},
		{
			"Name":"Fuser",
			"Texture Path":"res://Assets/Icons/Fuser.png"
		},
		{
			"Name":"Storer",
			"Texture Path":"res://Assets/Icons/Storer.png"
		}
	]
	item_texture=item_data[new_ID]["Texture Path"]
	item_name=item_data[new_ID]["Name"]
	ID=new_ID
