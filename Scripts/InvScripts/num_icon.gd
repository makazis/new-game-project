extends Panel

var ID=0
var element_name="Water"
var ammount=1
func setup(liquid,_ammount):
	ID=Global.liquid_map_name_to_id[liquid]
	element_name=liquid
	ammount=_ammount
	if not element_name in Global.known_liquids:
		$Sprite2D.region_rect=Rect2(240,240,16,16)
	else:
		$Sprite2D.region_rect=Rect2(ID%16*16,(ID/16)*16,16,16)
	if _ammount>1:
		$Label.text=str(_ammount)+"x"
	else:
		$Label.text=""
		custom_minimum_size=Vector2(20,20)
		$Sprite2D.position=Vector2(10,10)


func _on_button_button_up() -> void:
	Global.game.inv.load_element(element_name)
