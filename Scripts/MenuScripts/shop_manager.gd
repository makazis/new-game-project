extends Panel

var shop_item = preload("res://Scenes/menu/shop.tscn")

func addItem(in_name, in_desc, in_price, pType : String) -> void:
	var temp_shop_item = shop_item.instantiate()
	$ScrollContainer/VBoxContainer.add_child(temp_shop_item)
	temp_shop_item.item_name = in_name
	temp_shop_item.item_desc = in_desc
	temp_shop_item.item_price = in_price
	temp_shop_item.item_type = pType
	temp_shop_item.refresh()

func _ready() -> void:
	addItem("Barrel of Human Blood","Just... don't ask.\ncontains 10 human blood\n12 $",12,"blood_barrel")
	addItem("Emmiter","Has a 2x2 water source.\ncreates more water.\n15 $",15,"emmiter")
	addItem("Collector","Collects items.\nsometimes explodes.\n5 $",5,"collector")
	addItem("Conveyor","Transports Items.\n\n2 $",2,"conveyor")
	addItem("Fuser","Fuses Items into new items.\n\n20 $",20,"fuser")
	addItem("Storer","Stores items.\n\n75 $",75,"storer")
	print("ADD EXTRACTOR!! - shop_manager.gd, 21st line")
	addItem("Extractor","Extracts Items.\n\n80 $",80,"blood_barrel")
