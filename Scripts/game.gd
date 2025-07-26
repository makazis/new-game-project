extends Node2D

#This is only for the buildings that require actual 
class Local_Timer:
	var time_left : float
	var period : int
	var internal_timer : Timer
	var is_finished: bool
	func _init(in_period) -> void:
		internal_timer=Timer.new()
		internal_timer.timeout.connect(on_timeout)
		is_finished=false
		period=in_period
	func on_timeout():
		is_finished=true
	func reset():
		is_finished=false
		internal_timer.wait_time=period
		internal_timer.start()
class building:
	var id : int
	var classification_id : int
	var name : String
	var tool_tip : String
	var object : Node2D
	var direction : int
	var storage: Dictionary
	var item_timers : Array
	func _init(in_buildings_id, in_direction, parent, position) -> void:
		id = Global.getNewId()
		classification_id = in_buildings_id
		name = Global.buildings[in_buildings_id]["Name"]
		tool_tip = Global.buildings[in_buildings_id]["ToolTip"]
		object = load(Global.buildings[in_buildings_id]["ModelPath"]).instantiate()
		parent.add_child(object)
		rotate(in_direction)
		storage={}
		object.position = position*16+Vector2(8,8)
		if not position in Global.taken_squares:
			Global.taken_squares[position]=self
		item_timers=[Local_Timer.new(1.5),Local_Timer.new(1)]
		Global.buildings_2.append(self)
	func rotate(in_direction) -> void:
		direction = in_direction % 4
		# print(direction)
		#Don't question this line it is perfect and shouldn't be tuched (mkaestexture right dir)
		object.get_node("Sprite2D").region_rect = Rect2(direction*16,object.get_node("Sprite2D").region_rect.position.y,object.get_node("Sprite2D").region_rect.size.x,object.get_node("Sprite2D").region_rect.size.y)
	func per_frame(delta):
		if classification_id == 3: #Emitter 
			if item_timers[0].is_finished:
				add_to_storage("Neothol",1)
				item_timers[0].reset()
			if item_timers[1].is_finished:

				add_to_storage("Neothol",1)
				item_timers[1].reset()
	#func get_adjacent_building(to_direction):
	#	var direction_vector=[Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)][to_direction]


	func add_to_storage(item,quantity):
		if not item in storage:
			storage[item]=quantity
		else:
			storage[item]+=quantity
	func die():
		if self in Global.buildings:
			Global.buildings_2.erase(self)
var temp_building : building
func _ready() -> void:
	temp_building = building.new(0, 0, $Buildings, Vector2(0,0))

var delay = 0
func _process(delta: float) -> void:
	delay += delta
	if delay > 1:
		delay = 0
		temp_building.rotate(temp_building.direction + 1)
	for i in Global.buildings_2:
		i.per_frame(delta)
var inv_open=true
func _input(event):
	if event.is_action_pressed("inventory"):
		inv_open=not inv_open
		$CanvasLayer/GUI.visible=inv_open
		$CanvasLayer/Inventory.visible=not inv_open
		Global.drag_locked=not inv_open
		$CanvasLayer/Inventory.demiload()
		$CanvasLayer/GUI.demiload()
