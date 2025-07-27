extends Node2D

@onready var area=$Area2D
var colliding_bodies=[]
var direction = 0
var building
var direction_vector=Vector2(-1,0)
var filter=""
func _physics_process(delta: float) -> void:
	for i in colliding_bodies:
		if i.liquid_name==filter:
			i.apply_force(Global.directional_vectors[(direction+1)%4]*delta*3000)
		else:
			i.apply_force(Global.directional_vectors[(direction+3)%4]*delta*3000)
		if direction%2==1:
			i.apply_force(Vector2(0,global_position.y-i.global_position.y)*delta*1000)
		else:
			i.apply_force(Vector2(global_position.x-i.global_position.x,0)*delta*1000)
		var their_velocity=i.linear_velocity.distance_to(Vector2(0,0))
		if i.ID!=9:
			if their_velocity>12:
				i.linear_velocity/=their_velocity/12
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		if filter=="":
			filter=body.liquid_name
			building.name+=" ("+filter+")"
		colliding_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.erase(body)
