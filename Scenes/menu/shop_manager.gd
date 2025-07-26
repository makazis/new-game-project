extends Panel

var shop_item = preload("res://Scenes/menu/shop.tscn")

func addItem(in_name, in_desc, in_price) -> void:
	var temp_shop_item = shop_item.instantiate()
	$ScrollContainer/VBoxContainer.add_child(temp_shop_item)
	temp_shop_item.item_name = in_name
	temp_shop_item.item_desc = in_desc
	temp_shop_item.item_price = in_price
	temp_shop_item.refresh()

func _ready() -> void:
	addItem("TEST","i am test item\ncome buy me\n5 - moneys",5)
