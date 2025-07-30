extends Node

var BUILDINGS = {
    "emmiter" : {
        "Name" : "emmiter", #naem that will be displayed and just to simpler to get :D
        "Occupied_cells" : [ #rotates from 0,0 and can even be detached
            Vector2(0,0) #Uses pos/16 so keep that in mind uses building coords
        ],
        "Textures" : [ # basicly frames
            {
                "Path" : "res://Assets/newTiles.png",
                "Offset" : Rect2(0, 32, 16, 16)
            },
            {
                "Path" : "res://Assets/newTiles.png",
                "Offset" : Rect2(16, 32, 16, 16)
            }
        ],
        "Intake" : [], #this is which cells accept input and wath type also the direction
        "Storage" : 0,
        "Functions" : [ #these are the functions that get run by class like [dunction name]_init and [function_name]_update and [function_name]_destroy
            {
                "Name" : "Emmision", #techincly this is a custom function so params can change altho keep the same funcion name
                "Params" : { #this means if you don't like this custominazation or want somthing more then you can easily code it yourself :D
                    "Liquid_id" : 0,
                    "Output_id" : 0, #gets from this data the 0 output port
                    "Amount" : 1,
                    "Delay" : 1
                }
            }
        ],
        "Outputs" : [
            {
                "Position" : Vector2(5,0), #uses world coords for detailed emmision
                "Size" : Vector2(2,14),
                "Velocity" : Vector2(10,0) # gets affected by rotation
            }
        ]
    },
    "collector" : { ##UNFINISHED JUST WANTED SHOW HOW TRANSFERS WORK
        "Name" : "emmiter",
        "Occupied_cells" : [
            Vector2(0,0)
        ],
        "Textures" : [
            {
                "Path" : "res://Assets/newTiles.png",
                "Offset" : Rect2(0, 32, 16, 16)
            },
            {
                "Path" : "res://Assets/newTiles.png",
                "Offset" : Rect2(16, 32, 16, 16)
            }
        ],
        "Intake" : [
            { #THIS isn't for collector is just for crafter
                "Position" : Vector2(0,0), #Uses world coords
                "Rotation" : 0, # rotation is in like 0 - 0, 1 - 90, 2 - 180, 3 - 270
                "Type" : 0
            }
        ], 
        "Storage" : 50, #Size of container
        "Functions" : [ 
            {
                "Name" : "Explosion", #Explodes function wich dosn't yet exist but imagine, also functions can add custom velocity, well will be able to
                "Params" : {
                    "Output" : 0 #Where it all explodes to
                }
            },
            {
                "Name" : "Transfer",
                "Params" : {
                    "Speed" : 1,
                    "Output" : 1
                }
            },
            {
                "Name" : "Collect", #Will have to creat area2d using only script
                "Params" : {
                    "Position" : Vector2(0,0)
                }
            }
        ],
        "Outputs" : [
            {
                "Position" : Vector2(0,0), #uses world coords for detailed emmision
                "Size" : Vector2(16,16),
                "Velocity" : Vector2(0,0) # gets affected by rotation
            },
            {
                "Position" : Vector2(1,0), #Uses building coords for grid modifications
                "Rotation": 0,
                "Type" : 0 #Used so there can be multiple type pipes/ passes
            }
        ]
    }
}

var buildings_position = {}
var buildings = []
var buildings_free_id = 0
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

func clear_spot(in_spot_id : int) -> void:
    if in_spot_id >= buildings.size() -1:
        buildings.pop_back()
    else:
        buildings[in_spot_id] = null
    if in_spot_id < buildings_free_id:
        buildings_free_id = in_spot_id

func check_placable(in_building_type : String, in_position : Vector2, in_rotation : int):
    (x,y) (-y,x) (-x,-y) (y,-x) # rotates clockwise 90 degresee
    var check_cells = buildings[in_building_type]["Occupied_cells"]
    match in_rotation:
        0:
            for iter_cell_position in check_cells:
                if #Check position + offset and for next one rotate 'em
        1:

