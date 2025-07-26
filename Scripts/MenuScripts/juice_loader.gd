extends Node2D

var juice = preload("res://Scenes/menu/juice_gravity.tscn")

func _init() -> void:
	for pos_rot in Global.transition_instance:
		var tempJuice = juice.instantiate()
		add_child(tempJuice)
		tempJuice.position = pos_rot[0]
		tempJuice.rotation = pos_rot[1]
		tempJuice.linear_velocity = pos_rot[2]
func _ready() -> void:
	await get_tree().create_timer(10).timeout
	get_parent().queue_free()
