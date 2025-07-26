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
		if abs(dist_x)+abs(dist_y)<14:
			if total_in_storage<200:
				if randi_range(1,100)<=total_in_storage-100:
					building.explode()
				if not i.liquid_name in storage:
					storage[i.liquid_name]=1
				storage[i.liquid_name]+=1
				total_in_storage+=1
				i.queue_free()
				if building.has_building(direction):
					if building.get_building(direction).can_intake_liquid:
						#print((direction+2)," ",building.get_building(direction).object.direction," ",building.get_building(direction).inputs)
						if ((direction+2)-building.get_building(direction).object.direction)%4 in building.get_building(direction).inputs:
							if not i.liquid_name in building.get_building(direction).storage :
								building.get_building(direction).storage[i.liquid_name]=1
							else:
								building.get_building(direction).storage[i.liquid_name]+=1
							building.get_building(direction).Update()
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.erase(body)
