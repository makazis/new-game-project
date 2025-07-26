extends VBoxContainer

var velocity_y = 0
var move_to = "Play"
var offsets = {
	"Play" = 70,
	"Options" = -150,
	"Exit" = -370
}
var switch_speed = 2

func _process(delta: float) -> void:
	velocity_y += (offsets[move_to] - position.y) * delta * 0.5
	position.y += velocity_y
	velocity_y *= 0.9
	if move_to == "Play": $Play.modulate += (Color(1.0,1.0,1.0,1.0) - $Play.modulate) * delta * switch_speed
	else: $Play.modulate += (Color(1.0,1.0,1.0,0.5) - $Play.modulate) * delta * switch_speed
	if move_to == "Options": $Options.modulate += (Color(1.0,1.0,1.0,1.0) - $Options.modulate) * delta * switch_speed
	else: $Options.modulate += (Color(1.0,1.0,1.0,0.5) - $Options.modulate) * delta * switch_speed
	if move_to == "Exit": $Exit.modulate += (Color(1.0,1.0,1.0,1.0) - $Exit.modulate) * delta * switch_speed
	else: $Exit.modulate += (Color(1.0,1.0,1.0,0.5) - $Exit.modulate) * delta * switch_speed


func _on_button_button_up() -> void:
	get_tree().quit()


func _on_start_a_new_game_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
