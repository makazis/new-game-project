extends Control

var ID: int = 0
var item_name: String = "Conveyor"
var item_count: int = 1
var item_texture: String = ""
var storage={}

func assign(new_ID):
	var item_data=[
		{ #0
			"Name":"Conveyor",
			"Texture Path":"res://Assets/Icons/conveyor.png"
		},
		{
			"Name":"Collector",
			"Texture Path":"res://Assets/Icons/collector.png"
		},
		{ #2
			"Name":"Turn",
			"Texture Path":"res://Assets/Icons/conveyor_turn.png"
		},
		{
			"Name":"Emitter",
			"Texture Path":"res://Assets/Icons/Emiter.png"
		},
		{ #4
			"Name":"Deletor",
			"Texture Path":"res://Assets/Icons/Delete.png"
		},
		{
			"Name":"Fuser",
			"Texture Path":"res://Assets/Icons/Fuser.png"
		},
		{ #6
			"Name":"Storer",
			"Texture Path":"res://Assets/Icons/Storer.png"
		},
		{
			"Name":"Rubble",
			"Texture Path":"res://Assets/Icons/Rubble.png"
		},
		{ #8
			"Name":"Barrel",
			"Texture Path":"res://Assets/Icons/Barrel.png"
		}
	]
	item_texture=item_data[new_ID]["Texture Path"]
	item_name=item_data[new_ID]["Name"]
	ID=new_ID
