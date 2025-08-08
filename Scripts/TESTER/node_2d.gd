extends Node2D

func _ready() -> void:
    print(Buildings.PlaceBuilding("emmiter", Vector2(0,0), 1, self))
    print(Buildings.PlaceBuilding("emmiter", Vector2(1,0), 1, self))
    print(Buildings.PlaceBuilding("emmiter", Vector2(2,0), 0, self))
    print(BuildingPosition.buildings_position)
    print(BuildingsId.buildings[0].CELL_POS)