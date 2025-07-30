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
        "Functions" : [ #these are the functions that get run by class like [dunction name]_init and [function_name]_update
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
    }
}