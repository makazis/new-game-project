extends Node

var BUILDING_TEMPLATE = preload("res://Scenes/buildings.tscn")

func PlaceBuilding(i_type : String, i_position : Vector2, i_rotation : int, parent : Node2D) -> bool:
	if not BuildingPosition.CheckPlacable(i_type, i_position, i_rotation): return false
	var t_building = BUILDING_TEMPLATE.instantiate()
	parent.add_child(t_building)
	BuildingsId.ReserveSpot(t_building)
	t_building.init(BUILDINGS[i_type], i_position, i_rotation)
	BuildingPosition.Place(t_building)
	return true

func GetBuildingFromPos(i_position):
	if BuildingPosition.buildings_position.has(floor(i_position/16)):
		var t_buildgins_id = BuildingPosition.buildings_position[floor(i_position/16)]
		return BuildingsId.buildings[t_buildgins_id]
	return null

#Defult rotation is right
#List of all buildings
var BUILDINGS = {
	# "emmiter" : {
	# 	"Name" : "emmiter", #naem that will be displayed and just to simpler to get :D
	# 	"Occupied_cells" : [ #rotates from 0,0 and can even be detached
	# 		Vector2(0,0), #Uses pos/16 so keep that in mind uses building coords
	# 		Vector2(1,0)
	# 	],
	# 	"Textures" : [ # basicly frames 0 frame for inv display
	# 		{
	# 			"Path" : "res://Assets/newTiles.png",
	# 			"Offset" : Rect2(0, 32, 16, 16)
	# 		},
	# 		{
	# 			"Path" : "res://Assets/newTiles.png",
	# 			"Offset" : Rect2(16, 32, 16, 16)
	# 		}
	# 	],
	# 	"Intake" : [], #this is which cells accept input and wath type also the direction
	# 	"Storage" : 0,
    #     "Stored" : {}, #Already present liquids like blood barrel
	# 	"Functions" : [ #these are the functions that get run by class like [dunction name]_init and [function_name]_update and [function_name]_destroy
	# 		{
	# 			"Name" : "Animation",
	# 			"Params" : {
	# 				"Animations_idexes" : [0,1]
	# 			}
	# 		},
	# 		{
	# 			"Name" : "Emmision", #techincly this is a custom function so params can change altho keep the same funcion name
	# 			"Params" : { #this means if you don't like this custominazation or want somthing more then you can easily code it yourself :D
	# 				"Liquid_id" : 0,
	# 				"Output_id" : 0, #gets from this data the 0 output port
	# 				"Amount" : 1,
	# 				"Delay" : 1
	# 			}
	# 		}
	# 	],
	# 	"Outputs" : [
	# 		{
	# 			"Position" : Vector2(5,0), #uses world coords for detailed emmision
	# 			"Size" : Vector2(2,14),
	# 			"Velocity" : Vector2(10,0) # gets affected by rotation
	# 		}
	# 	]
	# },
	# "collector" : { ##UNFINISHED JUST WANTED SHOW HOW TRANSFERS WORK
	# 	"Name" : "emmiter",
	# 	"Occupied_cells" : [
	# 		Vector2(0,0)
	# 	],
	# 	"Textures" : [
	# 		{
	# 			"Path" : "res://Assets/newTiles.png",
	# 			"Offset" : Rect2(0, 32, 16, 16)
	# 		},
	# 		{
	# 			"Path" : "res://Assets/newTiles.png",
	# 			"Offset" : Rect2(16, 32, 16, 16)
	# 		}
	# 	],
	# 	"Intake" : [
	# 		{ #THIS isn't for collector is just for crafter
	# 			"Position" : Vector2(0,0), #Uses world coords
	# 			"Rotation" : 0, # rotation is in like 0 - 0, 1 - 90, 2 - 180, 3 - 270
	# 			"Type" : 0
	# 		}
	# 	], 
	# 	"Storage" : 50, #Size of container
    #     "Stored" : {}, #Already present liquids like blood barrel
	# 	"Functions" : [ 
	# 		{
	# 			"Name" : "Explosion", #Explodes function wich dosn't yet exist but imagine, also functions can add custom velocity, well will be able to
	# 			"Params" : {
	# 				"Output" : 0 #Where it all explodes to
	# 			}
	# 		},
	# 		{
	# 			"Name" : "Transfer",
	# 			"Params" : {
	# 				"Speed" : 1,
	# 				"Output" : 1
	# 			}
	# 		},
	# 		{
	# 			"Name" : "Collect", #Will have to creat area2d using only script
	# 			"Params" : {
	# 				"Position" : Vector2(0,0)
	# 			}
	# 		}
	# 	],
	# 	"Outputs" : [
	# 		{
	# 			"Position" : Vector2(0,0), #uses world coords for detailed emmision
	# 			"Size" : Vector2(16,16),
	# 			"Velocity" : Vector2(0,0) # gets affected by rotation
	# 		},
	# 		{
	# 			"Position" : Vector2(1,0), #Uses building coords for grid modifications
	# 			"Rotation": 0,
	# 			"Type" : 0 #Used so there can be multiple type pipes/ passes
	# 		}
	# 	]
	# }

	"conveyor": {
		"Name" : "conveyor",
		"Occupied_cells" : [
			Vector2(0,0)
		],
		"Textures" : [
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(0, 0, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(16, 0, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(32, 0, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(48, 0, 16, 16)
			}
		],
		"Intake" : [], 
		"Storage" : 0,
        "Stored" : {},
		"Functions" : [ 
			{
				"Name" : "Push",
				"Params" : {}
			},
			{
				"Name" : "Animation_loop",
				"Params" : {
					"Frames" : [0,1,2,3],
					"Fps" : 1
				}
			}
		],
		"Outputs" : []
	},
	"collector" : {
		"Name" : "collector",
		"Occupied_cells" : [
			Vector2(0,0)
		],
		"Textures" : [
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(0, 16, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(16, 16, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(32, 16, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(48, 16, 16, 16)
			}
		],
		"Intake" : [], 
		"Storage" : 50,
        "Stored" : {},
		"Functions" : [ 
			{
				"Name" : "Collect",
				"Params" : {
					"Position" : Vector2(0,0),
					"Size" : Vector2(0,0),
					"Overfill" : true
				}
			},
			{
				"Name" : "Animation_loop",
				"Params" : {
					"Frames" : [0,1,2,3],
					"Fps" : 1
				}
			},
			{
				"Name" : "Explosion",
				"Params" : {
					"Outputs" : [1]
				}
			},
			{
				"Name" : "Tranfer",
				"Params" : {
					"Outputs" : [0]
				}
			}
		],
		"Outputs" : [
			{
				"Position" : Vector2(1,0),
				"Rotation" : 0,
				"Type" : 0
			},
			{
				"Position" : Vector2(0,0),
				"Size" : Vector2(1,1),
				"Velocity" : Vector2(10,0)
			}
		]
	},
	"emmiter" : {
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
		"Intake" : [], 
		"Storage" : 0,
        "Stored" : {},
		"Functions" : [
			{
				"Name" : "Animation_loop",
				"Params" : {
					"Frames" : [0,1],
					"Fps" : 1
				}
			},
			{
				"Name" : "Emmit",
				"Params" : {
					"Outputs" : [0],
					"Liquids" : [0]
				}
			}
		],
		"Outputs" : [
			{
				"Position" : Vector2(0.4,0),
				"Size" : Vector2(0.2,0.8),
				"Velocity" : Vector2(1,0)
			}
		]
	},
	"fuser" : {
		"Name" : "fuser",
		"Occupied_cells" : [
			Vector2(0,0)
		],
		"Textures" : [
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(32, 32, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(48, 32, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(0, 48, 16, 16)
			}
		],
		"Intake" : [
			{
				"Position" : Vector2(0,0),
				"Rotation" : 0,
				"Type" : 0
			}
		], 
		"Storage" : 50,
        "Stored" : {},
		"Functions" : [
			{
				"Name" : "Craft",
				"Params" : {
					"Craft_recepies" : 0,
					"Speed" : 1,
					"Outputs" : [0],
					"Anim_Default" : 0,
					"Anim_loop" : [1,2]
				}
			}
		],
		"Outputs" : [
			{
				"Position" : Vector2(0.4,0),
				"Size" : Vector2(0.2,0.8),
				"Velocity" : Vector2(1,0)
			}
		]
	},
	"storer" : {
		"Name" : "storer",
		"Occupied_cells" : [
			Vector2(0,0)
		],
		"Textures" : [
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(32, 32, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(48, 32, 16, 16)
			},
			{
				"Path" : "res://Assets/newTiles.png",
				"Offset" : Rect2(0, 48, 16, 16)
			}
		],
		"Intake" : [
			{
				"Position" : Vector2(0,0),
				"Rotation" : 0,
				"Type" : 0
			}
		], 
		"Storage" : 50,
        "Stored" : {},
		"Functions" : [
			{
				"Name" : "Craft",
				"Params" : {
					"Craft_recepies" : 0,
					"Speed" : 1,
					"Outputs" : [0]
				}
			}
		],
		"Outputs" : [
			{
				"Position" : Vector2(0.4,0),
				"Size" : Vector2(0.2,0.8),
				"Velocity" : Vector2(1,0)
			}
		]
	},
	"deletor" : {
		"Name" : "deletor",
		"Occupied_cells" : [],
		"Textures" : [],
		"Intake" : [
			{
				"Path" : "res://Assets/Icons/Delete.png",
				"Offset" : Rect2(0,0,16,16)
			}
		], 
		"Storage" : 0,
        "Stored" : {},
		"Functions" : [],
		"Outputs" : []
	}
	#TODO
	# "rubble"
	# "barrel"
	# "extractor"
	# "assembler"
}
