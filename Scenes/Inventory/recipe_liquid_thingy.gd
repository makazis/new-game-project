extends Control

var item_count=0
var selected_liquid="Water"
func demiload():
	$"ChangeableLiquidIcon".demiload()

func _process(delta: float) -> void:
	$Label.text=$ChangeableLiquidIcon.selected_liquid
	selected_liquid=$ChangeableLiquidIcon.selected_liquid

func _on_line_edit_text_changed(new_text: String) -> void:
	for i in new_text:
		if not i in "0123456789":
			item_count=0
			$Times.text="x"+str(item_count)
			return
	item_count=int(new_text)
	$Times.text="x"+str(item_count)
