extends Node2D


func creatBuilding(in_buildings_id, in_direction, in_position) -> Node2D:
	var object = load(Global.buildings[in_buildings_id]["ModelPath"]).instantiate()
	$Buildings.add_child(object)
	object.position = in_position
	object.setBuildingParams(in_buildings_id, in_direction)
	return object

var temp_building = []
func _ready() -> void:
	temp_building.append(creatBuilding(0, 0, Vector2(0,0)))
	temp_building.append(creatBuilding(0, 0, Vector2(10,0)))
	temp_building.append(creatBuilding(0, 0, Vector2(0,10)))
	temp_building.append(creatBuilding(0, 0, Vector2(10,10)))


var delay = 0
func _process(delta: float) -> void:
	delay += delta
	if delay > 1:
		delay = 0
		for iter_building in temp_building:
			iter_building.rotateNb(iter_building.direction + 1)

var inv_open=true
func _input(event):
	if event.is_action_pressed("inventory"):
		inv_open=not inv_open
		$CanvasLayer/GUI.visible=inv_open
		$CanvasLayer/Inventory.visible=not inv_open
		Global.drag_locked=not inv_open
		$CanvasLayer/Inventory.demiload()
		$CanvasLayer/GUI.demiload()
