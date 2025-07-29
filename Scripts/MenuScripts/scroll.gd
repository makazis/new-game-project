extends VBoxContainer

var velocity_y = 0
var move_to = "Play"
var menu_start = 70
var menu_offset = -220
var menu_sections = [
	"Play", "NewGame", "LoadGame", "Options", "Exit"
]
var switch_speed = 2
var transition = false
func _process(delta: float) -> void:
	velocity_y += (menu_start + menu_sections.find(move_to) * menu_offset - position.y) * delta * 0.5
	position.y += velocity_y
	velocity_y *= 0.9
	for menu_child_name in menu_sections:
		if move_to == menu_child_name: get_node(menu_child_name).modulate += (Color(1.0,1.0,1.0,1.0) - get_node(menu_child_name).modulate) * delta * switch_speed
		else: get_node(menu_child_name).modulate += (Color(1.0,1.0,1.0,0.5) - get_node(menu_child_name).modulate) * delta * switch_speed


#quits
func _on_button_button_up() -> void:
	if transition: return
	get_tree().quit()


func _on_normal_button_up() -> void:
	if transition: return
	Dev.mode="Normal"
	Global.setup_player_inventory()
	get_parent().get_node("Transition").transition("res://Scenes/game.tscn")


func _on_new_game_button_up() -> void:
	move_to = "NewGame"
	


func _on_nightmare_button_up() -> void:
	pass # Replace with function body.

func _on_sandbox_button_up() -> void:
	if transition: return
	Dev.mode="Sandbox"
	Global.setup_player_inventory()
	get_parent().get_node("Transition").transition("res://Scenes/game.tscn")

func _on_load_game_button_up() -> void:
	move_to = "LoadGame"
	Dev.mode="Normal"
