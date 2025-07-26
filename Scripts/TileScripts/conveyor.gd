extends Node2D

@onready var area=$Area2D
var colliding_bodies=[]
var direction = 0
var building
var direction_vector=Vector2(-1,0)
func _physics_process(delta: float) -> void:
	for i in colliding_bodies:
		i.apply_force(direction_vector*delta*3000)
		if direction%2==0:
			i.apply_force(Vector2(0,global_position.y-i.global_position.y)*delta*1000)
		else:
			i.apply_force(Vector2(global_position.x-i.global_position.x,0)*delta*1000)
		var their_velocity=i.linear_velocity.distance_to(Vector2(0,0))
		if their_velocity>12:
			i.linear_velocity/=their_velocity/12
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.erase(body)
