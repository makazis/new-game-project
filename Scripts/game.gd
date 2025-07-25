extends Node2D

class building:
	var id : int
	var classification_id : int
	var name : String
	var tool_tip : String
	var object : Node2D
	var direction : int
	func _init(in_buildings_id, in_direction, parent, position) -> void:
		id = Global.getNewId()
		classification_id = in_buildings_id
		name = Global.buildings[in_buildings_id]["Name"]
		tool_tip = Global.buildings[in_buildings_id]["ToolTip"]
		object = load(Global.buildings[in_buildings_id]["ModelPath"]).instantiate()
		parent.add_child(object)
		rotate(in_direction)
		object.position = position
	
	func rotate(in_direction) -> void:
		direction = in_direction % 4
		print(direction)
		#Don't question this line it is perfect and shouldn't be tuched (mkaestexture right dir)
		object.get_node("Sprite2D").region_rect = Rect2(direction*16,object.get_node("Sprite2D").region_rect.position.y,object.get_node("Sprite2D").region_rect.size.x,object.get_node("Sprite2D").region_rect.size.y)


var temp_building : building
func _ready() -> void:
	temp_building = building.new(0, 0, $Buildings, Vector2(0,0))

var delay = 0
func _process(delta: float) -> void:
	delay += delta
	if delay > 1:
		delay = 0
		temp_building.rotate(temp_building.direction + 1)

var inv_open=false
func _input(event):
	if event.is_action_pressed("inventory"):
		inv_open=not inv_open
		$CanvasLayer/GUI.visible=inv_open
		$CanvasLayer/Inventory.visible=not inv_open
		Global.drag_locked=not inv_open
		$CanvasLayer/Inventory.demiload()
