extends Node2D

#wich paths emit and wich take in liquids
var paths = {
    "in" = [],
    "out" = [0]
}

var id : int
var classification_id : int
var tool_tip : String
var direction : int

func setBuildingParams(in_buildings_id, in_direction)->void:
    id = Global.getNewId()
    classification_id = in_buildings_id
    name = Global.buildings[in_buildings_id]["Name"]
    tool_tip = Global.buildings[in_buildings_id]["ToolTip"]
    rotate(in_direction)

func rotateNb(in_direction) -> void:
    direction = in_direction % 4
    # print(direction)
    #Don't question this line it is perfect and shouldn't be tuched (mkaestexture right dir)
    get_node("Sprite2D").region_rect = Rect2(direction*16,get_node("Sprite2D").region_rect.position.y,get_node("Sprite2D").region_rect.size.x,get_node("Sprite2D").region_rect.size.y)
