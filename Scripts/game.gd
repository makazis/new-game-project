extends Node2D
var liquid=preload("res://Scenes/free_thinking_juice.tscn")
	


#This is only for the buildings that require actual 
class Local_Timer:
	var time_left : float
	var period : int
	var internal_timer : Timer
	var is_finished: bool
	func _init(in_period) -> void:
		internal_timer=Timer.new()
		internal_timer.timeout.connect(on_timeout)
		Global.game.add_child(internal_timer)
		is_finished=false
		period=in_period
		reset()
	func on_timeout():
		is_finished=true
	func reset():
		is_finished=false
		internal_timer.start(period)
class building:
	var liquid=preload("res://Scenes/free_thinking_juice.tscn")
	var id : int
	var classification_id : int
	var name : String
	var tool_tip : String
	var object : Node2D
	var direction : int
	var storage: Dictionary
	var item_timers : Array
	var direction_vector : Vector2
	#stores as position/16
	var pos : Vector2
	var can_intake_liquid : bool
	var inputs=[]
	var _parent
	var max_storage: int
	var total_storage: int
	func _init(in_buildings_id, in_direction, parent, position) -> void:
		id = Global.getNewId()
		classification_id = in_buildings_id
		name = Global.buildings[in_buildings_id]["Name"]
		tool_tip = Global.buildings[in_buildings_id]["ToolTip"]
		object = load(Global.buildings[in_buildings_id]["ModelPath"]).instantiate()
		
		direction=in_direction
		direction_vector=[Vector2(-1,0),Vector2(0,-1),Vector2(1,0),Vector2(0,1)][in_direction]	
		object.direction=in_direction
		object.direction_vector=direction_vector
		object.building=self
		parent.add_child(object)
		rotate(in_direction)
		storage={}
		pos=position
		_parent=parent
		object.position = position*16+Vector2(8,8)
		if not position in Global.taken_squares:
			Global.taken_squares[position]=self
		item_timers=[Local_Timer.new(1.5),Local_Timer.new(1)]
		Global.buildings_2.append(self)
		if classification_id in [5,6]:
			can_intake_liquid=true
		if classification_id==5: 
			inputs=[1,3]
			max_storage=50
		if classification_id==6: 
			inputs=[1]
			max_storage=1000
	func rotate(in_direction) -> void:
		direction = in_direction % 4
		# print(direction)
		#Don't question this line it is perfect and shouldn't be tuched (mkaestexture right dir)
		object.get_node("Sprite2D").region_rect = Rect2(direction*16,object.get_node("Sprite2D").region_rect.position.y,object.get_node("Sprite2D").region_rect.size.x,object.get_node("Sprite2D").region_rect.size.y)
	func per_frame(delta):
		if classification_id == 3: #Emitter 
			if item_timers[0].is_finished:
				create_liquid(0)
				item_timers[0].reset()
		if classification_id==5:
			if item_timers[0].is_finished:
				slow_Update()
				item_timers[0].reset()
	#func get_adjacent_building(to_direction):
	#
	func create_liquid(liquid_ID):
		var new_particle=liquid.instantiate()
		Global.game.add_child(new_particle)
		new_particle.assign(liquid_ID)
		new_particle.position=object.position+Vector2(randi_range(-3,3),randi_range(-3,3))
		new_particle.apply_force(direction_vector*1000+Vector2(randi_range(-7,7),randi_range(-7,7))*25)
	func add_to_storage(item,quantity):
		if not item in storage:
			storage[item]=quantity
		else:
			storage[item]+=quantity
	func die():
		if self in Global.buildings_2:
			Global.buildings_2.erase(self)
		if pos in Global.taken_squares:
			Global.taken_squares.erase(pos)
		self.object.queue_free()
	func has_building(_direction):
		return pos+Global.directional_vectors[_direction] in Global.taken_squares
	func get_building(_direction):
		return Global.taken_squares[pos+Global.directional_vectors[_direction]]
	func slow_Update():
		if classification_id == 5: #Merger
			var did_something=false
			for i in Global.crafting_tree:
				if not did_something:
					var can_do=true
					for requirement in i["Req"]:
						if can_do:
							if not requirement in storage:
								can_do=false
								continue
							elif storage[requirement]<i["Req"][requirement]:
								can_do=false
								continue
					if can_do:
						for requirement in i["Req"]:
							storage[requirement]-=i["Req"][requirement]
							total_storage-=i["Req"][requirement]
						for result in i["Result"]:
							for ii in range(i["Result"][result]):
								create_liquid(result)
						did_something=true
	func Update():
		print(storage)
		if classification_id ==6:
			
			for i in storage:
				if not i in Global.in_storage_items:
					Global.in_storage_items[i]=storage[i]
				else:
					Global.in_storage_items[i]+=storage[i]
			total_storage=0
			storage={}
			print(Global.in_storage_items)
	func explode():
		print(storage)
		for liquid_name in storage:
			print(liquid_name)
			for liquid_instance in range(storage[liquid_name]):
				var new_particle=liquid.instantiate()
				
				_parent.add_child(new_particle)
				new_particle.assign(Global.liquid_map_name_to_id[liquid_name])
				new_particle.position=object.position
				var aangle=randf_range(0,PI*2)
				new_particle.linear_velocity.x=cos(aangle)*20
				new_particle.linear_velocity.y=sin(aangle)*20
				print(new_particle.liquid_name)

					
		die()
		var new_building=building.new(7,direction,_parent,pos)
		Global.buildings_2.append(new_building)
		Global.taken_squares[pos]=new_building
