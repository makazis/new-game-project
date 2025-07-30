extends Node2D

var buildings_name : String
var buildings_dict_name : String
var buildings_id : int
var occupied_cells : Array[Vector2]
var buildings_refrences : Array[String]
var textures : Array[NB_Texture]
var intakes : Array[NB_Intake]
var storage : int
var functions : Array[NB_Function]
var outputs : Array[NB_Output]

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

func initilize(in_building : String, in_position : Vector2, in_rotation : int) -> void:
    var building_init : Dictionary = Buildings.BUILDINGS[in_building]
    buildings_name = building_init["Name"]
    buildings_dict_name = in_building
    buildings_id = Buildings.reserve_spot(self)
    occupied_cells = building_init["Occupied_cells"]
    buildings_refrences = []
    for iter_texture in in_building["Textures"]:
        textures.append(NB_Texture.new(iter_texture))
    for iter_intake in in_building["Intake"]:
        textures.append(NB_Intake.new(iter_intake))
    storage = in_building["Storage"]
    for iter_functions in in_building["Functions"]:
        functions.append(NB_Function.new(iter_functions))
    for iter_options in in_building["Outputs"]:
        outputs.append(NB_Function.new(iter_options))
    
#make so dosn't follow cursor or in inventory
#Make it log and add refrences from Buildings.buildings to self and from self to buildings
func destroy()
#handle functions_destroy
#call buildings.gd clear spot

func _process(delta: float) -> void:
    if follow_mouse:
        
        #add some code to put it in inventory