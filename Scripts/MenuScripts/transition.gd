extends Node2D

var juice_thingy = preload("res://Scenes/menu/juice_gravity.tscn")

func transition(in_transition_scene):
	var balls = 0
	var prev_spawn = 1
	for i in range(28):
		await get_tree().create_timer(0.02).timeout
		prev_spawn += 1
		for ii in range(prev_spawn):
			balls += 1
			var temp_juice = juice_thingy.instantiate()
			temp_juice.position = Vector2(320 + randf_range(-320,320),-200)
			$Juices.add_child(temp_juice)
	# print(balls)
	await get_tree().create_timer(1).timeout
	Global.transition_instance = []
	for ball in $Juices.get_children():
		Global.transition_instance.append([ball.position,ball.rotation,ball.linear_velocity])
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
