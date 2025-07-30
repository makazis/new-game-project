extends Control

func demiload():
	for i in $Panel.get_children():
		if i.has_method("demiload"):
			i.demiload()

func _process(delta: float) -> void:
	$Panel/Label.text=$Panel/ChangeableLiquidIcon.selected_liquid
