extends Panel

var item_name = ""
var item_desc = ""
var item_type = ""
var item_price = 0
var inventory_item=preload("res://Scenes/inventory_item.tscn")

func refresh() -> void:
	$VBoxContainer/Name.text = item_name
	if len(item_name)>14:
		$VBoxContainer/Name.add_theme_font_size_override("font_size",20)
	$VBoxContainer/Desc.text = item_desc

func _process(delta: float) -> void:
	if item_price > Order.money:
		$VBoxContainer/Buy.text = "---x---" 
	else:
		$VBoxContainer/Buy.text = "!!!BUY!!!"

func _on_buy_button_up() -> void:
	if item_price <= Order.money:
		Order.money -= item_price
		Global.create_and_add_item(item_type, 1)
		Global.game.GUI.demiload()
		refresh()
