extends Node

var buildings_position = {}

func place(in_building) -> void:
    for i_cell_offset in in_building.CELLS:
        var t_cell_position = CellOffset2BuildingsOffset(i_cell_offset, in_building.POSITION, in_building.ROTATION)
        buildings_position[t_cell_position] = in_building.ID


#Checks if building can be placed at the spot 
func check_placable(in_building_type : String, in_buildings_position : Vector2, in_building_rotation : int) -> bool:
    var building = Buildings.BUILDINGS[in_building_type]
    var buildings_cell_array = building["Occupied_cells"]
    for i_buildings_cell in buildings_cell_array:
        var t_buildings_cell_rotated = PossitionRotation(i_buildings_cell, in_building_rotation)
        var t_cell_position = in_buildings_position + t_buildings_cell_rotated
        if buildings_position[t_cell_position]: return false
    return true

#From offset applies buildings position and rotation
func CellOffset2BuildingsOffset(i_offset, i_position, i_rotation) -> Vector2:
    return PossitionRotation(i_offset, i_rotation) + i_position

#Returns position rotated 0 beeing nno rotation and 3 beeing 270
func PossitionRotation(in_position : Vector2, in_rotation : int) -> Vector2:
    # (x,y) (-y,x) (-x,-y) (y,-x) # rotates clockwise 90 degresee
    match in_rotation:
        0:
            return in_position
        1:
            return Vector2(-in_position.y,in_position.x)
        2:
            return Vector2(-in_position.x,-in_position.y)
        3:
            return Vector2(in_position.y,-in_position.x)
        _:
            print("WARNING INCORECT ROTATION : " + str(in_rotation))
            return Vector2(0,0)