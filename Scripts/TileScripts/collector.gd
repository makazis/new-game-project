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
					building.explode()
					continue
				if not i.liquid_name in storage:
					storage[i.liquid_name]=1
				else:
					storage[i.liquid_name]+=1
				total_in_storage+=1
				i.queue_free()
	if building.has_building(direction):
		if building.get_building(direction).can_intake_liquid:
			var del_storage=true
			for i in storage:
				if ((direction+2)-building.get_building(direction).object.direction)%4 in building.get_building(direction).inputs:
					if building.get_building(direction).total_storage>building.get_building(direction).max_storage:
						del_storage=false
						continue
					if not i in building.get_building(direction).storage :
						building.get_building(direction).storage[i]=storage[i]
						
					else:
						building.get_building(direction).storage[i]+=storage[i]
					building.get_building(direction).total_storage+=storage[i]
					total_in_storage-=storage[i]
					building.get_building(direction).Update()
			if del_storage:
				storage={}
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.erase(body)
