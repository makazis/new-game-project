extends TextureButton

@onready var label=$Label
var item
func update_item(new_item):
	item=new_item
	if item==null:
		return
	texture_normal=item.item_texture
	label.text=str(item.item_count)

func clear_item():
	item=null
	texture_normal=null
	label.text=""
func _ready():
	clear_item()

#func _on_button_down() -> void:
#	is_pressed=true


#func _on_button_up() -> void:
#	pass # Replace with function body.
