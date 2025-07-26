extends Control

var open = false
var open_speed = 10
var quest_open = false
var shop_open = false

@onready var heading = $Heading
@onready var options = $Options
@onready var orders = $Orders

var rectracted_positions = {
	"heading" = Vector2(-220,5),
	"options" = Vector2(-150,70),
	"orders" = Vector2(640,5)
}

var default_positions = {
	"heading" = Vector2(0,5),
	"options" = Vector2(0,70),
	"orders" = Vector2(440,5)
}  

func _ready() -> void:
	heading.position = rectracted_positions["heading"]
	options.position = rectracted_positions["options"]
	orders.position = rectracted_positions["orders"]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		open = not open
	if open:
		heading.position += (default_positions["heading"] - heading.position) * delta * open_speed
		options.position += (default_positions["options"] - options.position) * delta * open_speed
		if quest_open:
			orders.position += (default_positions["orders"] - orders.position) * delta * open_speed
		else:
			orders.position += (rectracted_positions["orders"] - orders.position) * delta * open_speed
	else:
		heading.position += (rectracted_positions["heading"] - heading.position) * delta * open_speed
		options.position += (rectracted_positions["options"] - options.position) * delta * open_speed
		orders.position += (rectracted_positions["orders"] - orders.position) * delta * open_speed

func _on_continue_button_up() -> void:
	open = false

func _on_quests_2_button_up() -> void:
	quest_open = true
	shop_open = false

func _on_shop_button_up() -> void:
	quest_open = false
	shop_open = false

func _on_fullscreen_button_up() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_exit_button_up() -> void:
	get_tree().quit()
