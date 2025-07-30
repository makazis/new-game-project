extends Node2D

func _process(delta: float) -> void:
    print(Buildings.reserve_spot(self))
    if randi_range(0,1) == 0:
        Buildings.clear_spot(randi_range(0,Buildings.buildings.size() - 1))