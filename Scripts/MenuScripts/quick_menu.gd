extends Control

var open = false
var open_speed = 10
var quest_open = false
var shop_open = false

@onready var heading = $Heading
@onready var options = $Options
@onready var orders = $Orders
@onready var shop = $Shop
@onready var money = $Money

var rectracted_positions = {
	"heading" = Vector2(-250,5),
	"options" = Vector2(-150,70),
	"orders" = Vector2(640,5),
	"money" = Vector2(-95,70)
}

var default_positions = {
	"heading" = Vector2(0,5),
	"options" = Vector2(0,70),
	"orders" = Vector2(440,5),
	"money" = Vector2(155,70)
}  

func _ready() -> void:
	heading.position = rectracted_positions["heading"]
	options.position = rectracted_positions["options"]
	orders.position = rectracted_positions["orders"]
	shop.position = rectracted_positions["orders"]
	money.position = rectracted_positions["money"]

	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		open = not open
		load_quests()
		Global.menu_open = open
	if open:
		heading.position += (default_positions["heading"] - heading.position) * delta * open_speed
		options.position += (default_positions["options"] - options.position) * delta * open_speed
		money.position += (default_positions["money"] - money.position) * delta * open_speed
		if quest_open:
			orders.position += (default_positions["orders"] - orders.position) * delta * open_speed
		else:
			orders.position += (rectracted_positions["orders"] - orders.position) * delta * open_speed
		if shop_open:
			shop.position += (default_positions["orders"] - shop.position) * delta * open_speed
		else:
			shop.position += (rectracted_positions["orders"] - shop.position) * delta * open_speed
	else:
		heading.position += (rectracted_positions["heading"] - heading.position) * delta * open_speed
		options.position += (rectracted_positions["options"] - options.position) * delta * open_speed
		orders.position += (rectracted_positions["orders"] - orders.position) * delta * open_speed
		money.position += (rectracted_positions["money"] - money.position) * delta * open_speed
		shop.position += (rectracted_positions["orders"] - shop.position) * delta * open_speed

func load_quests():
	for i in range(3):
		var end_text=""
		for ii in Order.offered_requests[i].request:
			end_text+=str(Global.liquid_map_id_to_name[ii])+" x"+str(Order.offered_requests[i].request[ii])+"\n"
		end_text+=str(Order.offered_requests[i].money_for_this)+"$"
		$Orders/VBoxContainer.get_child(i).get_child(0).text=end_text
func _on_continue_button_up() -> void:
	open = false
	Global.menu_open = false

func _on_quests_2_button_up() -> void:
	quest_open = true
	shop_open = false

func _on_shop_button_up() -> void:
	quest_open = false
	shop_open = true

func _on_fullscreen_button_up() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_exit_button_up() -> void:
	get_tree().quit()
