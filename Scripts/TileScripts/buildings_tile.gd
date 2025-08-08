extends Node2D

var ID : int
var CELLS : Array[Vector2] #Occupied cells pre rot
var POSITION : Vector2 #In building coords
var ROTATION : int #In 0123 where 0 is right 
var CELL_POS : Array[Vector2] #Occupied cells after rotation and position