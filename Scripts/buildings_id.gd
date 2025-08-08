extends Node

var buildings = []
var buildings_free_id = 0

#Adds building to buildings array at the free spot and returns thats buildings id
func ReserveSpot(i_building : Node2D) -> void:
    var save_id = buildings_free_id
    if buildings_free_id >= buildings.size():
        buildings.append(i_building)
        buildings_free_id += 1
    else:
        buildings[buildings_free_id] = i_building
        for iter in range(buildings_free_id, buildings.size()):
            if not buildings[iter]:
                buildings_free_id = iter
                break
        if save_id == buildings_free_id:
            buildings_free_id = buildings.size()
    i_building.ID = save_id
    # return save_id

#deletes building from buildings array
func ClearSpot(i_spot_id : int) -> void:
    if i_spot_id >= buildings.size() -1:
        buildings.pop_back()
    else:
        buildings[i_spot_id] = null
    if i_spot_id < buildings_free_id:
        buildings_free_id = i_spot_id