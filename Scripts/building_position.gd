extends Node

var buildings_position = {}

func Place(in_building) -> void:
	for i_cell_offset in in_building.CELLS:
		var t_cell_position = CellOffset2BuildingsPosition(i_cell_offset, in_building.POSITION, in_building.ROTATION)
		buildings_position[t_cell_position] = in_building.ID
		in_building.CELL_POS.append(t_cell_position)
	in_building.position = in_building.POSITION * 16

#Checks if building can be placed at the spot 
func CheckPlacable(i_building_type : String, i_buildings_position : Vector2, i_building_rotation : int) -> bool:
	var tBuilding_position = convert_global_to_building_position(i_buildings_position)
	var building = Buildings.BUILDINGS[i_building_type]
	var buildings_cell_array = building["Occupied_cells"]
	for i_buildings_cell in buildings_cell_array:
		var t_cell_position = CellOffset2BuildingsPosition(i_buildings_cell,tBuilding_position,i_building_rotation)
		if buildings_position.has(t_cell_position): return false
	return true

#From offset applies buildings position and rotation
func CellOffset2BuildingsPosition(i_offset, i_position, i_rotation) -> Vector2:
	return PossitionRotation(i_offset, i_rotation) + i_position

func get_building_id_from_position(pPos : Vector2) -> int:
	var tPos = convert_global_to_building_position(pPos)
	if buildings_position.has(tPos):
		return buildings_position[tPos]
	else:
		return -1

func convert_global_to_building_position(pPos : Vector2) -> Vector2:
	return floor(pPos/16)

func fRemove_cells(pBuilding):
	print(buildings_position)
	for iCell in pBuilding.CELL_POS:
		buildings_position.erase(iCell)
	print(buildings_position)

#Returns position rotated 0 beeing nno rotation and 3 beeing 270
func PossitionRotation(i_position : Vector2, i_rotation : int) -> Vector2:
	# (x,y) (-y,x) (-x,-y) (y,-x) # rotates clockwise 90 degresee
	match i_rotation:
		0:
			return i_position
		1:
			return Vector2(-i_position.y,i_position.x)
		2:
			return Vector2(-i_position.x,-i_position.y)
		3:
			return Vector2(i_position.y,-i_position.x)
		_:
			print("WARNING INCORECT ROTATION : " + str(i_rotation))
			return Vector2(0,0)
