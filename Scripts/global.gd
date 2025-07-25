extends Node

var bigest_id = 0
func getNewId() -> int:
	bigest_id += 1
	return bigest_id - 1

var buildings = [
	{
		"Name" = "Emmiter",
		"ToolTip" = "Emmits Extractium",
		"ModelPath" = "res://Assets/Models/Emiter.tscn",
	}
]
