extends Node

var buildings = []
var buildings_free_id = 0

#Adds building to buildings array at the free spot and returns thats buildings id
func reserve_spot(in_building : Node2D) -> int:
    var save_id = buildings_free_id
    if buildings_free_id >= buildings.size():
        buildings.append(in_building)
        buildings_free_id += 1
    else:
        buildings[buildings_free_id] = in_building
        for iter in range(buildings_free_id, buildings.size()):
            if not buildings[iter]:
                buildings_free_id = iter
                break
        if save_id == buildings_free_id:
            buildings_free_id = buildings.size()
    return save_id

#deletes building from buildings array
func clear_spot(in_spot_id : int) -> void:
    if in_spot_id >= buildings.size() -1:
        buildings.pop_back()
    else:
        buildings[in_spot_id] = null
    if in_spot_id < buildings_free_id:
        buildings_free_id = in_spot_id