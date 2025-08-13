extends Node2D

#Set by buildings.gd
var ID : int

#Set on init
var NAME : String
var CELLS : Array #Occupied cells pre rot
var STORAGE : Dictionary
var POSITION : Vector2 #In building coords
var ROTATION : int #In 0123 where 0 is right 

#Set on place or later
var CELL_POS : Array #Occupied cells after rotation and position

func init(i_params, i_position, i_rotation) -> void:
    NAME = i_params["Name"]
    CELLS = i_params["Occupied_cells"]
    POSITION = i_position
    ROTATION = i_rotation
