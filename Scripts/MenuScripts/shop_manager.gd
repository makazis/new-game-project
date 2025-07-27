extends Panel

var shop_item = preload("res://Scenes/menu/shop.tscn")

func addItem(in_name, in_desc, in_price, item_ID, item_data={}) -> void:
	var temp_shop_item = shop_item.instantiate()
	$ScrollContainer/VBoxContainer.add_child(temp_shop_item)
	temp_shop_item.item_name = in_name
	temp_shop_item.item_desc = in_desc
	temp_shop_item.item_price = in_price
	temp_shop_item.item_id = item_ID
	temp_shop_item.item_data = item_data
	temp_shop_item.refresh()

func _ready() -> void:
	addItem("Barrel of Human Blood","Just... don't ask.\ncontains 10 human blood\n12 $",12,8,{"Storage":{"Human Blood":10}})
	addItem("Emmiter","Has a 2x2 water source.\ncreates more water.\n15 $",12,3)
	addItem("Collector","Collects items.\nsometimes explodes.\n5 $",5,1)
	addItem("Conveyor","Transports Items.\n\n2 $",2,0)
	addItem("Extractor","Extracts the first.\nitem to another direction\n75 $",75,0)
	
