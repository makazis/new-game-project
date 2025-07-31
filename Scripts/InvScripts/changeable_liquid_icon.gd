extends Control

var selected_liquid="Water"
func demiload() -> void:
	$NumIcon.setup("Water",1,1)
	$"Liquid Searcher".demiload()
func _process(delta: float) -> void:
	if $NumIcon.chosen:
		$NumIcon.chosen=false
		$"Liquid Searcher".visible=true


func _on_liquid_searcher_chosen_element() -> void:
	$"Liquid Searcher".visible=false
	$NumIcon.setup($"Liquid Searcher".selected_liquid,1,1)
	selected_liquid=$"Liquid Searcher".selected_liquid
