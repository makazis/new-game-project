extends Panel

var item_name = ""
var item_desc = ""
var item_price = 0

func refresh() -> void:
    $VBoxContainer/Name.text = item_name
    $VBoxContainer/Desc.text = item_desc
    if item_price > Order.money:
        $VBoxContainer/Buy.text = "jjjXjjj" 
    else:
        $VBoxContainer/Buy.text = "!!!BUY!!!"

func _on_buy_button_up() -> void:
    if item_price <= Order.money:
        Order.money -= item_price

