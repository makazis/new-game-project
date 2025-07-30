extends Node2D

var direction = 0
@onready var area=$Area2D
var colliding_bodies=[]
var building
var direction_vector=Vector2(-1,0)

var storage={}
var total_in_storage=0 #out of 100
func _physics_process(delta: float) -> void:
	for i in colliding_bodies:
		var dist_x=global_position.x-i.global_position.x
		var dist_y=global_position.y-i.global_position.y
		if -dist_x>abs(dist_y):
			i.apply_force(Vector2(dist_x,dist_y)*delta*1000)
		if abs(dist_x)+abs(dist_y)<7:
			if total_in_storage<100:
				if randi_range(1,50)<=total_in_storage-50:
					building.explode(total_in_storage/50)
					continue
				if not i.liquid_name in storage:
					storage[i.liquid_name]=1
				else:
					storage[i.liquid_name]+=1
				total_in_storage+=1
				i.queue_free()
	building.storage=storage	
	if building.has_building(direction):
		if building.get_building(direction).can_intake_liquid:
			var del_storage=true
			var push_left = 5
			for i in storage:
				if ((direction+2)-building.get_building(direction).object.direction)%4 in building.get_building(direction).inputs:
					if building.get_building(direction).total_storage>building.get_building(direction).max_storage:
						del_storage=false
						
						continue
					var pushed=min(storage[i],push_left)
					if not i in building.get_building(direction).storage :
						building.get_building(direction).storage[i]=pushed
					else:
						if building.get_building(direction).storage[i]==null:
							building.get_building(direction).storage[i]=0
						building.get_building(direction).storage[i]+=pushed
					building.get_building(direction).total_storage+=pushed
					total_in_storage-=pushed
					storage[i]-=pushed
					push_left-=pushed
					building.get_building(direction).Update()
	building.storage=storage
			#if del_storage:
			#	storage={}
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.erase(body)

func _ready() -> void:
	$"AnimatedSprite2D".play("default")
	if Global.first_animator==null:
		Global.first_animator=$"AnimatedSprite2D"
	else:
		$"AnimatedSprite2D".set_frame_and_progress(Global.first_animator.get_frame(),Global.first_animator.get_frame_progress())
