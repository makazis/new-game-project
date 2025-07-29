extends Control

var ID: int = 0
var item_name: String = "Conveyor"
var item_count: int = 1
var item_texture: String = ""
var storage={}
var building_map=[[0,0]]
var rotation_offsets=[]
var placement_texture=""
var x_size=1
var y_size=1
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
		},
		{ #9
			"Name":"Extractor",
			"Texture Path":"res://Assets/Icons/Splitter.png"
		},
		{ #10
			"Name":"Assembler",
			"Texture Path":"res://Assets/Icons/Assembler_Icon.png",
			"Custom Map":[[0,0],[1,0],[1,-1]],
			"Placement Texture":"res://Assets/Icons/Assembler.png"
		}
	]
	item_texture=item_data[new_ID]["Texture Path"]
	item_name=item_data[new_ID]["Name"]
	ID=new_ID
	var min_x=0
	var min_y=0
	var max_x=0
	var max_y=0
	if "Custom Map" in item_data[new_ID]:
		building_map=item_data[new_ID]["Custom Map"]
		for i in building_map:
			if i[0]<min_x:
				min_x=i[0]
			if i[0]>max_x:
				max_x=i[0]
			if i[1]<min_y:
				min_y=i[1]
			if i[1]>max_y:
				max_y=i[1]
	rotation_offsets=[
		Vector2(min_x,min_y),
		Vector2(max_y,min_x),
		Vector2(-max_x,-max_y),
		Vector2(min_y,-max_x),
	]	
	if "Placement Texture" in item_data[new_ID]:
		placement_texture=item_data[new_ID]["Placement Texture"]
	else:
		placement_texture=item_texture
	x_size=1+max_x-min_x
	y_size=1+max_y-min_y
	
