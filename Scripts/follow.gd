extends TextureRect

@export var camera : Camera2D
var viewport_size = Vector2(640,360)
var oversight = 2
var tileSize = Vector2(80,80)

func moveToCam() -> void:
	position = round((camera.position - viewport_size / 2 / camera.zoom)/80 - Vector2.ONE * oversight)*80

func _process(delta: float) -> void:
	moveToCam()

# func _ready() -> void:
#     get_tree().process_frame.connect(moveToCam)
