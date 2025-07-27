extends Panel

var item_name = ""
var item_desc = ""
var item_price = 0
var item_id=0
var item_data={}
var inventory_item=preload("res://Scenes/inventory_item.tscn")
var prepared_item=null
func refresh() -> void:
	$VBoxContainer/Name.text = item_name
	if len(item_name)>14:
		$VBoxContainer/Name.add_theme_font_size_override("font_size",20)
	$VBoxContainer/Desc.text = item_desc
	if item_price > Order.money:
		$VBoxContainer/Buy.text = "jjjXjjj" 
	else:
		$VBoxContainer/Buy.text = "!!!BUY!!!"
	prepare_item()
func prepare_item():
	var temp_item=inventory_item.instantiate()
	temp_item.assign(item_id)
	if "Storage" in item_data:
		temp_item.storage=item_data["Storage"]
	prepared_item=temp_item
func _on_buy_button_up() -> void:
	if item_price <= Order.money:
		Order.money -= item_price
		Global.add_item_to_inv(prepared_item)
		Global.game.GUI.demiload()
		refresh()
