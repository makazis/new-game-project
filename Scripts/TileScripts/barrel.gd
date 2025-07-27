extends Node2D

var direction = 0
@onready var area=$Area2D
var colliding_bodies=[]
var building
var direction_vector=Vector2(-1,0)

var storage={}
var total_in_storage=0 #out of 100
func _physics_process(delta: float) -> void:
	building.total_storage=total_in_storage
	for i in colliding_bodies:
		if i.linear_velocity.distance_to(Vector2(0,0))>20:
			building.explode()
	#building.storage=storage
			#if del_storage:
			#	storage={}
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Liquid"):
		colliding_bodies.erase(body)