func _ready() -> void:
	Global.game = self
	

	var new_particle=liquid.instantiate()
	add_child(new_particle)
	new_particle.assign(8)
	new_particle.position=Vector2(200,200)
var delay = 0
var last_mouse_position = Vector2(0,0)
var inspect_open = false
var inspect_gotten_building = null
var inspect_last_storage_keys = {}
func _process(delta: float) -> void:
	for i in Global.buildings_2:
		i.per_frame(delta)
	if inspect_open:
		if last_mouse_position == get_global_mouse_position():
			if inspect_last_storage_keys == inspect_gotten_building.storage:
				inspect_last_storage_keys = inspect_gotten_building.storage
				var finalText = ""
				finalText += inspect_gotten_building.name + "\n"
				for iter_storage in inspect_gotten_building.storage.keys():
					finalText += iter_storage + " (" + str(inspect_gotten_building.storage[iter_storage]) + ")\n"
				$Camera2D/Inspector/Panel/Label.text = finalText
		else:
			inspect_gotten_building = null
			inspect_open = false
			$Camera2D/Inspector.visible = false
	#this isn't else and don't change it or else it will filcker ;/
	if not inspect_open:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if not Global.selecting_hotbar:
				var gotten_building = Global.getBuildingFromPos(get_global_mouse_position())
				if gotten_building:
					$Camera2D/Inspector.visible = true
					$Camera2D/Inspector.position = $Camera2D.get_local_mouse_position()
					var finalText = ""
					finalText += gotten_building.name + "\n"
					for iter_storage in gotten_building.storage.keys():
						finalText += iter_storage + " (" + str(gotten_building.storage[iter_storage]) + ")\n"
					$Camera2D/Inspector/Panel/Label.text = finalText
					inspect_gotten_building = gotten_building
					inspect_last_storage_keys = gotten_building.storage
					last_mouse_position = get_global_mouse_position()
					inspect_open = true
	
	
var inv_open=true
func _input(event):
	if event.is_action_pressed("inventory"):
		inv_open=not inv_open
		$CanvasLayer/GUI.visible=inv_open
		$CanvasLayer/Inventory.visible=not inv_open
		Global.drag_locked=not inv_open
		$CanvasLayer/Inventory.demiload()
		$CanvasLayer/GUI.demiload()
