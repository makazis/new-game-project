extends Node2D

var buildings_name : String
var buildings_dict_name : String
var buildings_id : int
var occupied_cells : Array[Vector2]
var buildings_refrences : Array[String]
var textures : Array[NB_Texture]
var intakes : Array[NB_Intake]
var storage : int
var function : Array[NB_Function]
var outputs : Array[NB_Output]

var follow_mouse : bool

class NB_Output:
    var position : Vector2
    var size : Vector2
    var type : int
    var rotation : int
    var velocity : Vector2
    func _init(in_iter_compress) -> void:
        position = in_iter_compress["Position"]
        if in_iter_compress["Size"]: size = in_iter_compress["Size"]
        if in_iter_compress["Velocity"]: velocity = in_iter_compress["Velocity"]
        if in_iter_compress["Rotation"]: rotation = in_iter_compress["Rotation"]
        if in_iter_compress["Type"]: velocity = in_iter_compress["Type"]

class NB_Function:
    var name : String
    var params : Dictionary
    func _init(in_iter_compress) -> void:
        name = in_iter_compress["Name"]
        params = in_iter_compress["Params"]

class NB_Intake:
    var position : Vector2
    var rotation : int
    var type : int
    func _init(in_iter_compress) -> void:
        position = in_iter_compress["Position"]
        rotation = in_iter_compress["Rotation"]
        type = in_iter_compress["Type"]

class NB_Texture:
    var texture : CompressedTexture2D
    var offset : Rect2
    func _init(in_iter_compress) -> void:
        texture = load(in_iter_compress["Path"])
        offset = in_iter_compress["Offset"]

func initilize(in_building : String):
    var building_init : Dictionary = Buildings.BUILDINGS[in_building]
    buildings_name = building_init["Name"]
    buildings_dict_name = in_building
    buildings_id = Buildings.reserve_spot(self)
    occupied_cells = building_init["Occupied_cells"]
    buildings_refrences = []
    textures = 
    intakes
    storage
    function
    outputs

func place(position, rotation)
#make so dosn't follow cursor or in inventory
#Make it log and add refrences from Buildings.buildings to self and from self to buildings
func destroy()
#handle functions_destroy
#call buildings.gd clear spot

func _process(delta: float) -> void:
    if follow_mouse:
        #Add code to follow mouse
        #add some code to put it in inventory